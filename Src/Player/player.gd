extends CharacterBody3D

const SPEED: int = 2
const SENSITIVITY: float = 0.004

@onready var head: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var hurter: DamageComponent = $Neck/Camera3D/CanvasLayer/SubViewportContainer/SubViewport/armcam/arms/DamageComponent
@onready var animplayer: AnimationPlayer = $Neck/Camera3D/CanvasLayer/SubViewportContainer/SubViewport/armcam/arms/AnimationPlayer
@onready var armcam: Camera3D = $Neck/Camera3D/CanvasLayer/SubViewportContainer/SubViewport/armcam

var canpunch: bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animplayer.play("Idleanim")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		#camera.rotate_x(-event.relative.y * SENSITIVITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(40))

func _process(_delta: float) -> void:
	armcam.global_transform = camera.global_transform

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= get_gravity().y * delta
	
	if Input.is_action_just_pressed("punch") and canpunch:
		canpunch = false
		AudioManager.play("swing",randf_range(0.9,1.1))
		animplayer.play("Punch")
	
	var look_dir: float = Input.get_axis("lookright","lookleft")
	head.rotate_y(look_dir * 0.1)
	
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 3.0)
	move_and_slide()

func _on_health_component_die() -> void:
	get_tree().current_scene.end_game()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().call_deferred("change_scene_to_file","res://Src/Levels/DeathScreen.tscn")

func _on_health_component_hit() -> void:
	$Neck/Camera3D.add_shake(1)

func _on_damage_component_attacked() -> void:
	$Neck/Camera3D.add_shake(0.6)

func _on_health_component_low_health() -> void:
	$Neck/Camera3D/CanvasLayer/ColorRect.visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Punch":
		canpunch = true
		animplayer.play("Idleanim")
