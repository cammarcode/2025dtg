extends Control

var levelSelectButton = preload("res://scenes/level_select_button.tscn")

var levels = {
	1: "scenes/mapOne.tscn",
}

func _on_play_button_pressed() -> void:
	$main.visible = false
	$levelSelect.visible = true

func _ready() -> void:
	for level in levels:
		print(level)
		var levelButton = levelSelectButton.instantiate()
		$levelSelect/GridContainer/GridContainer.add_child(levelButton)
		levelButton.text = " " + str(level)
		levelButton.pressed.connect(on_level_selected.bind(level))
		levelButton.set_meta(str(level), level)
		
func on_level_selected(button):
	Globals.selectedLevel = button
	get_tree().change_scene_to_file(levels[button]) #change scene to map


func _on_ls_back_button_pressed() -> void:
	$main.visible = true
	$levelSelect.visible = false
