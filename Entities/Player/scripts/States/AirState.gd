extends PlayerState

func Physics_Update(delta: float):
	super(delta)

	if !on_ground():
		move_player(info.WalkSpeed)
	else:
		Transition.emit(self, "WalkState")
