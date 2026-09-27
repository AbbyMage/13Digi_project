extends CharacterBody2D

const MOVE_SPEED = 1750 

var current_look_dir = "right"

var can_punch: bool = true
@export var punch_time: float = 0.2
@export var punch_return_time: float = 0.5
@export var weapon_damage: float = 1.0


func _physics_process(_delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input * MOVE_SPEED
	move_and_slide()


	# Look left/right
	if current_look_dir == "right" and get_global_mouse_position().x < global_position.x:
		$Sprite2D/flip_anim.play("look_left")
		current_look_dir = "left"

	elif current_look_dir == "left" and get_global_mouse_position().x > global_position.x:
		$Sprite2D/flip_anim.play("look_right")
		current_look_dir = "right"


	# Put fist in front/behind player
	if get_global_mouse_position().y > global_position.y:
		$Sprite2D/fist.show_behind_parent = true
		$Sprite2D.frame = 0
	else:
		$Sprite2D/fist.show_behind_parent = true
		$Sprite2D.frame = 0


	# Punch
	if Input.is_action_just_pressed("attack") and can_punch:
		$Sprite2D/fist/AnimationPlayer.speed_scale = $Sprite2D/fist/AnimationPlayer.get_animation("punch").length / punch_time
		$Sprite2D/fist/AnimationPlayer.play("punch")
		can_punch = false


func spawn_punch():
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:

	if anim_name == "punch":
		$Sprite2D/fist/AnimationPlayer.speed_scale = $Sprite2D/fist/AnimationPlayer.get_animation("fist_return").length / punch_return_time
		$Sprite2D/fist/AnimationPlayer.play("fist_return")

	elif anim_name == "fist_return":
		can_punch = true
