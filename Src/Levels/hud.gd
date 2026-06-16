extends Control

var score:int = 0
var health:int = 5

@onready var scorehandle:Node3D = get_tree().current_scene
@export var player:CharacterBody3D

func _on_timer_timeout() -> void:
	score = scorehandle.get_score()
	health = player.get_node("HealthComponent").Health
	$ColorRect/Label.text = str(score)
	$ColorRect/Label4.text = str(health)
