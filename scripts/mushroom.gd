extends Area2D
var car = null
var spore = false

func _physics_process(delta: float) -> void:
	if spore:
		car.fuel -= 15*delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Car":
		$Sprite2D2.show()
		$Sprite2D.hide()
		$AnimationPlayer.play('explode')
		body.fuel += 30
		await get_tree().create_timer(1).timeout
		queue_free()


func _on_spore_body_entered(body: Node2D) -> void:
	if body.name == "Car":
		car = body
		spore = true
		

func _on_spore_body_exited(body: Node2D) -> void:
	if body.name == "Car":
		spore = false
