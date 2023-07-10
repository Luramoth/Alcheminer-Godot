extends PlayerState

var speed_delta: float

func Update(delta: float):
	forward = InputMan.get_axis().y
	backward = InputMan.get_axis().x

func Physics_Update(delta: float):
	get_move_direction()

	speed_delta = get_speed_delta(info.WalkSpeed)

	# TODO: not this
	if  1==0:
		info.RigidBody.apply_central_force(get_slope_angle().normalized() * (info.WalkSpeed * speed_delta))
		DebugDraw.draw_arrow_ray(Vector3(0,1,0), get_slope_angle().normalized(), 10)
		print(get_slope_angle().normalized())
		print(move_direction.normalized())
	else:
		info.RigidBody.apply_central_force(move_direction.normalized() * (info.WalkSpeed * speed_delta))
		DebugDraw.draw_arrow_ray(Vector3(0,1,0), move_direction.normalized(), 10)
