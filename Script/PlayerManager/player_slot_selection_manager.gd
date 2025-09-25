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


func _on_ability_button_pressed(index: int):
	set_slot_ability(index)


func _on_slot_input(source, index, action: int):
	match action:
		SlotActions.Action.LEFT_MOUSE_PRESSED:
			resolve_slot_input_left_mouse(source, index)
		SlotActions.Action.RIGHT_MOUSE_PRESSED:
			remove_slot_ability(source, index)
			remove_target_slot(source, index)
		SlotActions.Action.HOVER_ENTERED:
			set_highlight_slot(source, index)
		SlotActions.Action.HOVER_EXITED:
			remove_highlight_slot(source, index)

func resolve_slot_input_left_mouse(source: DiceSlotController, index: int):	
	var current_slot = get_current_slot()
	var new_slot = source.get_active_dice_slot(index)

	if data.focused_slot_controller != null and data.ability_data != null:
		# asd
		set_target_slot(source, index)
		finalize_targeting()
		return

	if data.focused_slot_controller != null and \
	data.focused_slot_controller == source and \
	data.focused_slot_index == index: 
		# Focus slot present, same with the new one
		remove_current_focus_slot()
		return
	
	if data.focused_slot_controller != null and current_slot != new_slot:
		# No focused slot
		remove_current_focus_slot()
		
	if data.focused_slot_controller == null:
		set_focus_slot(source, index)


func remove_current_focus_slot():
	remove_focus_slot(
		data.focused_slot_controller, 
		data.focused_slot_index
	)

#region Core Methods
func finalize_targeting():
	data.focused_slot_controller.select_slot_target(
		data.focused_slot_index,
		data.target_slot_index,
		data.target_slot_controller, 
	)
	data = SlotSelectionData.new()
	view.hide()


func set_focus_slot(controller: DiceSlotController, index: int):
	controller.focus_slot(index)
	data.set_focused_slot_controller(controller)
	data.set_focused_slot_index(index)
	
	view.update_button_icon(controller.owner_unit.get_abilities())
	view.show()


func remove_focus_slot(controller: DiceSlotController, index: int):
	controller.unfocus_slot(index)
	data.set_focused_slot_controller(null)
	data.set_focused_slot_index(-1)
	
	view.hide()


func set_highlight_slot(controller: DiceSlotController, index: int):
	controller.highlight_slot(index)
	data.set_highlighted_slot_controller(controller)
	data.set_highlighted_slot_index(index)
	
	view.update_button_icon(controller.owner_unit.get_abilities())
	view.show()


func remove_highlight_slot(controller: DiceSlotController, index: int):
	controller.unhighlight_slot(index)
	data.set_highlighted_slot_controller(null)
	data.set_highlighted_slot_index(-1)


func set_target_slot(controller: DiceSlotController, index: int):
	data.set_target_slot_controller(controller)
	data.set_target_slot_index(index)


func remove_target_slot(controller: DiceSlotController, index: int):
	controller.unselect_slot_target(index)
	data.set_target_slot_controller(null)
	data.set_target_slot_index(-1)
	data.set_slot_ability(null)


func set_slot_ability(ability_index: int):
	var ability = data.focused_slot_controller.owner_unit.get_ability(ability_index)
	var controller = data.focused_slot_controller
	controller.select_slot_ability(data.focused_slot_index, ability)
	data.set_slot_ability(ability)


func remove_slot_ability(controller: DiceSlotController, index: int):
	controller.unselect_slot_ability(index)
	data.set_slot_ability(null)
	
	view.hide()
#endregion


func get_current_slot():
	if data.focused_slot_controller == null:
		return null
	else:
		return data.focused_slot_controller.get_active_dice_slot(data.focused_slot_index)


func get_selected_slot_controller() -> DiceSlotController:
	return data.focused_slot_controller

func get_selected_slot_index() -> int:
	return data.focused_slot_index
