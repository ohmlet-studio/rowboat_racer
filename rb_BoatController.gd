extends Node2D

var ROWING_FORCE = 0.7
var MAX_SPEED = 3

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
	var boat_gp = boat.global_position
	
	var anchor_velocity = max(abs(anchor_l.angular_velocity), abs(anchor_r.angular_velocity))
	anchor_l.angular_velocity = sign(anchor_l.angular_velocity) * anchor_velocity
	anchor_r.angular_velocity = sign(anchor_r.angular_velocity) * anchor_velocity
	
	anchor_l.global_position = boat.global_position + anchor_l_offset.rotated(boat.global_rotation)
	anchor_r.global_position = boat.global_position + anchor_r_offset.rotated(boat.global_rotation)
	boat.global_position = boat_gp
	
	
func rotate_boat_around_anchor(anchor: Node2D, speed: float):
	var boat_gp = boat.global_position;
	var boat_gr = boat.global_rotation;
	var anchor_gp = anchor.global_position;

	boat.get_parent().remove_child(boat)
	anchor.add_child(boat)
	
	boat.global_position = boat_gp
	boat.global_rotation = boat_gr
	
	anchor.angular_velocity += speed
	
	anchor.angular_velocity = sign(anchor.angular_velocity) * min(abs(anchor.angular_velocity), MAX_SPEED)
	
	update_anchors()


func _process(delta):
	
	if Input.is_action_just_released("ui_right"):
		rotate_boat_around_anchor(anchor_r, ROWING_FORCE)
	
	if Input.is_action_just_released("ui_left"):
		rotate_boat_around_anchor(anchor_l, -ROWING_FORCE)
	
