class StateTemplate:
	var subject
	func _init(s): subject = s

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
		pass