extends CharacterBody3D

@onready var AnimPlayer = $AnimationPlayer
var health = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AnimPlayer.play("Walk")
	add_to_group("enemy")
 # Replace with function body.

func hit(damage):
	health -= damage
	print("Health: " + str(health))
	if health <= 0:
		death()
	
func death():
	queue_free()
