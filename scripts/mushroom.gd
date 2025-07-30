extends Area2D
var car = null
var spore = false
var health = 2000

func _physics_process(delta: float) -> void:
	if spore:
		car.fuel -= 15*delta
	if health <= 0:
			$Sprite2D2.show()
			$Sprite2D.hide()
			$AnimationPlayer.play('explode')
			if car.fuel >= car.fuel_max:
				car.fuel = car.fuel_max
			else:
				car.fuel += 60*delta
			await get_tree().create_timer(1).timeout
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Car":
			health -= body.speed
			if health > 0:
				body.speed = -body.speed/2


func _on_spore_body_entered(body: Node2D) -> void:
	if body.name == "Car":
		car = body
		spore = true
		

func _on_spore_body_exited(body: Node2D) -> void:
	if body.name == "Car":
		spore = false
