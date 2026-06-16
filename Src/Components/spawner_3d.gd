extends Node3D
class_name Spawner3D

@export var spawned: PackedScene

func _ready() -> void:
	spawn()

func spawn() -> void:
	var spawn_inst: Node3D = spawned.instantiate()
	spawn_inst.global_transform = global_transform
	spawn_inst.connect("dead", _enemy_die)
	get_tree().current_scene.add_child.call_deferred(spawn_inst)

func _enemy_die() -> void:
	await get_tree().create_timer(randf_range(0.05,0.1)).timeout
	spawn()
