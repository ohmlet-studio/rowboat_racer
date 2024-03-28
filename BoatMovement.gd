extends RigidBody2D

# Constants for force magnitude and the distance from the center to apply rowing force.
const FORCE = 50.0
const ROW_OFFSET = 5.0
const TORQUE = 0.0003

func _physics_process(delta):
	var rotation_direction = get_rotation()
	var force_direction = Vector2(0, -FORCE).rotated(rotation_direction) # Negative Y to push "forward"
	var row_offset_vector = Vector2(ROW_OFFSET, 0).rotated(rotation_direction)

	if Input.is_action_pressed("ui_right"):
		apply_impulse(row_offset_vector, force_direction)
		apply_torque_impulse(-TORQUE)
		print("Rowing right")

	if Input.is_action_pressed("ui_left"):
		# Apply force to simulate rowing on the left side of the boat.
		apply_impulse(-row_offset_vector, force_direction)
		# Apply a counterclockwise torque to simulate turning due to rowing on one side.
		apply_torque_impulse(TORQUE)
		print("Rowing left")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Your initialization code here, if any.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Any frame-based processing can go here, if needed.
