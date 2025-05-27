extends Node2D
class_name Player_Controller

@export var camera: Camera2D

var current_form: CharacterBody2D

var preload_bat = preload("res://Player/forms/bat/bat_form.tscn")
var preload_beast = preload("res://Player/forms/beast/beast_form.tscn")
var preload_human = preload("res://Player/forms/human/human_form.tscn")

func _ready() -> void:
	switch_forms(3)

func _physics_process(delta: float) -> void:
	var selection = 0
	if ($form_switch_cooldown.time_left == 0):
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
	
	if !current_form is Bat:
		$flight_meter.fill_gauge(delta)

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
			current_form.flight_meter = $flight_meter
		2:
			current_form = preload_human.instantiate()
		3:
			current_form = preload_beast.instantiate()
	
	add_child(current_form)
	current_form.position = temp_position
	current_form.velocity = temp_speed
	
	$form_switch_cooldown.start()
