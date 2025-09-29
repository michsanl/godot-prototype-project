class_name PlayerSlotSelectionManager
extends Node

@export var view: AbilityView

var data: SlotSelectionData


func _ready() -> void:
	initialize()


func initialize():
	data = SlotSelectionData.new()
	EventBus.ability_button_pressed.connect(_on_ability_button_pressed)
	EventBus.slot_inputs.connect(_on_slot_input)


#region Event Handlers
func _on_ability_button_pressed(index: int):
	handle_ability_button_pressed(index)


func _on_slot_input(source: DiceSlotController, index: int, action: int):
	match action:
		SlotActions.Action.LEFT_MOUSE_PRESSED:
			handle_left_click(source, index)
		SlotActions.Action.RIGHT_MOUSE_PRESSED:
			handle_right_click(source, index)
		SlotActions.Action.HOVER_ENTERED:
			update_highlight(source, index, true)
		SlotActions.Action.HOVER_EXITED:
			update_highlight(source, index, false)
#endregion


#region Input Handling
func handle_ability_button_pressed(index: int):
	if data.has_focus():
		set_slot_ability(index)


func handle_left_click(source: DiceSlotController, index: int):
	var new_slot = source.get_active_dice_slot(index)

	if is_targeting():
		handle_target_set(source, index)
	elif is_toggling_focus(source, index):
		update_focus(source, index, false)
	elif is_switching_focus(new_slot):
		update_focus(data.focused_slot_controller, data.focused_slot_index, false)
		update_focus(source, index, true)
	elif not data.has_focus():
		update_focus(source, index, true)


func handle_right_click(source: DiceSlotController, index: int):
	update_focus(source, index, false)
	remove_slot_ability(source, index)
	remove_target_slot(source, index)
#endregion


#region Slot State Updates
func update_focus(controller: DiceSlotController, index: int, focused: bool):
	if focused:
		controller.update_focus(index, true)
		data.set_focused_slot(controller, index)
		view.update_button_icon(controller.owner_unit.get_abilities())
		view.show()
	else:
		controller.update_focus(index, false)
		data.clear_focus()
		view.hide()


func update_highlight(controller: DiceSlotController, index: int, highlighted: bool):
	if highlighted:
		controller.update_highlight(index, true)
		data.set_highlighted_slot(controller, index)
	else:
		controller.update_highlight(index, false)
		data.clear_highlight()
#endregion


#region Abilities & Targeting
func set_slot_ability(ability_index: int):
	var controller = data.focused_slot_controller
	if controller == null:
		return
	var ability = controller.owner_unit.get_ability(ability_index)
	controller.select_slot_ability(data.focused_slot_index, ability)
	data.set_slot_ability(ability)


func remove_slot_ability(controller: DiceSlotController, index: int):
	controller.unselect_slot_ability(index)
	data.clear_ability()
	view.hide()


func handle_target_set(target_controller: DiceSlotController, target_index: int):
	if is_targeting_self(target_controller):
		return
	
	data.focused_slot_controller.select_slot_target(
		data.focused_slot_index,
		target_index,
		target_controller
	)
	data.reset()
	view.hide()
	Debug.log("Target set.")


func remove_target_slot(controller: DiceSlotController, index: int):
	controller.unselect_slot_target(index)
	data.clear_target()
#endregion


#region Helpers
func get_current_slot():
	if not data.has_focus():
		return null
	return data.focused_slot_controller.get_active_dice_slot(data.focused_slot_index)


func is_targeting() -> bool:
	return data.has_focus() and data.has_ability()


func is_toggling_focus(source: DiceSlotController, index: int) -> bool:
	return data.focused_slot_controller == source and data.focused_slot_index == index


func is_switching_focus(new_slot) -> bool:
	return data.has_focus() and get_current_slot() != new_slot
	

func is_targeting_self(target_controller: DiceSlotController) -> bool:
	return data.focused_slot_controller == target_controller
#endregion
