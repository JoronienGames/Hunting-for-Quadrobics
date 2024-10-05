extends CharacterBody3D

@onready var AnimPlayer = $AnimationPlayer
@onready var nav_agent = $NavigationAgent3D
var health = 10
var speed = 10
func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	
	var direction = (next_location - current_location).normalized()
	velocity = direction * speed
	
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _ready() -> void:
	AnimPlayer.play("Walk")
	add_to_group("enemy")

func damage(count):
	health -= count
	print("Health: " + str(health))
	if health <= 0:
		death()
	
func death():
	queue_free()
