extends CharacterBody2D

@export var speed = 1000
@export var rotation_speed = 3

var marker_list = Array()
@export var segment_list = Array()
@export var gap: int = 50
@export var segment_speed = 5

var rotation_direction = 0

signal eat

func _ready() -> void:
	_on_eat()

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func _process(delta):
	var pos = self.global_position
	var rot = self.global_rotation
	UpdateMarkerList(pos,rot)
	
	var index = 0
	for s in segment_list:
		#var point = marker_list[clamp(index * gap, 0, marker_list.size() - 1)]

		# Move body towards the point along the snakes path
		s.global_position = marker_list[clampf(gap + (gap * index), 0, marker_list.size() - 1)][0]

		# Rotate body towards the point along the snakes path
		s.global_rotation = marker_list[clampf(gap + (gap * index), 0, marker_list.size() - 1)][1]

		index += 1
		print(s.global_position, self.global_position)


func UpdateMarkerList(p,r):
	marker_list.insert(0, [p,r])


func ClearMarkerList():
	marker_list = Array()


func get_input():
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	velocity = -(transform.y * speed)

#emit eat signal and clear food
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("collectables"):
		eat.emit()
		print("nom")
		area.queue_free()

#grow snake on eat
func _on_eat() -> void:
	var segment = (load("res://Scenes/snake_segment.tscn")).instantiate()
	add_child(segment)
	segment_list.append(segment)
	print('ate')
