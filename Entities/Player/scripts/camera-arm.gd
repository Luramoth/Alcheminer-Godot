extends Node3D


@onready var rb: RigidBody3D = $"../PlayerBody"
@onready var pitch: Node3D = $"camera-pitch"

var sensY:float = 0.2
var sensX:float = 0.2

var xrot: float

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(-1 * deg_to_rad(event.relative.x) * sensX)

		xrot -= deg_to_rad(event.relative.y) * sensY

		xrot = clampf(xrot, deg_to_rad(-80), deg_to_rad(80))

		pitch.rotation.x = xrot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = rb.position

	if Input.is_action_pressed("cam shift"):
		pitch.position.x = lerp(pitch.position.x, -1.5, delta * 25)
	else:
		pitch.position.x = lerp(pitch.position.x, 0.0, delta * 25)
