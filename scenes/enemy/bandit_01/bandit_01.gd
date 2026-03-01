extends EnemyBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.is_dashing:
		defeat()
	elif body:
		direction = -direction
