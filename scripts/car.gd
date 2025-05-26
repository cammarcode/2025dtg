extends CharacterBody2D

const max_speed = 1500
var velocity_vector = Vector2(0,-1)
var speed = 0 #px/s
var acceleration = 300 #px/s^2
var max_turn_rate = 0.003 #rad/m/s   Maximum turning speed
var turn_rate = 0 #rad/m/s           Current turning speed
var turn_rate_rate = 0.015 #rad/m/s  How quickly turn speed increases
var friction = 500 #px/s^2
var brake_rate = 1400 #px/s^2
var angle = 0
var flag
var prev_speed = 0
var start_pos

func _ready():
	start_pos = position

func angle_to_vector():
	velocity_vector = Vector2(sin(angle), -cos(angle))


func _physics_process(delta):
	if Input.is_action_pressed("accelerate"):
		print(speed-prev_speed)
		prev_speed = speed
		
		
		speed += acceleration * delta * ((500/(clamp(speed, 0, max_speed)+500)) + 1) 
		speed = clamp(speed, -max_speed/2,max_speed)
	else:
		if abs(speed) <= friction*delta*2:
			speed = 0
		if speed > 0:
			speed -= friction*delta
			speed = clamp(speed, 0, max_speed)
		elif speed < 0:
			speed += friction*delta
			speed = clamp(speed, -max_speed/2, 0)
	flag = false
	if Input.is_action_pressed("turn_left"):
		flag = true
		turn_rate += turn_rate_rate*delta
		turn_rate = clamp(turn_rate, 0, max_turn_rate)
		angle -= turn_rate * delta * speed
		if angle < -2*PI:
			angle += 2*PI
		angle_to_vector()
	if Input.is_action_pressed("turn_right"):
		flag = true
		turn_rate += turn_rate_rate*delta
		turn_rate = clamp(turn_rate, 0, max_turn_rate)
		angle += turn_rate * delta * speed
		if angle > 2*PI:
			angle += 2*PI
		angle_to_vector()
	if flag == false:
		turn_rate = 0
	if Input.is_action_pressed("brake"):
		speed -= brake_rate * delta
		
	rotation = angle
	velocity = velocity_vector * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	position = start_pos
	speed = 0
	velocity_vector = Vector2(0,-1)
	angle = 0
	rotation = 0
