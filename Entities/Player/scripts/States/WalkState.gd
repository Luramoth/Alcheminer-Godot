extends PlayerState

var speed_delta: float

func Enter():
	info.CanJump = true

func Physics_Update(delta: float):
	super(delta)

	if Input.is_action_just_pressed("jump") && info.CanJump == true:
		info.CanJump = false
		jump()
		Transition.emit(self, "AirState")

	if on_ground():
		sloped_move_player()
	else:
		Transition.emit(self, "AirState")
