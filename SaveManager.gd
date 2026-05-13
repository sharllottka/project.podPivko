extends Node

const SAVE_PATH = "user://savegame.cfg"

func save_game():
	var config = ConfigFile.new()
	
	config.set_value("global", "last_scene", Global.last_scene)
	config.set_value("global", "current_night", Global.current_night)
	config.set_value("global", "clues_count", Global.clues_count)
	config.set_value("global", "glitch_done", Global.glitch_done)
	config.set_value("global", "shield_done", Global.shield_done)
	config.set_value("global", "suitcase_done", Global.suitcase_done)
	config.set_value("global", "puzzle_done", Global.puzzle_done)
	config.set_value("global", "dialogue_done", Global.dialogue_done)
	config.set_value("global", "mouse_sensitivity", Global.mouse_sensitivity)
	config.set_value("global", "music_volume", Global.music_volume)
	config.set_value("global", "sfx_volume", Global.sfx_volume)
	config.set_value("global", "is_fullscreen", Global.is_fullscreen)
	config.set_value("global", "has_note", Global.has_note)
	config.set_value("global", "note_notification_shown", Global.note_notification_shown)
	
	config.set_value("game", "current_day", GameManager.current_day)
	config.set_value("game", "warnings", GameManager.warnings)
	
	config.save(SAVE_PATH)

func load_game():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	
	Global.last_scene = config.get_value("global", "last_scene", "day")
	Global.current_night = config.get_value("global", "current_night", 1)
	Global.clues_count = config.get_value("global", "clues_count", 0)
	Global.glitch_done = config.get_value("global", "glitch_done", false)
	Global.shield_done = config.get_value("global", "shield_done", false)
	Global.suitcase_done = config.get_value("global", "suitcase_done", false)
	Global.puzzle_done = config.get_value("global", "puzzle_done", false)
	Global.dialogue_done = config.get_value("global", "dialogue_done", false)
	Global.mouse_sensitivity = config.get_value("global", "mouse_sensitivity", 0.2)
	Global.music_volume = config.get_value("global", "music_volume", 1.0)
	Global.sfx_volume = config.get_value("global", "sfx_volume", 1.0)
	Global.is_fullscreen = config.get_value("global", "is_fullscreen", false)
	Global.has_note = config.get_value("global", "has_note", false)
	Global.note_notification_shown = config.get_value("global", "note_notification_shown", false)
	
	GameManager.current_day = config.get_value("game", "current_day", 1)
	GameManager.warnings = config.get_value("game", "warnings", 0)
	
	return true

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
