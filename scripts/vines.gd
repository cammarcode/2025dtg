extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Car":
		if body.speed >= 1000:
			if body.fuel+ 50 >= body.fuel_max:
				body.fuel = body.fuel_max
			else:
				body.fuel += 50
			queue_free()
