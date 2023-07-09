extends PlayerState

var speed_delta: float

func Update(delta: float):
	forward = InputMan.get_axis().y
	backward = InputMan.get_axis().x

func Physics_Update(delta: float):
	get_move_direction()

	speed_delta = get_speed_delta(info.WalkSpeed)

	if on_slope():
		info.RigidBody.apply_central_force(get_slope_angle().normalized() * (info.WalkSpeed * speed_delta))
	else:
		info.RigidBody.apply_central_force(move_direction.normalized() * (info.WalkSpeed * speed_delta))
