class Ground:
	var player: Player
	func _init(p): player = p

	# Called on state entered
	func enter():
		player.horizontal_damping = 0.05
		player.snap = Vector2(0,6)
		player.gravity = 2000
		
		player.animation.play("stand")
		print("Ground")

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event: InputEvent):
		if event.is_action_pressed("jump"):
			player.change_state("Jump")

	# Handle physics
	func update(delta):
		if not player.is_on_floor():
			player.change_state("Air")
		
		var walk = 0
		if Input.is_action_pressed("right"):
			player.direction = "right"
			walk += player.WALK_SPEED
		if Input.is_action_pressed("left"):
			player.direction = "left"
			walk -= player.WALK_SPEED
		if walk != 0:
			player.animation.play("walk")
			player.velocity.x = walk
		else:
			player.animation.play("stand")

class Air:
	var player: Player
	func _init(p): player = p

	# Called on state entered
	func enter():
		player.horizontal_damping = 0.9
		player.snap = Vector2(0,6)
		player.gravity = 200
		
		player.animation.play("air")
		print("Air")

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event):
		pass

	# Handle physics
	func update(delta):
		player.animation.play("air")
		if player.is_on_floor():
			player.change_state("Ground")
		
		if Input.is_action_pressed("left"):
			player.velocity.x -= player.WALK_SPEED * delta
		if Input.is_action_pressed("right"):
			player.velocity.x += player.WALK_SPEED* delta

class Jump:
	var player: Player
	func _init(p): player = p
	
	var height

	# Called on state entered
	func enter():
		player.horizontal_damping = 0.9
		player.snap = Vector2(0,0)
		player.gravity = 200
		
		player.animation.play("jump")
		height = player.position.y - player.JUMP_HEIGHT
		player.velocity.y = -player.JUMP_SPEED

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event):
		pass

	# Handle physics
	func update(delta):
#		if player.position.y > height:
#			player.velocity.y = -player.JUMP_SPEED

		if player.velocity.y > 0 or player.is_on_ceiling():
			player.change_state("Air")