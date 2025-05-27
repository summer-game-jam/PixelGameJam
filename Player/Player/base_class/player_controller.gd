extends Node2D
class_name Player_Controller

@export var camera: Camera2D

var current_form: CharacterBody2D

var preload_bat = preload("res://Platforming/Player/forms/bat_form.tscn")
var preload_beast = preload("res://Platforming/Player/forms/beast_form.tscn")
var preload_human = preload("res://Platforming/Player/forms/human_form.tscn")

func _ready() -> void:
	switch_forms(3)

func _physics_process(delta: float) -> void:
	var selection = 0
	if Input.is_action_just_pressed("1"):
		selection = 1
	if Input.is_action_just_pressed("2"):
		selection = 2
	if Input.is_action_just_pressed("3"):
		selection = 3
	
	if selection != 0:
		switch_forms(selection)
	
	if camera:
		camera.global_position = current_form.global_position

func switch_forms(selection: int):
	var temp_position: Vector2
	var temp_speed: Vector2 = Vector2.ZERO
	
	if current_form:
		temp_position = current_form.position
		temp_speed = current_form.velocity
		current_form.queue_free()
	else:
		temp_position = position
	
	match selection:
		1:
			current_form = preload_bat.instantiate()
		2:
			current_form = preload_beast.instantiate()
		3:
			current_form = preload_human.instantiate()
	
	add_child(current_form)
	current_form.position = temp_position
	current_form.velocity = temp_speed
