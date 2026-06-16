extends Control

@export var game_scene:PackedScene

@onready var play: Button = $Play

func _ready() -> void:
	play.grab_focus()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_button_2_pressed() -> void:
	get_tree().quit()
