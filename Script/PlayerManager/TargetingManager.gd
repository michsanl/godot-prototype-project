class_name TargetingManager
extends Node

@export var view: AbilityView

var ability_index: int
var focused_slot_controller: DiceSlotController
var highlighted_slot_controller: DiceSlotController
var focused_slot_index: int
var highlighted_slot_index: int

func _ready() -> void:
	EventBus.ability_button_pressed.connect(_on_ability_button_pressed)
	EventBus.remove_ability_button_pressed.connect(_on_remove_ability_button_pressed)
	
	EventBus.focus_selection_added.connect(_on_focus_selection_added)
	EventBus.focus_selection_removed.connect(_on_focus_selection_removed)
	EventBus.highlight_selection_added.connect(_on_highlight_selection_added)
	EventBus.highlight_selection_removed.connect(_on_highlight_selection_removed)

func _on_ability_button_pressed(index: int):
	if focused_slot_controller != null:
		var ability = get_focused_slot_ability(index)
		focused_slot_controller.select_slot_ability(focused_slot_index, ability)


func _on_remove_ability_button_pressed():
	if focused_slot_controller != null:
		focused_slot_controller.deselect_slot_ability(focused_slot_index)


func _on_focus_selection_added(controller: DiceSlotController, index: int):
	focused_slot_controller = controller
	focused_slot_index = index
	
	view.update_button_icon(controller.owner_unit.get_ability_controller().get_abilities())
	view.show()


func _on_focus_selection_removed(controller: DiceSlotController, index: int):
	focused_slot_controller = null
	focused_slot_index = -1
	view.hide()


func _on_highlight_selection_added(controller: DiceSlotController, index: int):
	if focused_slot_controller != null:
		return
	
	view.update_button_icon(controller.owner_unit.get_ability_controller().get_abilities())
	view.show()


func _on_highlight_selection_removed(controller: DiceSlotController, index: int):
	if focused_slot_controller != null:
		return
	
	view.hide()


func get_focused_slot_ability(ability_index: int) -> AbilityData:
	return focused_slot_controller.owner_unit.get_ability_controller().get_ability(ability_index)
