extends Node2D

@onready var path_2d: Path2D = %Path2D
@onready var wave_start_timer: Timer = $WaveStartTimer
@onready var defence_ref: Defence = %DefenceRef
@onready var defences: Node2D = $Defences
@onready var clickable_area_shape: CollisionShape2D = $ClickableArea/CollisionShape2D
@onready var clickable_area: Area2D = %ClickableArea

const ENEMY = preload("uid://b08w1hrdrym13")
const DEFENCE = preload("uid://dt3c856ergi4i")

var wave_count = 0
var enemies: Array[PathFollow2D] = []
var level_speed = 300

func _ready() -> void:
	GlobalUi.defence_selected_changed.connect(_defence_seleted_changed)
	get_viewport().size_changed.connect(_viewport_changed)
	_viewport_changed()

func _viewport_changed():
	clickable_area.global_position = get_viewport().size / 2
	(clickable_area_shape.shape as RectangleShape2D).size = get_viewport().size

func _process(delta: float) -> void:
	defence_ref.visible = GlobalUi.has_defence_selected()
	if defence_ref.visible:
		_set_defence_ref_pos()
		

func _place_defence():
	if not GlobalUi.has_defence_selected():
		return

	if not _check_defence_place():
		return
	
	var new_defence: Defence = DEFENCE.instantiate()
	new_defence.attributes = GlobalUi.defence_selected
	new_defence.global_position = defence_ref.global_position
	defences.add_child(new_defence)
	GlobalUi.defence_selected = null

func _check_defence_place() -> bool:
	return true

func _set_defence_ref_pos():
	var mouse_pos: Vector2 = get_global_mouse_position()
	defence_ref.global_position = mouse_pos

func _defence_seleted_changed():
	if not GlobalUi.has_defence_selected():
		defence_ref.visible = false
		return
	defence_ref.visible = true
	defence_ref.attributes = GlobalUi.defence_selected

func _physics_process(delta: float) -> void:
	for enemy in enemies:
		enemy.progress += level_speed * delta

func spawn_enemy():
	var new_enemy := PathFollow2D.new()
	new_enemy.add_child(ENEMY.instantiate())
	path_2d.add_child(new_enemy)
	enemies.append(new_enemy)

func spawn_wave():
	for i in wave_count * 5:
		spawn_enemy()
		await get_tree().create_timer(1.0).timeout

func _on_wave_start_timer_timeout() -> void:
	wave_count += 1
	spawn_wave.call_deferred()
	if wave_count < 2:
		wave_start_timer.start(wave_count * 10)

func _on_end_path_body_entered(body: Node2D) -> void:
	enemies.erase(body.get_parent())
	body.queue_free()


func _on_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("primary_click"):
		_place_defence()
