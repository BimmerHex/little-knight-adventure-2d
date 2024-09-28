extends Node


var coin = 0

@onready var coin_label: Label = $CoinLabel


func add_coin() -> void:
	coin += 1
	coin_label.text = "You collected " + str(coin) + " coins."
