extends Area2D


@onready var game_manager: Node = %GameManager
@onready var coin_animation: AnimationPlayer = $CoinAnimation


func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_coin()
	coin_animation.play("pickup_coin")
