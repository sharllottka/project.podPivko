extends Control

@onready var grid       = $GridContainer
@onready var wire_layer = $WireLayer

var tile_scene = preload("res://minigame4/scenes/tile.tscn")

const COLS      = 6
const ROWS      = 4
const TILE_SIZE = 96
const GAP       = 2

const START_ROW = 0
const END_ROW   = 2

var tiles       = []
var grid_offset = Vector2.ZERO
var win         = false

var fixed_map = [
	"corner", "line",   "t",      "corner", "line",   "corner",
	"t",      "corner", "line",   "t",      "corner", "line",
	"line",   "t",      "corner", "line",   "corner", "corner",
	"corner", "line",   "corner", "t",      "line",   "corner"
]

func check_neighbor(tile, x, y, dir, nx, ny):
	if nx < 0 or nx >= COLS or ny < 0 or ny >= ROWS:
		return
	var neighbor = tiles[ny * COLS + nx]
	if neighbor.is_powered:
		return
	var conn = false
	if dir == "right":  conn = tile.connections["right"] and neighbor.connections["left"]
	elif dir == "left": conn = tile.connections["left"]  and neighbor.connections["right"]
	elif dir == "up":   conn = tile.connections["up"]    and neighbor.connections["down"]
	elif dir == "down": conn = tile.connections["down"]  and neighbor.connections["up"]
	if conn:
		spread_power(ny * COLS + nx)

func spread_power(index: int):
	var tile = tiles[index]
	tile.is_powered = true
	var x = index % COLS
	var y = int(index / COLS)
	check_neighbor(tile, x, y, "right", x + 1, y)
	check_neighbor(tile, x, y, "left",  x - 1, y)
	check_neighbor(tile, x, y, "up",    x, y - 1)
	check_neighbor(tile, x, y, "down",  x, y + 1)

func update_power():
	win = false
	for t in tiles:
		t.is_powered = false

	var start_tile = tiles[START_ROW * COLS + 0]
	if start_tile.connections["left"]:
		spread_power(START_ROW * COLS + 0)

	update_all_tiles()

	var end_tile = tiles[END_ROW * COLS + (COLS - 1)]
	if end_tile.is_powered and end_tile.connections["right"]:
		win = true
		_on_win()

	wire_layer.refresh()

func _on_win():
	print("✅ ЦЕПЬ ЗАМКНУТА!")
	if "has_wire_clue" in Global:
		Global.has_wire_clue = true

	await get_tree().create_timer(1.5).timeout

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://levels/level.tscn")

func update_all_tiles():
	for t in tiles:
		t.update_visual()

func generate_grid():
	tiles.clear()
	for child in grid.get_children():
		child.queue_free()

	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in range(COLS * ROWS):
		var tile = tile_scene.instantiate()
		tile.rotated.connect(update_power)
		tile.set_type(fixed_map[i])

		var rand_rot = rng.randi_range(0, 3)
		for _r in range(rand_rot):
			tile.rotate_tile()

		grid.add_child(tile)
		tiles.append(tile)

	update_all_tiles()
	update_power()

func _ready():
	grid.columns = COLS
	grid.add_theme_constant_override("h_separation", GAP)
	grid.add_theme_constant_override("v_separation", GAP)

	wire_layer.mg = self

	generate_grid()

	await get_tree().process_frame
	_recenter()

func _recenter():
	var grid_w  = COLS * TILE_SIZE + (COLS - 1) * GAP
	var grid_h  = ROWS * TILE_SIZE + (ROWS - 1) * GAP
	var vp      = get_viewport_rect().size
	grid_offset = Vector2((vp.x - grid_w) * 0.5, (vp.y - grid_h) * 0.5)
	grid.position = grid_offset
	wire_layer.refresh()

func tile_edge_pos(col: int, row: int, side: String) -> Vector2:
	var tx   = grid_offset.x + col * (TILE_SIZE + GAP)
	var ty   = grid_offset.y + row * (TILE_SIZE + GAP)
	var half = TILE_SIZE * 0.5
	match side:
		"left":  return Vector2(tx,             ty + half)
		"right": return Vector2(tx + TILE_SIZE, ty + half)
	return Vector2.ZERO
