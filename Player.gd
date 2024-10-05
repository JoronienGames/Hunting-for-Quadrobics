extends CharacterBody3D

var speed = 10
var runSpeed = 25
var jump : float = 60
var gravity = -100
var acceleration = 7

var patrons = 10
var max_patrons = 10

var sensivity = 0.5

var health = 20

@onready var head = $Head
@onready var ray = $Head/Camera3D/RayCast3D

var direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Move and jump
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

	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump
	
	# Gravity
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	# Shoot
	if Input.is_action_just_pressed("Fire"):
		shoot()
	
	if Input.is_action_just_pressed("Reload"):
		reload()
		
func shoot():
	if patrons != 0:
		if ray.is_colliding():
			var object = ray.get_collider()
			if object.is_in_group("enemy"):
				object.damage(1)
		patrons -= 1
		print("Patrons: " + str(patrons))

func reload():
	patrons = max_patrons
	print("Reload")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotation.x -= deg_to_rad(event.relative.y * sensivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
		rotation.y -= deg_to_rad(event.relative.x * sensivity)

func damage(count):
	health -= count
	print("Health: " + str(health))
	if health <= 0:
		death()
	
func death():
	queue_free()
