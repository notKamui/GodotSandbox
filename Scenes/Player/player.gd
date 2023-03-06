extends CharacterBody2D

@export var normal_speed := 100
@export var dash_speed := 200
@export var dash_duration := .3

var _actual_speed := normal_speed
var _dashing := false

func _get_input():
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * _actual_speed
	
	if Input.is_action_just_pressed("dash") and !_dashing:
		_create_dash_tween().play()
		Foo.bar.emit()

func _physics_process(delta):
	_get_input()
	velocity *= _actual_speed * delta
	move_and_slide()

func _create_dash_tween():
	var tween = self.create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "_actual_speed", normal_speed, dash_duration)
	tween.parallel().tween_callback(func (): _dashing = false)
	
	_actual_speed = dash_speed
	_dashing = true
	
	return tween
