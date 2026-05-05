extends Node

@export var stamp_scene: PackedScene

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			for doc in get_tree().get_nodes_in_group("documents"):
				if doc.is_open and doc.get_global_rect().has_point(event.position):
					doc.place_stamp(event.position)  # вызываем с одной позицией
					break

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			for doc in get_tree().get_nodes_in_group("documents"):
				for stamp in doc.get_children():
					if stamp is TextureRect:  # или твой тип штампа
						stamp.queue_free()
