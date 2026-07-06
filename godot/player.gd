extends CharacterBody3D

@export var speed: float = 3.5
@export var sprint_multiplier: float = 1.6
@export var mouse_sensitivity: float = 0.12
@export var look_limit_degrees: float = 85.0
@export var interact_distance: float = 2.5

var velocity: Vector3 = Vector3.ZERO
var yaw: float = 0.0
var pitch: float = 0.0

onready var cam: Camera3D = $Camera3D
onready var ray: RayCast3D = $Camera3D/RayCast3D

func _ready():
    # For mobile build Input.set_mouse_mode will be visible by default; we still capture for desktop testing
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    ray.target_position = Vector3(0, 0, -interact_distance)

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        yaw -= event.relative.x * mouse_sensitivity
        pitch -= event.relative.y * mouse_sensitivity
        pitch = clamp(pitch, -look_limit_degrees, look_limit_degrees)
        rotation_degrees.y = yaw
        cam.rotation_degrees.x = pitch
    elif event is InputEventScreenTouch:
        # simple tap to interact
        if event.pressed:
            _try_interact()
    elif event is InputEventKey:
        if event.pressed and event.keycode == Key.ESCAPE:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
    # Movement: supports keyboard or InputMap virtual joystick
    var input_vec = Vector2.ZERO
    input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vec.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
    var dir = Vector3.ZERO
    var basis = global_transform.basis
    if input_vec.length() > 0:
        dir = -basis.z * input_vec.y + basis.x * input_vec.x
        dir.y = 0
        dir = dir.normalized()

    var current_speed = speed * (Input.is_action_pressed("sprint") ? sprint_multiplier : 1.0)
    velocity.x = dir.x * current_speed
    velocity.z = dir.z * current_speed

    if not is_on_floor():
        velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
    else:
        velocity.y = 0

    velocity = move_and_slide(velocity, Vector3.UP)

    # Interaction hint handling (could be connected to UI)
    ray.force_raycast_update()
    if ray.is_colliding():
        var obj = ray.get_collider()
        if obj and obj.has_method("interact_hint"):
            obj.interact_hint(true)

func _input(event):
    if event.is_action_pressed("interact"):
        _try_interact()

func _try_interact():
    ray.force_raycast_update()
    if ray.is_colliding():
        var obj = ray.get_collider()
        if obj and obj.has_method("interact"):
            obj.interact(self)

# Helper to expose player state to NPCs / quest system
func get_player_state() -> Dictionary:
    return {"position": global_transform.origin, "inventory": []}
