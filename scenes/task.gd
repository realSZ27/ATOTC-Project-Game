extends StaticBody2D

func _on_area_2d_area_entered(area):
	if Global.countdown_active:
		$Label.visible = true
		Global.tasks_done += 1
