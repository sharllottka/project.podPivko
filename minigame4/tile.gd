extends Control

var connections = {
	"up": false,
	"right": false,
	"down": false,
	"left": false
}

var tile_type = "line"
var is_start = false   # оставляем для совместимости, не используется визуально
var is_end   = false
var is_powered = false
var rotation_step = 0

signal rotated

const TILE_SIZE    = 96
const LINE_W       = 8.0
const LINE_W_GLOW  = 16.0

const COLOR_POWERED   = Color(1.0,  0.82, 0.1,  1.0)
const COLOR_GLOW      = Color(1.0,  0.9,  0.3,  0.35)
const COLOR_UNPOWERED = Color(0.55, 0.48, 0.35, 1.0)
const COLOR_BG        = Color(0.13, 0.12, 0.10, 1.0)
const COLOR_BORDER    = Color(0.28, 0.25, 0.18, 1.0)

func set_type(type: String):
	tile_type = type
	rotation_step = 0
	_apply_base_connections(type)
	queue_redraw()

func _apply_base_connections(type: String):
	match type:
		"line":
			connections = {"up": false, "down": false, "left": true, "right": true}
		"corner":
			connections = {"up": true, "right": true, "down": false, "left": false}
		"t":
			connections = {"up": false, "left": true, "right": true, "down": true}
		"cross":
			connections = {"up": true, "down": true, "left": true, "right": true}

func _ready():
	custom_minimum_size = Vector2(TILE_SIZE, TILE_SIZE)
	size = Vector2(TILE_SIZE, TILE_SIZE)
	mouse_filter = Control.MOUSE_FILTER_STOP
	queue_redraw()

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		rotate_tile()
		emit_signal("rotated")

func rotate_tile():
	rotation_step = (rotation_step + 1) % 4
	var temp         = connections["up"]
	connections["up"]    = connections["left"]
	connections["left"]  = connections["down"]
	connections["down"]  = connections["right"]
	connections["right"] = temp
	queue_redraw()

func update_visual():
	queue_redraw()

func _draw():
	var s    = TILE_SIZE
	var half = s * 0.5
	var center = Vector2(half, half)

	# Фон
	draw_rect(Rect2(0, 0, s, s), COLOR_BG)

	# Тонкие диагональные линии — текстура платы (декор)
	var grid_c = Color(0.18, 0.17, 0.13, 1.0)
	var step = 16
	for i in range(0, s + s, step):
		draw_line(Vector2(i, 0), Vector2(0, i), grid_c, 0.5)

	# Рамка
	draw_rect(Rect2(0, 0, s, s), COLOR_BORDER, false, 1.5)

	var wire_color = COLOR_POWERED if is_powered else COLOR_UNPOWERED

	var dirs = {
		"up":    Vector2(half, 0),
		"down":  Vector2(half, s),
		"left":  Vector2(0,    half),
		"right": Vector2(s,    half)
	}

	# Провода
	for dir in connections:
		if connections[dir]:
			var endpoint = dirs[dir]
			if is_powered:
				draw_line(center, endpoint, COLOR_GLOW, LINE_W_GLOW, true)
			draw_line(center, endpoint, wire_color, LINE_W, true)

	# Центральный узел
	if is_powered:
		draw_circle(center, 9.0, COLOR_GLOW)
	draw_circle(center, 6.0, wire_color)
	draw_circle(center, 3.5, COLOR_BG)
