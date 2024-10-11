extends "res://scripts/entity.gd"

@onready var AnimPlayer = $AnimationPlayer
@onready var nav_agent = $NavigationAgent3D


var target_player: CharacterBody3D
func _physics_process(delta: float) -> void:
	if target_player != null:
		update_target_location(target_player)
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	
	var direction = (next_location - current_location).normalized()
	velocity = direction * speed
	
	move_and_slide()

func update_target_location(target):
	nav_agent.target_position = target.global_position
	
func _ready() -> void:
	AnimPlayer.play("Walk")
	add_to_group("enemy")
	
	health = 10

func _on_timer_timeout() -> void:
	if target_player != null and (global_position - target_player.global_position).length() <= 5:
		target_player.damage(1)

func _on_player_detect_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		target_player = body


func _on_player_exit_zone_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		target_player = null
		nav_agent.target_position = global_position
