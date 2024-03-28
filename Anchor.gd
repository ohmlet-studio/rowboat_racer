extends Node2D

var boat: Node2D
var anchor_l: Node2D
var anchor_r: Node2D

var anchor_l_offset: Vector2 = Vector2(-150, 0)
var anchor_r_offset: Vector2 = Vector2(150, 0)

func _ready():
	anchor_l = find_child("Anchor_L")
	anchor_r = find_child("Anchor_R")
	boat = find_child("Boat")
	update_anchors()

func update_anchors():
	# Update position based on the boat's current position and rotation
	anchor_l.global_position = boat.global_position + anchor_l_offset.rotated(boat.rotation)
	anchor_r.global_position = boat.global_position + anchor_r_offset.rotated(boat.rotation)
	
	# Optionally, if the anchors should also match the boat's rotation:
	anchor_l.rotation = boat.rotation
	anchor_r.rotation = boat.rotation
	

func rotate_boat_around_anchor(anchor: Node2D, angle: float):
	var boat_global_position = boat.global_position
	var anchor_global_position = anchor.global_position
	var direction = boat_global_position - anchor_global_position
	direction = direction.rotated(angle)
	boat.global_position = anchor_global_position + direction
	boat.rotation += angle


func _process(delta):
	if Input.is_action_just_released("ui_right"):
		print("right")
		rotate_boat_around_anchor(anchor_r, 0.1)
		update_anchors()

	if Input.is_action_just_released("ui_left"):
		print("left")
		rotate_boat_around_anchor(anchor_l, -0.1)
		update_anchors()
