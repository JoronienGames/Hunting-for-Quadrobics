extends CharacterBody3D

var speed = 10
var runSpeed = 25
var jump : float = 60
var gravity = -100
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
	
	if Input.is_action_pressed("Run"):
		velocity.x = lerp(velocity.x, direction.x * runSpeed, delta * acceleration)
		velocity.z = lerp(velocity.z, direction.y * runSpeed, delta * acceleration)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * acceleration)
		velocity.z = lerp(velocity.z, direction.y * speed, delta * acceleration)

	if !is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotation.x -= deg_to_rad(event.relative.y * sensivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
		rotation.y -= deg_to_rad(event.relative.x * sensivity)
