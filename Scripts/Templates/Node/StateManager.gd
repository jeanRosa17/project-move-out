extends Node


var ranTests:bool = false

## Runs the Assert.runTestsOn function on the first _process frame
func _process(_delta:float) -> void:
	if (not ranTests): 
		Assert.runTestsOn(self, self.get_script().source_code)
		self.ranTests = true

func before_each() -> void:
	pass

func after_each() -> void:
	pass
	
func test_() -> void:
	pass
