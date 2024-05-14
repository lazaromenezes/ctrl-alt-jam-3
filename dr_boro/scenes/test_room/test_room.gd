extends Node2D

func _on_player_shot(power):
	$Shots.add_child(power)
