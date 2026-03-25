extends Furniture

func packInBox() -> void:
	get_tree().call_group("Possessed Item", "unpossess_and_replace")
	super.packInBox()
