class_name Hurtbox_Component
extends Area2D
@export var health_component: Health_Component
func _take_damage(attack:float, hitter: Node) -> void:
	if health_component:
		health_component._damage(attack, hitter)
	
