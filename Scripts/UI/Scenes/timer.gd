extends Node2D

@onready var label = $Label
@onready var timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	

func time_left_until_end():
	var time_left = max(timer.time_left, 0)
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _process(delta: float) -> void:
	label.text = "%02d:%02d" % time_left_until_end()

func _on_timer_timeout():
	# %HUD.setDialogueTo(DialogueTag.new().create("res://Narrative/GenericDialogue.txt", "endLevel"))
	%HUD.checkResults()
