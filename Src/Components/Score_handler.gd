extends Node

var score:int
var high_score:int

func _ready() -> void:
	var save_file:FileAccess = FileAccess.open("user://save.data",FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
	else:
		save_game()

func submit(endscore:int) -> void:
	score = endscore
	if score > high_score:
		high_score = score
		save_game()

func get_endscore() -> int:
	return score

func get_highscore() -> int:
	return high_score

func save_game() -> void:
	var save_file:FileAccess = FileAccess.open("user://save.data",FileAccess.WRITE)
	save_file.store_32(high_score)
