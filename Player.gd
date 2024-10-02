extends CharacterBody3D

var speed = 10
var jump = 5
var acceleration = 7

var sensivity = 0.5

@onready var head = $Head

var direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	direction = Vector2(0,0)
	
	if Input.is_action_pressed("MoveForward"):
		direction.y -= 1
	if Input.is_action_pressed("MoveBack"):
		direction.y += 1
	if Input.is_action_pressed("MoveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("MoveRight"):
		direction.x += 1
	
	direction = direction.normalized().rotated(-rotation.y)
	
	velocity.x = lerp(velocity.x, direction.x * speed, delta * acceleration)
	velocity.z = lerp(velocity.z, direction.y * speed, delta * acceleration)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotation.x -= deg_to_rad(event.relative.y * sensivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
		rotation.y -= deg_to_rad(event.relative.x * sensivity)
