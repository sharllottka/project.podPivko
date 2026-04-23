extends Node2D

# Ссылка на minigame — устанавливается из minigame.gd
var mg = null

const COLOR_POWERED   = Color(1.0,  0.82, 0.1,  1.0)
const COLOR_GLOW      = Color(1.0,  0.9,  0.3,  0.35)
const COLOR_UNPOWERED = Color(0.55, 0.48, 0.35, 1.0)
const LINE_W          = 8.0
const LINE_W_GLOW     = 16.0

func refresh():
	queue_redraw()

func _draw():
	if mg == null or mg.grid_offset == Vector2.ZERO:
		return

	var tiles      = mg.tiles
	var COLS       = mg.COLS
	var START_ROW  = mg.START_ROW
	var END_ROW    = mg.END_ROW

	if tiles.size() == 0:
		return

	var start_tile = tiles[START_ROW * COLS + 0]
	var end_tile   = tiles[END_ROW   * COLS + (COLS - 1)]

	var end_powered = end_tile.is_powered and end_tile.connections["right"]

	# === ВХОДНОЙ ПРОВОД (слева) — всегда золотой ===
	var p_edge_in = mg.tile_edge_pos(0, START_ROW, "left")
	var p_node_in = p_edge_in + Vector2(-70, 0)

	draw_line(p_node_in, p_edge_in, COLOR_GLOW,    LINE_W_GLOW, true)
	draw_line(p_node_in, p_edge_in, COLOR_POWERED,  LINE_W,      true)
	_draw_connector(p_node_in, true)

	# === ВЫХОДНОЙ ПРОВОД (справа) ===
	var p_edge_out = mg.tile_edge_pos(COLS - 1, END_ROW, "right")
	var p_node_out = p_edge_out + Vector2(70, 0)

	var ec = COLOR_POWERED if end_powered else COLOR_UNPOWERED
	if end_powered:
		draw_line(p_edge_out, p_node_out, COLOR_GLOW, LINE_W_GLOW, true)
	draw_line(p_edge_out, p_node_out, ec, LINE_W, true)
	_draw_receiver(p_node_out, end_powered)

# ---- Разъём-источник: болт в квадратной пластине ----
func _draw_connector(pos: Vector2, powered: bool):
	var c      = COLOR_POWERED if powered else COLOR_UNPOWERED
	var bg     = Color(0.12, 0.10, 0.08, 1.0)
	var border = Color(0.45, 0.38, 0.22, 1.0)

	var rs = Vector2(32, 32)
	draw_rect(Rect2(pos - rs * 0.5, rs), bg)
	draw_rect(Rect2(pos - rs * 0.5, rs), border, false, 2.0)

	if powered:
		draw_circle(pos, 18.0, Color(COLOR_GLOW.r, COLOR_GLOW.g, COLOR_GLOW.b, 0.4))

	draw_circle(pos, 11.0, c)
	draw_circle(pos, 6.5,  bg)
	draw_circle(pos, 3.0,  c)

# ---- Разъём-приёмник: вертикальная пластина с тремя точками ----
func _draw_receiver(pos: Vector2, powered: bool):
	var c      = COLOR_POWERED if powered else COLOR_UNPOWERED
	var bg     = Color(0.12, 0.10, 0.08, 1.0)
	var border = Color(0.45, 0.38, 0.22, 1.0)

	var rs = Vector2(32, 62)
	draw_rect(Rect2(pos - rs * 0.5, rs), bg)
	draw_rect(Rect2(pos - rs * 0.5, rs), border, false, 2.0)

	var offsets = [Vector2(0, -18), Vector2(0, 0), Vector2(0, 18)]
	for dp_off in offsets:
		var dp = pos + dp_off
		if powered:
			draw_circle(dp, 9.0,  Color(COLOR_GLOW.r, COLOR_GLOW.g, COLOR_GLOW.b, 0.55))
			draw_circle(dp, 6.0,  COLOR_POWERED)
			draw_circle(dp, 2.5,  Color(1.0, 0.98, 0.8, 1.0))
		else:
			draw_circle(dp, 6.0, c)
			draw_circle(dp, 2.5, bg)
