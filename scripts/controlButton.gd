extends Button


@export var action = ""

func _ready():
	print("0")
	set_process_unhandled_key_input(false)
	display_key()

func display_key():
	print("1")
	var textToDisplay = InputMap.action_get_events(action)[0].as_text().split(" ", false)
	text = textToDisplay[0]

func _on_toggled(button_pressed):
	print("2")
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = ". . ."
	else:
		display_key()
		
func _unhandled_key_input(event):
	print("3")
	remap_key(event)
	self.button_pressed = false

func remap_key(event):
	print("4")
	if toggled:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		text = "%s" % event.as_text()
