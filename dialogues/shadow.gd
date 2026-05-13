extends Node3D

func _ready():
	if Global.current_night != 1:
		visible = false
		for child in get_children():
			if child is Area3D:
				child.monitoring = false
				child.monitorable = false
		# отключаем области внутри dialogue_trigger
		var trigger = get_parent().get_node_or_null("dialogue_trigger")
		if trigger:
			for child in trigger.get_children():
				if child is Area3D:
					child.monitoring = false
					child.monitorable = false
