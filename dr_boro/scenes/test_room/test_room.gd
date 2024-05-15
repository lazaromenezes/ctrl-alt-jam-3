extends Node2D

func _ready():
	$UI.health = $Player.health
	$UI.power = $Player.max_shots

func _on_player_shot(power):
	$Shots.add_child(power)
	$UI.power -= 1

func _on_player_charged(power):
	$UI.power = power
