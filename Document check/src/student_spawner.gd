extends Control
@export var student_scene: PackedScene
@export var day_1_students: Array[StudentData] = []
@export var day_2_students: Array[StudentData] = []
@export var day_3_students: Array[StudentData] = []
@export var day_4_students: Array[StudentData] = []
@export var day_5_students: Array[StudentData] = []
@export var spawn_position: Vector2
@export var move_duration: float = 0.5
var current_student_data: StudentData = null
var current_student: Control = null
var _deck: Array[StudentData] = []

func _ready() -> void:
	randomize()
	_reset_deck()

func _get_todays_students() -> Array[StudentData]:
	match GameManager.current_day:
		1: return day_1_students
		2: return day_2_students
		3: return day_3_students
		4: return day_4_students
		5: return day_5_students
	return day_1_students

func spawn_student() -> void:
	if _deck.is_empty():
		_reset_deck()
	var idx: int = randi() % _deck.size()
	current_student_data = _deck[idx]
	_deck.remove_at(idx)
	if current_student != null:
		current_student.leave()
		current_student = null
	if student_scene == null:
		push_error("StudentSpawner: student_scene не назначена!")
		return
	var student = student_scene.instantiate()
	get_tree().get_current_scene().add_child(student)
	student.target_position = spawn_position
	student.move_duration = move_duration
	student.setup(current_student_data)
	student.appear()
	current_student = student

func approve_current_student() -> void:
	if current_student:
		current_student.leave_approved()
		current_student = null
	current_student_data = null

func deny_current_student() -> void:
	if current_student:
		current_student.leave_denied()
		current_student = null
	current_student_data = null

func remove_current_student() -> void:
	if current_student:
		current_student.leave()
		current_student = null
	current_student_data = null

func _reset_deck() -> void:
	_deck = _get_todays_students().duplicate()
