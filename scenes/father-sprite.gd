extends AnimatedSprite2D

# I LOVE JANK CODE 😁
var last_action := "down"
@onready var daughter := $"../DaughterSprite"

func _input(event):
	for action in ["right", "left", "up", "down"]:
		if event.is_action_pressed(action):
			last_action = action
			
func determine_sprite():
	if Global.current_scene == Global.EARTH:
		visible = false
		daughter.visible = true
	else:
		visible = true
		daughter.visible = false

func _process(_delta):
	determine_sprite()
	
	var moving := false

	# If the last_action is still being held, animate movement
	if Input.is_action_pressed(last_action):
		_play_action(last_action)
		moving = true
	else:
		# if another key is pressed, update to that
		for action in ["right", "left", "up", "down"]:
			if Input.is_action_pressed(action):
				last_action = action
				_play_action(action)
				moving = true
				break

	# If nothing is held, idle on first frame of last_action
	if not moving:
		_play_action(last_action)
		frame = 0
		daughter.frame = 0
		pause()
		daughter.pause()

func _play_action(action: String):
	match action:
		"right":
			offset.y = 1.2
			daughter.offset.y = 12
			flip_h = false
			daughter.flip_h = true
			play("father side")
			daughter.play("daughter side")
		"left":
			offset.y = 1.2
			daughter.offset.y = 12
			flip_h = true
			daughter.flip_h = false
			play("father side")
			daughter.play("daughter side")
		"up":
			offset.y = 5
			daughter.offset.y = 12
			play("father up")
			daughter.play("daughter up")
		"down":
			offset.y = -3
			daughter.offset.y = 12
			play("father down")
			daughter.play("daughter down")
