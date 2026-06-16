extends Camera3D

@export_group("Screen Shake")
@export var shake_decay:float = 1
@export var noise:Noise
@export var noise_speed:float = 50
@export_group("Screen Shake/Limits")
@export var max_x:float = 10
@export var max_y:float = 10
@export var max_z:float = 5

@onready var init_rot:Vector3 = rotation_degrees

var shake:float = 0.0

var time:float = 0.0

func _process(delta: float) -> void:
	time += delta
	shake = maxf(shake - delta * shake_decay,0)
	
	if shake > 0:
		rotation_degrees.x = init_rot.x + max_x * get_shake_intensity() * get_noise_from_seed(0)
		rotation_degrees.y = init_rot.y + max_y * get_shake_intensity() * get_noise_from_seed(1)
		rotation_degrees.z = init_rot.z + max_z * get_shake_intensity() * get_noise_from_seed(2)

func add_shake(power:float) -> void:
	shake = clampf(shake + power,0,1)

func get_shake_intensity() -> float:
	return shake * shake

func get_noise_from_seed(_seed:int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
