extends Control

@export var NextScene:PackedScene

func _ready() -> void:
	$AnimationPlayer.play("fade_in_out")

func end_fade() -> void:
	get_tree().change_scene_to_packed(NextScene)
