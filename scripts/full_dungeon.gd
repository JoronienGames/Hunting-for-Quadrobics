extends Node3D

var c = 2
@export var start_room : room

@export var rooms : Array[Resource]

func _ready() -> void:
	start_room.next_room_generation(10, rooms)
