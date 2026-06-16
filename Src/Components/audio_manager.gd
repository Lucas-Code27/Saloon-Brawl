extends Node

var activeaudiostream:AudioStreamPlayer

@export_group("Main")
@export var clips:Node

func play(sound:String,pitch:float) -> void:
	activeaudiostream = clips.get_node(sound)
	activeaudiostream.pitch_scale = pitch
	activeaudiostream.play()
