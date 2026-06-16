extends CanvasLayer

var ispaused:bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		ispaused = !ispaused
		get_tree().paused = ispaused
		if ispaused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			visible = true
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			visible = false
