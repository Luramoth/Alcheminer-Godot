extends Node3D


@onready var rb: RigidBody3D = $"../PlayerBody"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position = rb.position
