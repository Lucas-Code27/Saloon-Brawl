extends Node
class_name DamageComponent

signal attacked

@export var player:bool

@export var Has_Hitbox:bool
@export var hitboxes:Array[Area3D]

@export_group("Stats")
@export var damage:int = 1
@export var hitstopdur:float = 0.1

@export var damaging:bool = false

func _ready() -> void:
	if Has_Hitbox:
		for hitbox:Area3D in hitboxes:
			hitbox.body_entered.connect(_on_hit)

func _on_hit(body:Node3D) -> void:
	if damaging and body.has_node("HealthComponent"):
		var hpcomp:HealthComponent = body.get_node("HealthComponent")
		hpcomp.hurt(damage)
		if player:
			AudioManager.play("hit",randf_range(0.9,1.1))
		else:
			AudioManager.play("enemyhurt",randf_range(0.9,1.1))
		damaging = false
		attacked.emit()
		HitstopManager.hitstop(hitstopdur)
