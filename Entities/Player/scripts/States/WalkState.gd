extends PlayerState

var speed_delta: float

func Physics_Update(delta: float):
	super(delta)

	if on_ground():
		sloped_move_player()
	else:
		Transition.emit(self, "AirState")
