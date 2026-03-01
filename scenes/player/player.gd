class_name Player
extends CharacterBody2D

@export var move_speed: float = 200
@export var dash_speed: float = 800
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.8

@export var dash_vfx : PackedScene

var is_dashing: bool = false
var dash_direction : Vector2 = Vector2.ZERO
var can_dash : bool = true

@onready var dash_cooldown_timer : Timer = $Dash
@onready var horse_sprite: AnimatedSprite2D = $HorseSprite


func _ready() -> void:
	horse_sprite.play("run")
	dash_cooldown_timer.wait_time = dash_cooldown
	dash_cooldown_timer.one_shot = true
	dash_cooldown_timer.timeout.connect(_on_dash_cooldown_finished)


func _physics_process(_delta: float) -> void:
	if not is_dashing:
		handle_movement()


	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()
		
	move_and_slide()


func _on_dash_cooldown_finished() -> void:
	can_dash = true

func handle_movement() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var to_target: Vector2 = mouse_position - global_position
	var stop_distance: float = 8.0

	if to_target.length() <= stop_distance:
		velocity = Vector2.ZERO
		return

	var direction = to_target.normalized()
	velocity = direction * move_speed
	
	if direction.x > 0.01:
		horse_sprite.flip_h = false
	elif direction.x < -0.01:
		horse_sprite.flip_h = true

func start_dash() -> void:
	var mouse_position = get_global_mouse_position()
	var _force_vector = velocity.angle()
	
	is_dashing = true
	can_dash = true
	
	var test = dash_vfx.instantiate()
	test.global_position = position
	add_child(test)
	
	
	dash_direction = (mouse_position - global_position).normalized()
	
	#rotation = dash_direction.angle()
	
	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2.RIGHT
	
	velocity = dash_direction.normalized() * dash_speed
	
	await get_tree().create_timer(dash_duration).timeout
	
	is_dashing = false
	dash_cooldown_timer.start()
	test.queue_free()
