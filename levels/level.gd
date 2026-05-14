extends Node3D



func _ready():
	PauseManager.is_3d = true
	# ОЧЕНЬ ВАЖНО: ждем один кадр, чтобы 3D-объекты (мебель, свет) 
	# успели инициализироваться в дереве сцены
	await get_tree().process_frame 
	
	if Global.is_loading_save:
		SaveManager.load_game() # Теперь данные лягут на готовые объекты
		Global.is_loading_save = false # Сбрасываем флаг
