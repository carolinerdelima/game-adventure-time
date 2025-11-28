extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var sfx_jump: AudioStreamPlayer2D = $"sfx_ jump"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AnimatedSprite2D/AttackArea
@onready var attack_shape: CollisionShape2D = $AnimatedSprite2D/AttackArea/CollisionShape2D
@onready var sfx_death: AudioStreamPlayer2D = $sfx_death

var is_attacking := false

func _ready() -> void:
	attack_area.monitoring = false
	attack_shape.disabled = true
	attack_area.area_entered.connect(_on_attack_area_area_entered)
	anim.animation_finished.connect(anim_finished)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
		print("PULOU")
		anim.play("jump")
		sfx_jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()

	if Input.is_action_just_pressed("ui_left"):
		anim.flip_h = true
	if Input.is_action_just_pressed("ui_right"):
		anim.flip_h = false

func start_attack() -> void:
	is_attacking = true
	anim.play("attack")
	attack_shape.disabled = false
	attack_area.monitoring = true

func anim_finished() -> void:
	print("FINALIZOU ANIMAÇÃO")
	if anim.animation == "attack":
		is_attacking = false
		anim.play("idle")
		attack_area.monitoring = false
		attack_shape.disabled = true

	if anim.animation == "jump":
		anim.play("idle")

func _on_attack_area_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy_hurtbox"):
		return
	var enemy := area.get_parent()
	if enemy and enemy.has_method("take_damage"):
		enemy.take_damage()
		
func teste() -> void:
	print("aaaaa")
	
func is_attack_active() -> bool:
	return is_attacking
	
func death() -> void :
	anim.play("death")
	sfx_death.play()
