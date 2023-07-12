extends State
class_name PlayerState

@export var speed_mult: float = 100

var forward: float
var backward: float
var move_direction: Vector3

var info: MoveInfo

func PEnter(move_info: MoveInfo):
	self.info = move_info
	self.Enter()

func Update(_delta: float):
	forward = InputMan.get_axis().y
	backward = InputMan.get_axis().x

func Physics_Update(_delta: float):
	get_move_direction()

func get_move_direction():
		move_direction = (info.CameraOrientation.transform.basis.z * forward) + (info.CameraOrientation.transform.basis.x * backward)

func on_slope() -> bool:
	if info.SlopeRay.is_colliding():
		var angle: float = Vector3.UP.angle_to(info.GroundCast.get_collision_normal(0))
		return angle != 0
	return false

## returns the angle of the ground in radians
func ground_angle() -> float:
	return Vector3.UP.angle_to(info.GroundCast.get_collision_normal(0))

func get_slope_angle() -> Vector3:
	# im leaving all this here as a memorial to my struggles
	#var slope_angle: float = Vector3.UP.angle_to(info.GroundCast.get_collision_normal(0)) # rotation still doesent work but i may be on to somthing
	#var oldplane: Vector3 = move_direction.rotated(info.GroundCast.get_collision_normal(0), slope_angle) if move_direction.length() > 0 else Vector3.ZERO

	# i spent so long trying to make my own project to plane method only to find it already exists ;-;
	return Plane(info.GroundCast.get_collision_normal(0)).project(move_direction)

func on_ground() -> bool:
	if info.GroundCast.is_colliding():
		if ground_angle() < info.MaxSlope:
			return true
		else:
			return false
	return false

func get_speed_delta(moveSpeed: float) -> float:
	return clamp(remap(info.RigidBody.linear_velocity.length(), 0, moveSpeed, speed_mult, 0),0, speed_mult)

func sloped_move_player(moveSpeed: float):
	if rad_to_deg(ground_angle()) < info.MaxSlope:
		info.RigidBody.apply_central_force(get_slope_angle().normalized() * (moveSpeed * get_speed_delta(moveSpeed)))

func move_player(moveSpeed: float):
	info.RigidBody.apply_central_force(move_direction.normalized() * (moveSpeed * get_speed_delta(moveSpeed)))
