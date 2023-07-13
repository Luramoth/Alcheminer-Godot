extends PlayerState

@onready var timer: Timer = $Timer

func Enter():
	if info.CanJump == true:
		timer.start()

func Exit():
	timer.stop()

func Physics_Update(delta: float):
	super(delta)

	if Input.is_action_just_pressed("jump") && info.CanJump == true:
		info.CanJump = false
		jump()

	if !on_ground():
		move_player()
	else:
		Transition.emit(self, "WalkState")

func _on_timer_timeout():
	info.CanJump = false
