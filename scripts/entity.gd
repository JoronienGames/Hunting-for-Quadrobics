extends CharacterBody3D

var health: int = 10
var speed: int = 10

func damage(count):
	health -= count
	print("Health: " + str(health))
	if health <= 0:
		death()

func death():
	queue_free()
