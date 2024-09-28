# scripts/player/player_controller.gd
extends CharacterBody2D

# Hareket hızı ve zıplama değişkenleri
const SPEED := 200.0
const JUMP_VELOCITY := -300.0

# AnimatedSprite2D referansı
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	# Başlangıç ayarları
	print("Player is ready.")
	animated_sprite.play("Idle")

func _physics_process(delta: float) -> void:
	# Giriş kontrolleri ile hareket et
	handle_input()

	# Yerçekimi ekleyin
	if not is_on_floor():
		velocity += get_gravity() * delta  # Yerçekimi etkisini ekleyin

	# Karakteri hareket ettir
	move_and_slide()

	# Hareket durumuna göre animasyon kontrolü
	if not is_on_floor():
		animated_sprite.play("Jump")
	elif velocity.x != 0:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")

# Oyuncu girdi işlemlerini kontrol eden fonksiyon
func handle_input() -> void:
	# Yatay yönü belirle
	var direction := Input.get_axis("move_left", "move_right")
	
	 # Eğer oyuncu havadaysa yatay hızı düşür
	var effective_speed := SPEED
	if not is_on_floor():
		effective_speed *= 0.8  # Havadayken hız daha düşük olsun
	
	# Eğer bir yön belirlenmişse hızı ayarla, aksi halde yavaşlat
	if direction != 0:
		velocity.x = direction * effective_speed
	else:
		velocity.x = move_toward(velocity.x, 0, effective_speed)
	
	# Zıplama kontrolü
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# Oyuncunun sağa mı yoksa sola mı baktığını kontrol et
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
