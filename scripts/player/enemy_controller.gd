extends Node2D


const SPEED = 60

var direction = 1

@onready var enemy_ray_cast_right: RayCast2D = $EnemyRayCastRight
@onready var enemy_ray_cast_left: RayCast2D = $EnemyRayCastLeft
@onready var enemy_sprite: AnimatedSprite2D = $EnemySprite


func _process(delta: float) -> void:
	if enemy_ray_cast_right.is_colliding():
		direction = -1
		enemy_sprite.flip_h = true
	if enemy_ray_cast_left.is_colliding():
		direction = 1
		enemy_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
