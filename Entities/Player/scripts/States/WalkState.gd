extends PlayerState

var speed_delta: float

func Update(delta: float):
	forward = InputMan.get_axis().y
	backward = InputMan.get_axis().x

func Physics_Update(delta: float):
	get_move_direction()

	speed_delta = get_speed_delta(info.WalkSpeed)

	if  rad_to_deg(ground_angle()) < 50:
		info.RigidBody.apply_central_force(get_slope_angle().normalized() * (info.WalkSpeed * speed_delta))
		DebugDraw.draw_arrow_ray(Vector3(0,1,0), get_slope_angle().normalized(), 10)
