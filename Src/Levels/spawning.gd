extends Node3D

var score:int = 0

func _ready() -> void:
	pass

func add_score(amount:int) -> void:
	score += amount

func get_score() -> int:
	return score

func end_game() -> void:
	ScoreHandler.submit(score)
