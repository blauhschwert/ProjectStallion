class_name Player
extends CharacterBody2D

signal take_damage

@export var move_speed: float = 200
@export var dash_speed: float = 400
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.4
@export var stop_distance: float = 4.0

@export var dash_vfx : PackedScene

var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.RIGHT
var facing_direction: Vector2 = Vector2.RIGHT
var can_dash: bool = true

@onready var dash_cooldown_timer : Timer = $Dash
@onready var horse_sprite: AnimatedSprite2D = $HorseSprite
@onready var shadow_sprite: Sprite2D = $Shadow


func _ready() -> void:
	_play_animation("idle")
	dash_cooldown_timer.wait_time = dash_cooldown
	dash_cooldown_timer.one_shot = true
	dash_cooldown_timer.timeout.connect(_on_dash_cooldown_finished)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()

	if not is_dashing:
		handle_movement()

	move_and_slide()


func _on_dash_cooldown_finished() -> void:
	can_dash = true

func handle_movement() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var to_target: Vector2 = mouse_position - global_position

	if to_target.length() <= stop_distance:
		velocity = Vector2.ZERO
		_play_animation("idle")
		return

	var movement_direction: Vector2 = to_target.normalized()
	facing_direction = movement_direction
	velocity = movement_direction * move_speed
	_update_facing(movement_direction)
	_play_animation("run")

func start_dash() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var dash_vfx_instance: Node2D = dash_vfx.instantiate()
	var requested_direction: Vector2 = (mouse_position - global_position).normalized()

	if requested_direction == Vector2.ZERO:
		requested_direction = facing_direction

	dash_direction = requested_direction
	facing_direction = dash_direction
	is_dashing = true
	can_dash = false
	velocity = dash_direction * dash_speed
	_update_facing(dash_direction)
	_play_animation("dash")

	dash_vfx_instance.global_position = position
	add_child(dash_vfx_instance)

	await get_tree().create_timer(dash_duration).timeout

	is_dashing = false
	velocity = Vector2.ZERO
	dash_cooldown_timer.start()
	_play_animation("idle")
	dash_vfx_instance.queue_free()

func emit_damage() -> void:
	take_damage.emit()

func _update_facing(direction: Vector2) -> void:
	if direction.x > 0.01:
		horse_sprite.flip_h = false
		shadow_sprite.flip_h = false
	elif direction.x < -0.01:
		horse_sprite.flip_h = true
		shadow_sprite.flip_h = true


func _play_animation(animation_name: StringName) -> void:
	if horse_sprite.animation == animation_name and horse_sprite.is_playing():
		return

	horse_sprite.play(animation_name)
