class_name EnemySlotSelectionManager
extends Node

@export var character_manager: CharacterManager

var data: SlotSelectionData
var player_characters: Array[CharacterController]  = []

func _ready() -> void:
	initialize()


func initialize():
	data = SlotSelectionData.new()
	player_characters.append_array(character_manager.get_all_characters())
	
	EventBus.enemy_slot_left_mouse_pressed.connect(_on_slot_left_mouse_pressed)
	EventBus.enemy_slot_focus_exited.connect(_on_slot_focus_exited)
	EventBus.enemy_slot_hover_entered.connect(_on_slot_hover_entered)
	EventBus.enemy_slot_hover_exited.connect(_on_slot_hover_exited)


#region Event Bus Listener
func _on_slot_left_mouse_pressed(controller: DiceSlotController, index):
	if data.focused_slot_controller == null and data.focused_slot_index == -1:
		set_focus_slot(controller, index)
		EventBus.enemy_focus_selection_added.emit(controller, index)
	elif data.focused_slot_controller == controller and data.focused_slot_index == index:
		remove_focus_slot(controller, index)
		EventBus.enemy_focus_selection_removed.emit(controller, index)
	else:
		remove_focus_slot(controller, index)
		set_focus_slot(controller, index)
		EventBus.enemy_focus_selection_added.emit(controller, index)


func _on_slot_focus_exited(controller: DiceSlotController, index):
	remove_focus_slot(controller, index)
	EventBus.enemy_focus_selection_removed.emit(controller, index)


func _on_slot_hover_entered(controller: DiceSlotController, index):
	set_highlight_slot(controller, index)
	EventBus.enemy_highlight_selection_added.emit(controller, index)


func _on_slot_hover_exited(controller: DiceSlotController, index):
	remove_highlight_slot(controller, index)
	EventBus.enemy_highlight_selection_removed.emit(controller, index)
#endregion


func set_focus_slot(controller: DiceSlotController, index: int):
	controller.focus_slot(index)
	data.set_focused_slot_controller(controller)
	data.set_focused_slot_index(index)


func remove_focus_slot(controller: DiceSlotController, index: int):
	data.focused_slot_controller.unfocus_slot(data.focused_slot_index)
	data.set_focused_slot_controller(null)
	data.set_focused_slot_index(-1)


func set_highlight_slot(controller: DiceSlotController, index: int):
	controller.highlight_slot(index)
	data.set_highlighted_slot_controller(controller)
	data.set_highlighted_slot_index(index)


func remove_highlight_slot(controller: DiceSlotController, index: int):
	data.highlighted_slot_controller.unhighlight_slot(data.highlighted_slot_index)
	data.set_highlighted_slot_controller(null)
	data.set_highlighted_slot_index(-1)


func get_selected_slot_controller() -> DiceSlotController:
	return data.focused_slot_controller

func get_selected_slot_index() -> int:
	return data.focused_slot_index
