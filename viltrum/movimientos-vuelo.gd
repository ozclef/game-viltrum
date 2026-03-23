var velocity = Vector3.ZERO

var normal_speed = 10
var boost_speed = 45

var accel = 3
var boost_accel = 6
var brake = 8

func _physics_process(delta):

	var input_dir = Vector3.ZERO
	
	input_dir.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	input_dir.y = Input.get_action_strength("up") - Input.get_action_strength("down")
	input_dir.z = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	
	var h_rot = rotation.y # <- seguro, sin errores
	input_dir = input_dir.rotated(Vector3.UP, h_rot).normalized()
	
	var target_speed = normal_speed
	var accel_use = accel
	
	# 🚀 BOOST
	if Input.is_action_pressed("sprint"):
		target_speed = boost_speed
		accel_use = boost_accel
	
	# movimiento
	if input_dir != Vector3.ZERO:
		var target_velocity = input_dir * target_speed
		velocity = velocity.linear_interpolate(target_velocity, delta * accel_use)
	else:
		# 💥 frenado fuerte
		velocity = velocity.linear_interpolate(Vector3.ZERO, delta * brake)
	
	move_and_slide(velocity, Vector3.UP)
