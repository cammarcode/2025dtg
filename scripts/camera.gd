extends Camera2D

var car_speed = 0
var car
var czoom = 1
var zoom_to = 1
var speed
var zchange = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	car = get_parent().find_child("Car")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = car.position
	speed = car.speed
	if speed > 1000:
		zoom_to = 1000/speed
