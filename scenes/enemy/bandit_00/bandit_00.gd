extends EnemyBase

enum EnemyStates {IDLE, RUN, ATTACK}

var state : EnemyStates = EnemyStates.IDLE
var can_swing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$ChangeState.start()
	$AttackRange.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		EnemyStates.IDLE:
			$Sprite2D.frame = 0
		EnemyStates.RUN:
			super(delta)
		EnemyStates.ATTACK:
			$AnimationPlayer.play("enemy_anim/lasso")


func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.is_dashing:
		defeat()
	elif body:
		direction = -direction


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body is Player and can_swing:
		body.emit_damage()
		can_swing = false
		state = EnemyStates.RUN


func _on_change_state_timeout() -> void:
	if state == EnemyStates.IDLE:
		state = EnemyStates.RUN
	else:
		can_swing = true
		state = EnemyStates.ATTACK
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enemy_anim/lasso":
		state = EnemyStates.IDLE

func _on_direction_timer_timeout() -> void:
	if scale.x == -1.0:
		scale.x = 1.0
	else:
		scale.x = -1.0
	$DirectionTimer.start(randf_range(2.1, 51))
