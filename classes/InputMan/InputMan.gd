class_name InputMan

static func get_axis() -> Vector2:
	var y: float = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	var x: float = Input.get_action_strength("strafeL") - Input.get_action_strength("strafeR")

	var xy: Vector2 = Vector2(x,y)

	return xy
