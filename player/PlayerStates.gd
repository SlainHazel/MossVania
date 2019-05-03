class Idle:
	var player: Player
	func _init(p: Player): player = p

	# Called on state entered
	func enter():
		player.horizontal_damping = 0.2

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event: InputEvent):
		if event.is_action_pressed("left"):
			player.change_state("Walk")
		if event.is_action_pressed("jump"):
			player.change_state("JumpCharge")

	# Handle physics
	func update(delta):
		print("State: Idle")
		if not player.is_on_floor():
			player.change_state("Air")

class Walk:
	var player: Player

	func _init(p: Player): player = p

	# Called on state entered
	func enter():
		pass

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event):
		pass

	# Handle physics
	func update(delta):
		print("State: Walk")

class JumpCharge:
	var player: Player
	func _init(p: Player): player = p

	# Called on state entered
	func enter():
		pass

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event):
		pass

	# Handle physics
	func update(delta):
		print("State: JumpCharge")

class Air:
	var player: Player
	var airtime

	func _init(p: Player): player = p

	# Called on state entered
	func enter():
		player.horizontal_damping = 0.8

	# Called on state exited
	func exit():
		pass

	# Handle Input
	func input(event):
		pass

	# Handle physics
	func update(delta):
		print("State: Air")
		airtime += delta
		if player.is_on_floor():
			airtime = 0
			player.change_state("Idle")
		player.velocity.y += player.gravity * delta