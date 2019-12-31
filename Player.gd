extends Area2D

signal hit

export var speed = 400 # how fast the player can move
var velocity = Vector2()
var screen_size # size of the game window
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() # hiding the player at the start

func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false
	
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(target) > 10:
		velocity = (target - position).normalized() * speed
	else:
		velocity = Vector2()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)