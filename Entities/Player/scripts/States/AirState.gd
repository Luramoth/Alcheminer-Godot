extends PlayerState

func Physics_Update(delta: float):
	super(delta)

	move_player(info.WalkSpeed)
