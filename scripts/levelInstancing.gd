extends Node2D

var level : int = Globals.selectedLevel
var levelString : String = str(level) + ".tscn"

func _ready() -> void:
	# Get the level scene
	level = Globals.selectedLevel
	levelString = str(level) + ".tscn"
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
		zonesArea.body_entered.connect(on_delivery_area_entered.bind(deliveriesIndex))

func on_delivery_area_entered(body, area):
	if body.name == "Car":
		# Set current delivery area invisible
		var areaInstance = self.get_node("level").get_node("deliveries").get_node(str(area))
		areaInstance.visible = false
		areaInstance.find_child("area").monitoring = false
		# Find the next delivery area
		var nextAreaInstance = area + 1
		nextAreaInstance = self.get_node("level").get_node("deliveries").get_node(str(nextAreaInstance))
		if nextAreaInstance == null:
			# Get the player to go back to the starting area
			pass
		else:
			# Make next delivery location visible
			nextAreaInstance.visible = true
			nextAreaInstance.find_child("area").monitoring = true
