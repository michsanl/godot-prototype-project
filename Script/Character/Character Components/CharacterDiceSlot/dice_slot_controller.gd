class_name DiceSlotController
extends Control

@export var views: Array[DiceSlotView] = []

var models: Array[DiceSlotData] = []
var active_models: Array[DiceSlotData] = []
var owner_unit: CharacterController
var max_slot_amount: int = 4
var min_speed_value: int
var max_speed_value: int

func initialize(new_owner, active_size, min_val = 1, max_val = 7):
	owner_unit = new_owner
	min_speed_value = min_val
	max_speed_value = max_val
	
	initialize_models(owner_unit)
	initialize_views()
	update_active_slots(active_size)
	connect_views()



func initialize_models(new_owner):
	models.resize(max_slot_amount)
	for i in range(len(models)):
		models[i] = DiceSlotData.new()
		models[i].initialize(new_owner)


func initialize_views():
	for i in range(len(models)):
		views[i].initialize(i)


func connect_views():
	for view in views:
		view.left_mouse_pressed.connect(_on_left_mouse_pressed)
		view.right_mouse_pressed.connect(_on_right_mouse_pressed)
		view.hover_entered.connect(_on_hover_entered)
		view.hover_exited.connect(_on_hover_exited)


func _on_left_mouse_pressed(index: int):
	models[index].set_state(DiceSlotData.DiceSlotState.FOCUS)
	views[index].update_highlight(true)
	EventBus.slot_focus_entered.emit(index)

func _on_right_mouse_pressed(index: int):
	models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
	views[index].update_highlight(false)
	EventBus.slot_focus_exited.emit(index)

func _on_hover_entered(index: int):
	if models[index].state == DiceSlotData.DiceSlotState.FOCUS:
		return
	
	models[index].set_state(DiceSlotData.DiceSlotState.HIGHLIGHT)
	views[index].update_highlight(true)

func _on_hover_exited(index: int):
	if models[index].state == DiceSlotData.DiceSlotState.FOCUS:
		return
	
	models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
	views[index].update_highlight(false)


func update_active_slots(active_amount: int):
	for i in range(models.size()):
		if i < active_amount:
			active_models.clear()
			active_models.append(models[i])
			models[i].set_state(DiceSlotData.DiceSlotState.DEFAULT)
			views[i].update_visibility(true)
		else:
			models[i].set_state(DiceSlotData.DiceSlotState.INACTIVE)
			views[i].update_visibility(false)


func set_system_visibility(condition: bool):
	if condition:
		show()
	else:
		hide()


func roll_dice_slot_speed(index: int):
	var roll_value = randi_range(min_speed_value, max_speed_value)
	models[index].set_speed_value(roll_value)
	views[index].update_speed_value(str(roll_value))


func clear_dice_slot_speed(index: int):
	models[index].set_speed_value(0)
	views[index].update_speed_value("")


func select_dice_slot_target(index: int, target: DiceSlotData):
	views[index].update_mouse_trajectory(false)
	models[index].set_target_slot(target)
	views[index].update_target_trajectory(target.get_owner_global_position())


func deselect_dice_slot_target(index: int):
	models[index].set_target_slot(null)
	views[index].update_target_trajectory(Vector2.ZERO)


func select_dice_slot_ability(index: int, ability: AbilityData):
	models[index].set_selected_ability(ability)
	views[index].update_mouse_trajectory(true)


func deselect_dice_slot_ability(index: int):
	models[index].set_selected_ability(null)
	views[index].update_mouse_trajectory(true)


func clear_active_slots_data():
	for index in range(active_models.size()):
		active_models[index].set_speed_value(0)
		active_models[index].set_target_slot(null)
		active_models[index].set_selected_ability(null)
		
		views[index].update_speed_value("?")
		views[index].update_target_trajectory(Vector2.ZERO)


func get_dice_slot(index: int) -> DiceSlotData:
	return models[index]


func get_dice_slots() -> Array[DiceSlotData]:
	return models


func get_random_active_dice_slot() -> DiceSlotData:
	return active_models.pick_random()
