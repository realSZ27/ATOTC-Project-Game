extends Node

var earth_time := 0.0
var earth_pos := Vector2(0, 0)

var ship_time := 0.0
var ship_pos := Vector2(80, 128)

var tasks_done := 0
var countdown_active := false

var ingame := false

enum { SHIP, EARTH }
var current_scene = EARTH

func _process(delta):
	if ingame:
		if current_scene == EARTH:
			earth_time += delta
			ship_time += delta / 5
		else:
			ship_time += delta
			earth_time += delta * 5

func reset():
	earth_time = 0.0
	ship_time = 0.0
	earth_pos = Vector2(0, 0)
	ship_pos = Vector2(80, 128)
	tasks_done = 0
	current_scene = EARTH
	ingame = false
