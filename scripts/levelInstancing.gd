extends Node2D

func _ready() -> void:
	var level : int = Globals.selectedLevel
	var levelString : String = str(level) + ".tscn"
	print("Instancing level " + levelString)
	var loadLevel = load("res://scenes/levels/" + levelString)
	var levelInstance = loadLevel.instantiate()
	levelInstance.name = "level"
	add_child(levelInstance)
