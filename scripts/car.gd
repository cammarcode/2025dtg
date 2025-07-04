extends CharacterBody2D

const max_speed = 2500.0
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
var fuel = 150
var fuel_max = 150
var fuel_loss_rate = 10 # KiloGallons per second
var boost_cooldown = true
const stupid_number = 0.05
var slide = false
var drift = false
var dead = false
var williamsucksflag = false

func _ready():
	start_pos = position

func angle_to_vector(): # read the function name fuckwad
	velocity_vector = Vector2(sin(angle), -cos(angle))

func _process(delta):
	if Input.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("debug"):
		fuel_max = 100000
		fuel = 100000
	if fuel <= 0:
		dead = true
		get_parent().find_child("death").visible = true
	$CanvasLayer/FuelTank/ColorRect.get_material().set_shader_parameter("level", 1-(fuel/fuel_max))
	fuel -= fuel_loss_rate * delta
	$CanvasLayer/SubViewportContainer.get_material().set_shader_parameter("position", Vector2((stupid_number*position.x/256), (stupid_number*position.y/256))) #0.05 zoom
	print(Vector2((position.x/256)*0.05, (position.y/256)*0.05))

func _physics_process(delta):
	if not dead:
		
		if Input.is_action_pressed("accelerate") and not williamsucksflag:
			prev_speed = speed # for testing
			
			# acceleration is scaled so that its slower at higher speeds
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
		
		if Input.is_action_pressed("turn_left") or fix_spin:  # fix_spin turns the player left for 1 frame lol
			if not drift:
				flag = true
				turn_rate += turn_rate_rate*delta
				turn_rate = clamp(turn_rate, 0, max_turn_rate)
				angle -= turn_rate * delta * speed
				# this code keeps the angle small
				if angle < -2*PI:
					angle += 2*PI
				angle_to_vector()
			else:
				flag = true
				turn_rate += turn_rate_rate*delta
				turn_rate = clamp(turn_rate, 0, max_turn_rate)
				angle += turn_rate * get_angle_to($Node2D.global_position) * speed/5
				if angle > 2*PI:
					angle = 2*PI
				angle_to_vector()
			
		if Input.is_action_pressed("turn_right"):
			if not drift:
				flag = true
				turn_rate += turn_rate_rate*delta
				turn_rate = clamp(turn_rate, 0, max_turn_rate)
				angle += turn_rate * delta * speed
				if angle > 2*PI:
					angle += 2*PI
				angle_to_vector()
			else:
				flag = true
				turn_rate += turn_rate_rate*delta
				turn_rate = clamp(turn_rate, 0, max_turn_rate)
				angle -= turn_rate * get_angle_to($Node2D.global_position) * speed/5
				if angle > 2*PI:
					angle = 2*PI
				angle_to_vector()
		
		if Input.is_action_pressed("boost")and boost_cooldown:
			speed += 1000
			fuel -= 20
			boost_cooldown = false
			$boost_timer.start()
			
		#flag checks if you are turning to reset turn_rate - see above code
		if flag == false:
			turn_rate = 0
		if Input.is_action_pressed("brake"):
			speed -= brake_rate * delta
		#if Input.is_action_pressed("drift"):
			#drift = true
		#if Input.is_action_just_released("drift"):
			#drift = false
		
		if roating:
			angle += delta*PI*10*randf_range(1.5,1.7)
		
		rotation = angle
		# SPEED AND DIRECTION ARE STORED SEPERATELY!!!
		velocity = velocity_vector * speed
		move_and_slide()



func _on_area_2d_body_entered(body):
	if not body.is_in_group('player'):
		if speed >= 0:
			if speed >= 1300:
				$spin_timer.start(0.5)
				speed = -speed/2
				roating = true
			else:
				williamsucksflag = true
		else:
			speed = -speed/2

func _on_spin_timer_timeout() -> void:
	roating = false
	fix_spin = true
	$fix_spin.start(0.1)


func _on_fix_spin_timeout() -> void:
	fix_spin = false


func _on_boost_timer_timeout() -> void:
	boost_cooldown = true


func _on_wintest_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://scenes/wintestwow.tscn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	williamsucksflag = false
