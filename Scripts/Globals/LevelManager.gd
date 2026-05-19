extends ColorRect

signal progress_changed(progress:float) ## Emits every time the an
signal load_finished

var loadingScreen:PackedScene
var loadedResource:PackedScene
var scenePath:String
var progress: Array = []
var useSubThreads: bool = true ## Loads the scene on a seperate Thread. If game crashes, set to false.

var loadInProgress:bool = false

func _ready() -> void:
	set_process(false)


enum Transitions {
	FADE,
	CIRCLE,
	STAR
}

const FADE_TRANSITION = preload("uid://cmrsdowthgkib")
const CIRCLE_TRANSITION = preload("uid://dnx65kt5siyol")



## Plays a loadingScreen animation and emits a signal when the animation is done. Afterwards,
## the given scenePath is loaded.
func loadScene(_scenePath:String, transition:LevelManager.Transitions = Transitions.FADE) -> void:
	self.scenePath = _scenePath
	
	loadInProgress = true
	match transition:

		Transitions.FADE:
			var newLoadScreen:Node = FADE_TRANSITION.instantiate()
			self.add_child(newLoadScreen)
			progress_changed.connect(newLoadScreen._on_progress_changed)
			load_finished.connect(newLoadScreen._on_load_finished)
			await newLoadScreen.loading_screen_ready
		Transitions.CIRCLE:
			var newLoadScreen:Node = CIRCLE_TRANSITION.instantiate()
			self.add_child(newLoadScreen)
			progress_changed.connect(newLoadScreen._on_progress_changed)
			load_finished.connect(newLoadScreen._on_load_finished)
			await newLoadScreen.loading_screen_ready
	
	startLoad()
	loadInProgress = false

## Sends a reques to the ResourceLoader to load self.scenePath on a thread if self.useSubThreads == true.
func startLoad() -> void:
	var state:Error = ResourceLoader.load_threaded_request(self.scenePath, "", useSubThreads)
	
	if state == Error.OK:
		set_process(true)

## While set_process is true, it will return the ThreadLoadStatus of self.secenePath.
func _process(_delta: float) -> void:
	var loadStatus:ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(self.scenePath, progress)
	self.progress_changed.emit(self.progress[0]) ## the percent value of the loading process
	
	match loadStatus:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			self.loadedResource = ResourceLoader.load_threaded_get(self.scenePath)
			get_tree().change_scene_to_packed(loadedResource)
			load_finished.emit()

#var tween:Tween = null
#@export var duration:float = 1.5
#@export var delay:float = 1.0
#@onready var level_manager: LevelManager = $"."
#
#func _ready() -> void:
	#level_manager.modulate.a = 1.0
	#tween = null
	#tween = get_tree().create_tween()
	#tween.tween_property(self, "modulate:a", 0.0, duration).from(1.0).set_delay(delay)
#
#
#func changeSceneTo(filePath:StringName) -> void:
	#tween = null
	#tween = get_tree().create_tween()
	#tween.tween_property(self, "modulate:a", 1.0, duration).from(0.0).set_delay(0.3)
	#tween.tween_callback(get_tree().change_scene_to_file.bind(filePath))
