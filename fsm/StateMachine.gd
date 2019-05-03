extends Node

export (NodePath) var INITIAL_STATE
var current_state

func _ready():
	current_state = get_node(INITIAL_STATE)
	current_state.state_enter()

func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func change_state(new_state):
	current_state.state_exit()
	current_state = get_node(new_state)
	current_state.state_enter()