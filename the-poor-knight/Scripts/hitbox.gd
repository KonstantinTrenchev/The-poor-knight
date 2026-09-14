class_name Hitbox
extends Area2D
@export var  attack_damage: = 1

func _init() -> void:
	area_entered.connect(_on_area_entered)



func _on_area_entered(area: Area2D) -> void:
	var hitter = get_parent().get_groups()[0]
	var hittee = area.get_parent().get_groups()[0]
	if area is Hurtbox_Component and hitter!=hittee:
		print("%s hit %s" %[hitter,hittee])
		area._take_damage(attack_damage)
