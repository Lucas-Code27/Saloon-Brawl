extends CanvasLayer

var ispaused:bool = false

@onready var h_slider: HSlider = $HSlider

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		ispaused = !ispaused
		get_tree().paused = ispaused
		if ispaused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			visible = true
			h_slider.grab_focus()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			visible = false
