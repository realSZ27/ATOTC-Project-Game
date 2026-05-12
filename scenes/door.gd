extends Node2D

@export var countdown_duration := 4.0 # how long the door takes to open, in ship seconds
var start_time := -1.0

func lights():
	if Global.tasks_done == 1:
		$Lights/Task.color = Color.GREEN
	elif Global.tasks_done == 2:
		$Lights/Task.color = Color.GREEN
		$Lights/Task2.color = Color.GREEN
	elif Global.tasks_done == 3:
		$Lights/Task.color = Color.GREEN
		$Lights/Task2.color = Color.GREEN
		$Lights/Task3.color = Color.GREEN
		$CollisionShape2D.disabled = true

func _process(delta):
	lights()
	if Global.countdown_active:
		var elapsed := Global.ship_time - start_time
		var time_left: int = max(countdown_duration - elapsed, 0)
		$Label.text = str(int(time_left)) + "s"
		
		if time_left <= 0:
			Global.countdown_active = false
			open_door()

func _on_detection_area_area_entered(area: Area2D):
	if not Global.countdown_active:
		start_time = Global.ship_time
		Global.countdown_active = true
		$Label.visible = true
	
func open_door():
	
	if Global.tasks_done == 3:
		$CollisionShape2D.disabled = true
		$Label.text = "OPEN"
	else:
		$Label.text = "CLOSED"
