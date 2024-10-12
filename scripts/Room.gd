extends Node3D

class_name room

@export var marker : Marker3D
func next_room_generation(c: int, res: Array[Resource]) -> void:
	if c > 0:
		var next_room = res[randi() % res.size()]
		
		var nroom : Node3D = next_room.instantiate()
		
		get_parent().add_child(nroom)
		
		nroom.position = marker.global_position
		nroom.rotation = marker.global_rotation
		nroom.next_room_generation(c-1, res)
