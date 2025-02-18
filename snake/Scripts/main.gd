extends Node

var rand_x
var rand_y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene = load("res://Scenes/player.tscn")
	var player = load("res://Scenes/player.tscn").instantiate()
	add_child(player)
	player.position = $StartPosition.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Spawn pellets randomly every 3 seconds
func _on_timer_timeout() -> void:
	spawn_pellet()
	$Timer.wait_time = 3


func spawn_pellet():
	var window_x = get_viewport().size.x
	var window_y = get_viewport().size.y
	var pellet = preload("res://Scenes/pellet.tscn").instantiate()
	var spawn = false
	
	# am i ever gonna make it not overlap?
	rand_x = randf_range(30,window_x - 30)
	rand_y = randf_range(30,window_y - 30)
	pellet.global_position = Vector2(rand_x,rand_y)
	
	add_child(pellet)
