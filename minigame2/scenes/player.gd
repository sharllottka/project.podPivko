extends CharacterBody2D

const SPEED = 150
const JUMP_VELOCITY = -300.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var is_alive = true

func _physics_process(delta: float) -> void:
	# Если персонаж мертв, ничего не делаем (кроме гравитации, если хочешь)
	if not is_alive:
		return 

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else: animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Эта функция вызывается из Killzone
func die():
	if is_alive: # Чтобы не умирать дважды
		is_alive = false
		velocity.x = 0 # Останавливаем движение по горизонтали
		animated_sprite.play("death") # Убедись, что анимация называется именно так
