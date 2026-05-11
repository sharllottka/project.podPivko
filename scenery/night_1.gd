extends Node3D

@export var available_on_night: int = 1

func _ready():
	if Global.current_night != available_on_night:
		visible = false
		_disable_all(self)

func _disable_all(node: Node):
	for child in node.get_children():
		if child is StaticBody3D:
			child.process_mode = Node.PROCESS_MODE_DISABLED
		if child is Area3D:
			child.monitoring = false
			child.monitorable = false
		_disable_all(child)
