extends Node
class_name HealthComponent

# Signals
signal died
signal hit
signal health_low

# Vars
@export_group("Stats")
@export var max_health: int
var health: int

func _ready() -> void:
	health = max_health

func hurt(damage: int) -> void:
	health -= damage
	
	hit.emit()
	
	if health == 1:
		health_low.emit()
	
	if health <= 0:
		died.emit()
