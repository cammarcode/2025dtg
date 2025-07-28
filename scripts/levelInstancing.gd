extends Node2D

func _ready() -> void:
	# Get the level scene
	var level : int = Globals.selectedLevel
	var levelString : String = str(level) + ".tscn"
	print("Instancing level " + levelString)
	# Instance the level scene
	var loadLevel = load("res://scenes/levels/" + levelString)
	var levelInstance = loadLevel.instantiate()
	levelInstance.name = "level"
	add_child(levelInstance)
	# Instancing delivery zones
	var deliveriesIndex = 0
	for zone in levelInstance.find_child("deliveries").get_children():
		# Make all zones but first one invisible and not monitor
		deliveriesIndex += 1
		var zonesArea = zone.find_child("area")
		if deliveriesIndex > 1:
			zone.visible = false
			zonesArea.monitoring = false
		# Connect area detect function
		print("Connecting function")
		zonesArea.body_entered.connect(on_delivery_area_entered.bind(deliveriesIndex))

func on_delivery_area_entered(body, area):
	if body.name == "Car":
		# 
		pass
