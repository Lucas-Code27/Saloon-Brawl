extends Node
class_name HealthComponent

# Signals
signal Die
signal Hit
signal Low_health

# Vars
@export_group("Stats")
@export var Max_Health:int
var Health:int

func _ready() -> void:
	Health = Max_Health

# Taking Damage
func Hurt(damage:int) -> void:
	if not Health <= 0:
		Hit.emit()
		Health -= damage
		
		if Health == 1:
			Low_health.emit()
		
		# Checking for death
		if Health <= 0:
			Die.emit()
