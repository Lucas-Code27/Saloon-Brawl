extends Control


func _ready() -> void:
	$Label2.text = "Score: " + str(ScoreHandler.get_endscore())
	$Label3.text = "High Score: " + str(ScoreHandler.get_highscore())
	$Button.grab_focus()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Src/Levels/Saloon.tscn")
