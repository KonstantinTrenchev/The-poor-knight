extends Area2D
func  _ready() -> void:
	add_to_group("coins")
func _on_body_entered(_body: Node2D) -> void:
	queue_free()
	remove_from_group("coins")
	print("Coin collected, coins remaining: %d" % get_tree().get_node_count_in_group("coins"))
