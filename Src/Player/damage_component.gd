extends Node
class_name DamageComponent

signal attacked

@export var player:bool

@export var hurt_ray: RayCast3D

@export_group("Stats")
@export var damage:int = 1
@export var hitstopdur:float = 0.1

func attack() -> void:
	if hurt_ray.is_colliding():
		var body: Node3D = hurt_ray.get_collider()
		print(body.name)
		
		if body.has_node("HealthComponent"):
			var hpcomp: HealthComponent = body.get_node("HealthComponent")
			hpcomp.hurt(damage)
			
			if player:
				AudioManager.play("hit",randf_range(0.9,1.1))
			else:
				AudioManager.play("enemyhurt",randf_range(0.9,1.1))
			
			attacked.emit()
			HitstopManager.hitstop(hitstopdur)
