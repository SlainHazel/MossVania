extends KinematicBody2D
class_name Player

export (int) var WALK_SPEED = 60
export (int) var JUMP_HEIGHT = 8
export (int) var JUMP_SPEED = 80
export (int) var MAX_FALL_SPEED = 200

onready var animation = $AnimationPlayer

var gravity = 200
var horizontal_damping = 0.2
var direction = "left"
var velocity = Vector2(80, -100)
var snap = Vector2(0,6)

var states = {}
var state_stack = []

func _ready():
	var PlayerStates = load("res://player/PlayerStates.gd")
	states = {
		"Ground": PlayerStates.Ground.new(self),
		"Air": PlayerStates.Air.new(self),
		"Jump": PlayerStates.Jump.new(self),
	}
	state_stack.push_front(states["Ground"])

func _process(delta):
	if direction == "left":
		$Sprite.flip_h = true
	else: $Sprite.flip_h = false

func _physics_process(delta):
	state_stack[0].update(delta)
	
	if velocity.y < MAX_FALL_SPEED:
		velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, snap, Vector2(0,-1))
	
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