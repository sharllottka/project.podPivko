extends Control

@export var document_scene: PackedScene  # твой документ

# Позиция, где появляется новый документ
var spawn_position: Vector2

func _ready():
	spawn_position = position  # например, спавнится прямо на спавнере

# Создание документа
func spawn_document():
	if document_scene:
		var doc = document_scene.instantiate()    # создаём новый экземпляр
		get_parent().add_child(doc)               # добавляем на сцену Main
		doc.global_position = spawn_position      # ставим в spawn точку
		doc.scale = Vector2(1, 1)                 # обычный размер
