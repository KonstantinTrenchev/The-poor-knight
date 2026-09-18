class_name Hitbox
extends Area2D
@export var  attack_damage: = 1
@export var	knockback = Vector2.ZERO
func _init() -> void:
	area_entered.connect(_on_area_entered)



func _on_area_entered(area: Area2D) -> void:
	var  hitter = get_parent()
	var  hittee = area.get_parent()
	if area is Hurtbox_Component:
		if hitter != get_tree().current_scene:
			print("%s hit %s" %[hitter.name,hittee.name])
			hittee.global_position += Vector2(hitter.direction * 15, 0)
		area._take_damage(attack_damage)
		
