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
	$settings.visible = false
	$keybinds.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	$main.visible = false
	$settings.visible = true


func _on_volume_slider_value_changed(value: float, bus : String) -> void:
	var busIndex = AudioServer.get_bus_index(bus)
	if value == -30:
		AudioServer.set_bus_mute(busIndex, true)
	else:
		AudioServer.set_bus_volume_db(busIndex, value)
		AudioServer.set_bus_mute(busIndex, false)


func _on_keybinds_button_pressed() -> void:
	$settings.visible = false
	$keybinds.visible = true


func _on_keybinds_back_button_pressed() -> void:
	$keybinds.visible = false
	$settings.visible = true
