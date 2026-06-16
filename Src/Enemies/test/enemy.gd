extends CharacterBody3D

signal dead

@onready var player: CharacterBody3D = get_tree().current_scene.get_node("Player")

@export var hurter: DamageComponent
@export var armanim: AnimationPlayer
@export var animtree: AnimationTree

@export_group("stats")
@export var followrange: float
@export var speedmult: float

@export_group("Texture")
@export var normalmat: ShaderMaterial
@export var flashmat: ShaderMaterial

@onready var nav: NavigationAgent3D = $NavigationAgent3D

@onready var state_machine: AnimationNodeStateMachinePlayback = animtree["parameters/state/playback"]

@export var attacking: bool = false
var canattack: bool = true
var alive: bool = true
var stunned: bool = false

@onready var scorehandle: Node3D = get_tree().current_scene

func _ready() -> void:
	state_machine.start("idle")
	$Mesh/Armature/Skeleton3D/Cube.set("surface_material_override/0",normalmat)
	nav.target_position = player.global_position

func _physics_process(_delta: float) -> void:
	if not alive:
		return
	
	if global_position.distance_to(player.global_position) < followrange:
		
		if canattack == true and !stunned and $HealthComponent.health != 0:
			canattack = false
			state_machine.travel("attack")
			animtree.set("parameters/Blend2/blend_amount",0)
			await get_tree().create_timer(1.09).timeout
			state_machine.travel("idle")
			$Timer.start()
	elif global_position.distance_to(player.global_position) > followrange:
		animtree.set("parameters/Blend2/blend_amount",1)
		nav.target_position = player.global_position
		
		var next_point: Vector3 = nav.get_next_path_position()
		var direction: Vector3 = (next_point - global_position).normalized()
		
		velocity = direction * speedmult
		
		move_and_slide()
		
	look_at(Vector3(player.position.x, global_position.y, player.position.z), Vector3.UP)
	
	#if self.velocity.length() < 1:
		#velocity += Vector3.LEFT * 100


func _on_health_component_died() -> void:
	collision_layer = 0
	$Timer.stop()
	animtree.set("parameters/Blend2/blend_amount",0)
	canattack = false
	stunned = true
	alive = false
	attacking = false
	$Mesh/AnimationTree.active = false
	$Mesh/AnimationPlayer.play("Death")
	# scorehandle.add_score(100) old score system
	scorehandle.add_score(randi_range(50,200))
	await $Mesh/AnimationPlayer.animation_finished
	dead.emit()
	queue_free()

func _on_timer_timeout() -> void:
	canattack = true

func flash() -> void:
	$Mesh/Armature/Skeleton3D/Cube.set("surface_material_override/0",flashmat)
	await get_tree().create_timer(0.15,true,false,true).timeout
	$Mesh/Armature/Skeleton3D/Cube.set("surface_material_override/0",normalmat)

func _on_health_component_hit() -> void:
	flash()
	if not attacking and state_machine.get_current_node() != "Death" and $HealthComponent.health > 0:
		state_machine.travel("hit")
		stunned = true
		await get_tree().create_timer(1.09).timeout
		stunned = false
		state_machine.travel("idle")
