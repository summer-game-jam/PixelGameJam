extends Node2D
class_name Player_Controller

@export var camera: Camera2D

var current_form: Player_Base
var light_detector: LightDetector

var kills: int = 0

var is_dead:bool = false

@export var level1: int = 1 # monster tf
@export var level2: int = 2 # bat tf
@export var level3: int = 3 # win

var last_form:int = 2

var preload_bat = preload("res://Player/forms/bat/bat_form.tscn")
var preload_beast = preload("res://Player/forms/beast/beast_form.tscn")
var preload_human = preload("res://Player/forms/human/human_form.tscn")

func _ready() -> void:
	switch_forms(3)
	set_ui()

func _physics_process(delta: float) -> void:
	# Update light detector
	var players: Array[Node] = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		var children = player.get_children()
		for child in children:
			if child is LightDetector:
				light_detector = child

	var selection = 0
	if ($form_switch_cooldown.time_left == 0):
		if Input.is_action_just_pressed("1"):
			if !current_form is Bat: #and $flight_meter.is_gauge_full():
				if current_form is Human:
					last_form = 2
				elif current_form is Beast:
					last_form = 3
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
	
	if current_form is Beast and light_detector.in_light:
		print("light")
		switch_forms(2)
	set_ui()

func switch_forms(selection: int):
	var temp_position: Vector2
	var temp_speed: Vector2 = Vector2.ZERO
	var temp_direction: Direction.directions
	
	if current_form:
		# don't swap to yourself
		if selection == convert_body_to_enum(current_form):
			return
		temp_position = current_form.position
		temp_speed = current_form.velocity
		temp_direction = current_form.get_direction()
		if selection != 3:
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
			if light_detector and light_detector.in_light:
				return
			if current_form:
				current_form.queue_free()
			current_form = preload_beast.instantiate()
	
	current_form.set_direction(temp_direction)
	add_child(current_form)
	current_form.position = temp_position
	current_form.velocity = temp_speed
	
	$form_switch_cooldown.start()
	$Poof.global_position = current_form.global_position
	$Poof.emitting = true

func convert_body_to_enum(body: CharacterBody2D) -> int:
	if body is Bat:
		return 1
	if body is Human:
		return 2
	if body is Beast:
		return 3
	return 0

func out_of_flight():
	switch_forms(last_form)


func set_ui():
	var running_total:int = get_tree().get_nodes_in_group("npc").size()
	var dead:int = 0
	for child in get_tree().get_nodes_in_group("npc"):
		if child.status == NPC.states.dead:
			dead += 1
	$CanvasLayer/Ui.update(dead, running_total)
