extends CharacterBody3D

@export var max_health : int = 10
@export var speed: int = 10
var health: int

func _ready() -> void:
	health = max_health

func _process(delta: float) -> void:
	if health > max_health:
		health = max_health

func damage(count):
	health -= count
	print("Health: " + str(health))
	if health <= 0:
		death()

func death():
	queue_free()
