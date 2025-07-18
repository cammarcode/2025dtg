extends Camera2D

var car
var czoom = 1
var zoom_to = 1
var speed = 1
var zchange = 0.1
var a = 2000
# Called when the node enters the scene tree for the first time.
func _ready():
	car = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = car.speed
	if speed > 1000:
		zoom_to = 1 + (speed/a)
	else:
		zoom_to = 1
	if czoom < zoom_to:
		czoom += zchange*delta
		czoom = clamp(czoom,1,zoom_to)
	elif czoom > zoom_to:
		czoom -= zchange*delta*0.5
		czoom = clamp(czoom,zoom_to,2)
	zoom = Vector2(1/czoom,1/czoom)
