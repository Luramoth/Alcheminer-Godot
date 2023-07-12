extends PlayerState

func Physics_Update(delta: float):
	super(delta)

	if !on_ground():
		move_player()
	else:
		Transition.emit(self, "WalkState")
