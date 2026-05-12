extends CharacterBody2D

var speed := 4000
@onready var delta_scene := 0.0

func _ready():
	if Global.current_scene == Global.EARTH:
		position = Global.earth_pos
	else:
		position = Global.ship_pos

func _process(delta: float) -> void:
	#Global.update_time(delta)

	if Global.current_scene == Global.SHIP:
		$CanvasLayer/Control/MarginContainer2/Label.text = "T+" + String.num(Global.ship_time, 1) + "s"
	else:
		$CanvasLayer/Control/MarginContainer2/Label.text = "T+" + String.num(Global.earth_time, 1) + "s"
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	move_and_slide()

	if Input.is_action_just_pressed("change"):
		change()

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		$"CanvasLayer/Control/Virtual Joystick".visible = true
	else:
		$"CanvasLayer/Control/Virtual Joystick".visible = false

func _on_button_pressed():
	change()

func change():
	if Global.current_scene == Global.SHIP:
		Global.current_scene = Global.EARTH
		Global.ship_pos = position
		get_tree().change_scene_to_file("res://scenes/earth.tscn")
	else:
		Global.current_scene = Global.SHIP
		Global.earth_pos = position
		get_tree().change_scene_to_file("res://scenes/spaceship.tscn")
