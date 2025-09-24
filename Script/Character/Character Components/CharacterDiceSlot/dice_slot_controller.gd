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


func connect_views():
	for view in views:
		view.left_mouse_hover_pressed.connect(_on_left_mouse_hover_pressed)
		view.right_mouse_hover_pressed.connect(_on_right_mouse_hover_pressed)
		view.mouse_hover_entered.connect(_on_mouse_hover_entered)
		view.mouse_hover_exited.connect(_on_mouse_hover_exited)


#region UI Input Listener
func _on_left_mouse_hover_pressed(index: int):
	focus_slot(index)
	EventBus.slot_focus_entered.emit(self, index)


func _on_right_mouse_hover_pressed(index: int):
	unfocus_slot(index)
	EventBus.slot_focus_exited.emit(self, index)


func _on_mouse_hover_entered(index: int):
	highlight_slot(index)
	EventBus.slot_highlight_entered.emit(self, index)


func _on_mouse_hover_exited(index: int):
	unhighlight_slot(index)
	EventBus.slot_highlight_exited.emit(self, index)
#endregion


func highlight_slot(index: int):
	if models[index].state == DiceSlotData.DiceSlotState.FOCUS:
		return
	
	models[index].set_state(DiceSlotData.DiceSlotState.HIGHLIGHT)
	views[index].update_highlight(true)


func unhighlight_slot(index: int):
	if models[index].state == DiceSlotData.DiceSlotState.FOCUS:
		return
	
	models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
	views[index].update_highlight(false)


func focus_slot(index: int):
	# Enter Focus
	models[index].set_state(DiceSlotData.DiceSlotState.FOCUS)
	views[index].update_highlight(true)


func unfocus_slot(index: int):
	# Exit Focus
	models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
	views[index].update_highlight(false)


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


func get_owner_unit() -> CharacterController:
	return owner_unit


func get_dice_slot(index: int) -> DiceSlotData:
	return models[index]


func get_dice_slots() -> Array[DiceSlotData]:
	return models


func get_random_active_dice_slot() -> DiceSlotData:
	return active_models.pick_random()
