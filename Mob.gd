extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

var mob_types = ["walk", "swim", "fly"]
var languages = ["Python", "C#", "Java", "JavaScript", "Visual Basic", 
	"PHP", "Swift", "Objective-C", "Perl"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$Text.text = languages[randi() % languages.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Visibility_screen_exited():
	queue_free()