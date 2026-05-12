extends Control

func _on_button_pressed():
	Global.ingame = true
	get_tree().change_scene_to_file("res://scenes/earth.tscn")
