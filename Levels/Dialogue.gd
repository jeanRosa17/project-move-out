class_name DialogueManager
extends Label

## File path to the Dialogue script
@export var dialogueScriptPath: StringName = "res://Narrative/SampleText.txt"
var dialogueTag: StringName = "couch" ## The tag of text within the dialogueScript

var dialogueScript: String ## The file contents of the dialogueScriptPath
var lineCounter: int = 0 ## the current line within the dialogue tag
var charCounter: int ## the current character within the current line
var timer: Timer ## timer for typewriting effect
var textSpeed: float = 0.025
const endOfLineDelay: float = 0.75 ## seconds to delay at the end of line
const punctuationsDelay = {
	"." : 0.3,
	"?" : 0.3,
	"!" : 0.3,
	"," : 0.25,
	";" : 0.25,
	":" : 0.25
}


@warning_ignore("untyped_declaration")
var jumpToTag = null
var currentTagFinished: bool
var quitting: bool = false

## Immediately begins dialogue if the self.dialogueScriptPath is valid.
func _ready() -> void:

	self.timer = Timer.new()
	self.add_child(self.timer)
	self.timer.timeout.connect(nextChar)
	self.timer.one_shot = true

	# Check if dialogue file exists
	if not FileAccess.file_exists(self.dialogueScriptPath):
		Exception.new("Given Dialogue Script does not exist")
	else:
		#self.startDialogue()
		pass

## Sets the dialogue tag and script to the one given in the dTag. It then 
## starts the DialogueManager using those
func setDialogueTo(dTag:DialogueTag) -> void:
	if (dTag == null):
		Exception.new("dTag is set to null.")
	
	self.dialogueScriptPath = dTag.dialogueScriptPath
	self.dialogueTag = dTag.dialogueTag
	self.startDialogue()

#region Dialogue Controls (Start, Restart, )
## Begins the dialogue sequence
func startDialogue() -> void:
	self.dialogueScript = FileAccess.get_file_as_string(self.dialogueScriptPath)
	self.text = ""
	self.lineCounter = 0
	self.charCounter = 0
	self.currentTagFinished = false
	self.parseCommandsInLine()

## Restarts dialogue back to the very beginning of the current script tag.
func resetDialogueBranch() -> void:
	print("resetting Dialogue Branch")
	self.timer.stop()
	self.startDialogue()

## Looks through the current line and parses out the nametags, options, interruptions,
## and emotions commands. At the end calls nextChar and passes the line of 
## dialogue with no commands within it.
func parseCommandsInLine() -> void:
	var current_line:String = self.getCurrentLine()
	
	if current_line == "":
		assert(false, "Current line is empty.")
	
	if (self.isLineQuit(current_line)):
		self.quitting = true
	
	if (self.isLineJumping(current_line)): 
		self.handleJumpTo(current_line)
	
	#self.timer.timeout.connect(nextChar)
	if (self.timer.is_stopped()):
		self.nextChar()
	

func removeAllCommandsFromCurLine() -> String:
	var result: String = self.getCurrentLine(true)
	
	if (self.isLineQuit(result)): result = result.replace("$quit", "")
	
	if (self.isLineJumping(result)): result = result.split("$jumpto ")[0]
	
	return result

## Appends the next character in the current line. Once the line ends, 
## the end of line timer calls nextLine(). It also constantly checks if the
## last word in the current text is a key identifer for a interruption.
func nextChar() -> void:
	var line:String = self.removeAllCommandsFromCurLine()
	if line == "": return
	
	var atEndOfLine: bool = charCounter >= line.length()

	if (atEndOfLine):
		self.timer.stop()
		var endTimer: Timer = Timer.new()
		
		if (self.jumpToTag != null):
			self.dialogueTag = self.jumpToTag.split("@")[0]
			
			@warning_ignore("narrowing_conversion")
			if (self.jumpToTag.split("@").size() == 1): self.lineCounter = 0
			else: self.lineCounter = int(self.jumpToTag.split("@")[1]) - 1
			self.charCounter = 0
			self.jumpToTag = null
	
			endTimer.timeout.connect(parseCommandsInLine)
			endTimer.one_shot = true; self.add_child(endTimer)
			endTimer.start(endOfLineDelay)
			return
		if (self.quitting): 
			self.timer.timeout.connect(self.get_tree().quit)
			self.timer.start(1.0)
			return
		
		endTimer.timeout.connect(Callable(self, "nextLine").bind(endTimer))
		endTimer.one_shot = true; self.add_child(endTimer)
		endTimer.start(endOfLineDelay)
		return
	
	var nextCharHelper: Callable = func (_textSpeed:float) -> void: 
		self.text = line.left(charCounter)
		self.timer.start(_textSpeed)
	
	self.charCounter += 1
	var _nextChar: String = line.left(charCounter).right(1)
	
	if (self.punctuationsDelay.has(_nextChar)):
		nextCharHelper.call(self.punctuationsDelay[_nextChar])
	else:
		nextCharHelper.call(self.textSpeed)

## Moves the dialogue to the next line of text within the current dialogueTag.
## Game softlocks if the counter + 1 is greater than the lines within the current tag
func nextLine(lineTimer: Timer) -> void:
	var lines:PackedStringArray = self.getDialogueFromTag(self.dialogueTag)
	
	if (self.lineCounter + 1 >= lines.size()):
		print("Reached end of dialogue for tag: ", self.dialogueTag)
		self.currentTagFinished = true
		return
	
	self.lineCounter += 1
	self.charCounter = 0
	if not (self.timer.is_connected("timeout", self.parseCommandsInLine)):
		self.timer.timeout.connect(self.parseCommandsInLine)
	self.timer.start(self.endOfLineDelay)
	
	if (lineTimer != null):
		self.remove_child(lineTimer)
		lineTimer.queue_free()

func isLineQuit(line: String) -> bool:
	return line.find("$quit") != -1

#endregion

#region Jumping Code

func isLineJumping(line: String) -> bool:
	return line.find("$jumpto ") != -1 and line.split("$jumpto ").size() > 0

func handleJumpTo(line: String) -> void:
	self.jumpToTag = line.split("$jumpto ")[1].strip_edges()
	print("Jumping to: ", jumpToTag)

#endregion

#region Dialogue Tag/Script Getters
func getCurrentLine(excludeNameTag:bool = false) -> String:
	var lines:PackedStringArray = getDialogueFromTag(dialogueTag)
	if lineCounter < 0 or lineCounter >= lines.size():
		print("Error: lineCounter out of bounds. LineCounter: ", lineCounter, " Total Lines: ", lines.size())
		return ""

	var current_line:String = lines[lineCounter]
	
	if (excludeNameTag):
		if ((current_line.find(": ") < 10) and (current_line.find(": ") != -1)):
			return current_line.split(": ")[1]
		
	return current_line

## Returns the branch of Dialogue within the self.dialogueScript based on the
## given tag.
func getDialogueFromTag(tag: String) -> PackedStringArray:
	var result: PackedStringArray = PackedStringArray()
	
	if (dialogueScript.find("#" + tag + " {") == -1):
		print("Error: Tag not found: ", tag)
		return result

	var temp: String = dialogueScript.split("#" + tag + " {")[1]
	var temp2: String = temp.replace("\t", "").split("}")[0]
	temp2 = temp2.strip_edges()

	var lines: Array = temp2.split("\n")
	
	for line:String in lines:
		if (line.strip_edges() != ""):
			result.append(line.strip_edges())

	#print("Parsed lines for tag [", tag, "]: ", result)
	return result

func getTotalLinesInTag(tag: String) -> int:
	return getDialogueFromTag(tag).size()
#endregion
