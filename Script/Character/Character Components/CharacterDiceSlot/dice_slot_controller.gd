class_name DiceSlotController
extends Control

@export var views: Array[DiceSlotView] = []

var owner_unit: CharacterController
var models: Array[DiceSlotData] = []
var active_models: Array[DiceSlotData] = []
var active_model_size: int = 2
var max_model_size: int = 4
var min_speed_value: int
var max_speed_value: int

func initialize(new_owner, active_size = 2, min_val = 1, max_val = 7):
	owner_unit = new_owner
	active_model_size = active_size
	min_speed_value = min_val
	max_speed_value = max_val
	
	initialize_models()
	initialize_views()
	connect_views()


func initialize_models():
	models.resize(max_model_size)
	active_models.resize(active_model_size)
	for i in range(models.size()):
		if i < active_model_size:
			models[i] = DiceSlotData.new()
			models[i].initialize(owner_unit)
			active_models[i] = models[i]
		else:
			models[i] = DiceSlotData.new()
			models[i].initialize(owner_unit)


func initialize_views():
	for i in range(views.size()):
		views[i].initialize(i)
	
	for i in range(max_model_size):
		views[i].initialize(i)
		if i < active_model_size:
			views[i].update_visibility(true)
		else:
			views[i].update_visibility(false)


func set_system_visibility(condition: bool):
	if condition:
		show()
	else:
		hide()


func connect_views():
	for view in views:
		view.left_mouse_hover_pressed.connect(_on_left_mouse_hover_pressed)
		view.right_mouse_hover_pressed.connect(_on_right_mouse_hover_pressed)
		view.mouse_hover_entered.connect(_on_mouse_hover_entered)
		view.mouse_hover_exited.connect(_on_mouse_hover_exited)


#region GUI Input Listener
func _on_left_mouse_hover_pressed(index: int):
	focus_slot(index)
	EventBus.slot_left_mouse_pressed.emit(self, index)
	EventBus.slot_inputs.emit(self, index, EventBus.SlotAction.LEFT_MOUSE_PRESSED)


func _on_right_mouse_hover_pressed(index: int):
	unselect_slot_target(index)
	EventBus.slot_right_mouse_pressed.emit(self, index)
	EventBus.slot_inputs.emit(self, index, EventBus.SlotAction.RIGHT_MOUSE_PRESSED)


func _on_mouse_hover_entered(index: int):
	highlight_slot(index)
	EventBus.slot_hover_entered.emit(self, index)
	EventBus.slot_inputs.emit(self, index, EventBus.SlotAction.HOVER_ENTERED)


func _on_mouse_hover_exited(index: int):
	unhighlight_slot(index)
	EventBus.slot_hover_exited.emit(self, index)
	EventBus.slot_inputs.emit(self, index, EventBus.SlotAction.HOVER_EXITED)
#endregion


#region GUI Input Methods
func focus_slot(index: int):
	models[index].set_state(DiceSlotData.DiceSlotState.FOCUS)
	views[index].update_focus(true)


func unfocus_slot(index: int):
	views[index].update_focus(false)


func highlight_slot(index: int):
	models[index].set_state(DiceSlotData.DiceSlotState.HIGHLIGHT)
	views[index].update_highlight(true)


func unhighlight_slot(index: int):
	views[index].update_highlight(false)


func select_slot_ability(index: int, ability: AbilityData):
	models[index].set_state(DiceSlotData.DiceSlotState.AIM)
	models[index].set_selected_ability(ability)
	views[index].update_mouse_trajectory(true)


func unselect_slot_ability(index: int):
	models[index].set_selected_ability(null)
	views[index].update_mouse_trajectory(false)


func select_slot_target(index: int, target_index: int, target_contr: DiceSlotController):
	models[index].set_state(DiceSlotData.DiceSlotState.TARGET_SET)
	var target_slot = target_contr.get_active_dice_slot(index)
	models[index].set_target_slot(target_slot)
	views[index].update_target_lock(true)
	views[index].update_target_trajectory(target_contr.views[target_index].global_position)


func unselect_slot_target(index: int):
	models[index].set_target_slot(null)
	views[index].clear_all()
#endregion


#region CHaracter Contrller Methods
func roll_dice_slot_speed(index: int):
	var roll_value = randi_range(min_speed_value, max_speed_value)
	models[index].set_speed_value(roll_value)
	views[index].update_speed_value(str(roll_value))


func clear_dice_slot_speed(index: int):
	models[index].set_speed_value(0)
	views[index].update_speed_value("")


func clear_active_slots_data():
	for index in range(active_models.size()):
		active_models[index].clear_data()
		views[index].clear_all()


func get_owner_unit() -> CharacterController:
	return owner_unit


func get_active_dice_slot(index: int) -> DiceSlotData:
	return active_models[index]


func get_active_dice_slots() -> Array[DiceSlotData]:
	return active_models


func get_random_active_dice_slot() -> DiceSlotData:
	return active_models.pick_random()
#endregion
