extends CharacterBody3D

@onready var AnimPlayer = $AnimationPlayer
@onready var nav_agent = $NavigationAgent3D
var health = 10
var speed = 10
var target_player
func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	
	var direction = (next_location - current_location).normalized()
	velocity = direction * speed
	
	move_and_slide()

func update_target_location(target):
	nav_agent.target_position = target.global_position
	target_player = target

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


func _on_timer_timeout() -> void:
	if (global_position - target_player.global_position).length() <= 5:
		target_player.damage(1)
