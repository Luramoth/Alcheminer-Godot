extends Node

@export_group("Data")
@export var PWalkSpeed: int = 7
@export var PRunSpeed: int = 12
@export var PJumpPower: int = 10

@export var PMaxSlope:float = 50

@export_group("Resorces")
@export var initial_state: PlayerState

var info: MoveInfo
var current_state: PlayerState
var states: Dictionary = {}

func _ready():
	info = MoveInfo.new()

	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)

	if initial_state:
		initial_state.PEnter(info)
		current_state = initial_state

	info.WalkSpeed = PWalkSpeed
	info.RunSpeed = PRunSpeed
	info.JumpPower = PJumpPower
	info.MaxSlope = PMaxSlope
	info.RigidBody = $"../PlayerBody"
	info.CameraOrientation = $"../camera-yaw"
	info.GroundCast = $"../PlayerBody/GroundCast"

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state: PlayerState, new_state_name: String):
	if state != current_state:
		return

	var new_state: PlayerState = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.Exit()

	new_state.PEnter(info)

	current_state = new_state
	print("transitioned to: " + new_state_name)
