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

func get_move_direction():
		move_direction = (info.CameraOrientation.transform.basis.z * forward) + (info.CameraOrientation.transform.basis.x * backward)

func on_slope() -> bool:
	if info.SlopeRay.is_colliding():
		var angle: float = Vector3.UP.angle_to(info.SlopeRay.get_collision_normal())
		return angle != 0
	return false

func get_slope_angle() -> Vector3:
	var plane: Vector3 = info.SlopeRay.get_collision_normal().rotated(Vector3.RIGHT, -PI/2).rotated(Vector3.FORWARD, PI/4).project(move_direction)
	return plane

func get_speed_delta(moveSpeed: float) -> float:
	return clamp(remap(info.RigidBody.linear_velocity.length(), 0, moveSpeed, speed_mult, 0),0, speed_mult)
