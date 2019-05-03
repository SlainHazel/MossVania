extends KinematicBody2D
class_name Player

export (int) var MAX_FALL_SPEED

var gravity = 200
var horizontal_damping = 0.2
var velocity = Vector2()
var snap = Vector2(0,12)

var states = {}
var state_stack = []

func _ready():
	var PlayerStates = load("res://player/PlayerStates.gd")
	states = {
		"Idle": PlayerStates.Idle.new(self),
		"Walk": PlayerStates.Walk.new(self),
		"JumpCharge": PlayerStates.JumpCharge.new(self),
		"Air": PlayerStates.Air.new(self),
	}
	state_stack.push_front(states["Idle"])

func _physics_process(delta):
	state_stack[0].update(delta)
	
	velocity = move_and_slide_with_snap(velocity, snap, Vector2(0,-1),
		true, 4, 0.523599, true)
	
	velocity.x *= pow(horizontal_damping, delta*4)

func _input(event):
	state_stack[0].input(event)

func push_state(state):
	state_stack[0].exit()
	state_stack.push_front(states[state])
	state_stack[0].enter()

func pop_state():
	state_stack.pop_front().exit()

func change_state(state):
	pop_state()
	state_stack.push_front(states[state])
	state_stack[0].enter()