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


#region Initialization
func initialize(new_owner: CharacterController, active_size := 2, min_val := 1, max_val := 7):
	owner_unit = new_owner
	active_model_size = active_size
	min_speed_value = min_val
	max_speed_value = max_val
	
	_initialize_models()
	_initialize_views()
	_connect_views()


func _initialize_models():
	models.clear()
	active_models.clear()

	for i in range(max_model_size):
		var model := DiceSlotData.new()
		model.initialize(owner_unit, i)
		models.append(model)

		if i < active_model_size:
			active_models.append(model)


func _initialize_views():
	for i in range(views.size()):
		views[i].initialize(i)
		views[i].update_visibility(i < active_model_size)
#endregion


#region Visibility
func set_system_visibility(condition: bool):
	if condition:
		show()
	else:
		hide()
#endregion


#region View Connections
func _connect_views():
	for view in views:
		view.slot_inputs.connect(_on_slot_input)


func _on_slot_input(index: int, action: int):
	# Forward to EventBus without duplicating
	EventBus.slot_inputs.emit(self, index, action)
#endregion


#region Slot Interaction
func update_focus(index: int, focused: bool):
	if not _is_valid_index(index): return

	if focused:
		models[index].set_state(DiceSlotData.DiceSlotState.FOCUS)
		views[index].update_focus(true)
	else:
		models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
		views[index].update_focus(false)


func update_highlight(index: int, highlighted: bool):
	if not _is_valid_index(index): return
	views[index].update_highlight(highlighted)


func select_slot_ability(index: int, ability: AbilityData):
	if not _is_valid_index(index): return
	models[index].set_state(DiceSlotData.DiceSlotState.AIM)
	models[index].set_selected_ability(ability)
	views[index].update_mouse_trajectory(true)


func unselect_slot_ability(index: int):
	if not _is_valid_index(index): return
	models[index].set_selected_ability(null)
	views[index].update_mouse_trajectory(false)


func select_slot_target(index: int, target_index: int, target_contr: DiceSlotController):
	if not _is_valid_index(index) or not target_contr._is_valid_index(target_index): return

	models[index].set_state(DiceSlotData.DiceSlotState.TARGET_SET)
	var target_slot := target_contr.get_active_dice_slot(target_index)
	models[index].set_target_slot(target_slot)

	views[index].update_target_lock(true)
	views[index].update_target_trajectory(target_contr.views[target_index].global_position)


func unselect_slot_target(index: int):
	if not _is_valid_index(index): return
	models[index].set_state(DiceSlotData.DiceSlotState.DEFAULT)
	models[index].set_target_slot(null)
	views[index].clear_all()
#endregion


#region Dice Rolls
func roll_dice_slot_speed(index: int):
	if not _is_valid_index(index): return
	var roll_value := randi_range(min_speed_value, max_speed_value)
	models[index].set_speed_value(roll_value)
	views[index].update_speed_value(str(roll_value))


func clear_dice_slot_speed(index: int):
	if not _is_valid_index(index): return
	models[index].set_speed_value(0)
	views[index].update_speed_value("")
#endregion


#region Slot Management
func clear_active_slots_data():
	for index in range(active_models.size()):
		active_models[index].clear_data()
		views[index].clear_all()
#endregion


#region Getters
func get_owner_unit() -> CharacterController:
	return owner_unit


func get_active_dice_slot(index: int) -> DiceSlotData:
	if not _is_valid_index(index, true): return null
	return active_models[index]


func get_active_dice_slots() -> Array[DiceSlotData]:
	return active_models.duplicate()


func get_random_active_dice_slot() -> DiceSlotData:
	if active_models.is_empty(): return null
	return active_models.pick_random()
#endregion


#region Helpers
func _is_valid_index(index: int, active_only := false) -> bool:
	if active_only:
		return index >= 0 and index < active_models.size()
	return index >= 0 and index < models.size()
#endregion
