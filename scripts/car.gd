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
var roating = false
var fix_spin = false

func _ready():
	start_pos = position

func angle_to_vector(): # read the function name fuckwad
	velocity_vector = Vector2(sin(angle), -cos(angle))


func _physics_process(delta):
	if Input.is_action_pressed("accelerate"):
		#print(speed-prev_speed)
		prev_speed = speed # for testing
		
		# acceleration is scaled so that its slower at higher speeds
		# decrease funny number to slow more
		speed += acceleration * delta * ((300/(clamp(speed, 0, max_speed)+300)) + 1) 
		speed = clamp(speed, -max_speed/2,max_speed)
	else:
		# This section does max speeds and stopping
		if abs(speed) <= friction*delta*2:
			speed = 0
		if speed > 0:
			speed -= friction*delta
			speed = clamp(speed, 0, max_speed)
		elif speed < 0:
			speed += friction*delta
			speed = clamp(speed, -max_speed/2, 0)
	flag = false
	
	if Input.is_action_pressed("turn_left") or fix_spin: # fix_spin turns the player left for 1 frame lol
		flag = true
		turn_rate += turn_rate_rate*delta
		turn_rate = clamp(turn_rate, 0, max_turn_rate)
		angle -= turn_rate * delta * speed
		# this code keeps the angle small
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
		
	#flag checks if you are turning to reset turn_rate - see above code
	if flag == false:
		turn_rate = 0
	if Input.is_action_pressed("brake"):
		speed -= brake_rate * delta
	
	if roating:
		angle += delta*PI*10*randf_range(1.9,2.1)
	
	rotation = angle
	# SPEED AND DIRECTION ARE STORED SEPERATELY!!!
	velocity = velocity_vector * speed
	move_and_slide()
	
	


func _on_area_2d_body_entered(body):
	if not body.is_in_group('player'):
		if speed >= 1600:
			$spin_timer.start(0.5)
			roating = true
		speed = -speed/2
		

func _on_spin_timer_timeout() -> void:
	roating = false
	fix_spin = true
	$fix_spin.start(0.1)


func _on_fix_spin_timeout() -> void:
	fix_spin = false
