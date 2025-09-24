class_name TargetingManager
extends Node

@export var character_manager: CharacterManager
@export var view: AbilityView

var data: TargetingData
var player_characters: Array[CharacterController]  = []
var current_focus_controller: DiceSlotController
var current_focus_index: int

func _ready() -> void:
	initialize()


func initialize():
	player_characters.append_array(character_manager.get_all_characters())
	data = TargetingData.new()
	view.initialize()
	
	view.ability_button_pressed.connect(_on_ability_button_view_pressed)
	
	EventBus.slot_focus_entered.connect(_on_slot_focus_entered)
	EventBus.slot_focus_exited.connect(_on_slot_focus_exited)
	EventBus.slot_highlight_entered.connect(_on_slot_highlight_entered)
	EventBus.slot_highlight_exited.connect(_on_slot_highlight_exited)


#region Event Buss Listener
func _on_ability_button_view_pressed(index: int):
	set_selected_ability(index)


func _on_slot_focus_entered(controller: DiceSlotController, index):
	if data.focused_slot != null:
		remove_current_focus_slot()
	
	set_focus_slot(controller, index)
	update_ability_buttons(controller)


func _on_slot_focus_exited(controller: DiceSlotController, index):
	remove_focus_slot(controller, index)


func _on_slot_highlight_entered(controller: DiceSlotController, index):
	if data.focused_slot != null:
		return
	
	set_highlight_slot(controller, index)
	update_ability_buttons(controller)
	


func _on_slot_highlight_exited(controller: DiceSlotController, index):
	if data.focused_slot != null:
		return
	
	remove_highlight_slot(controller, index)
#endregion


func set_focus_slot(controller: DiceSlotController, index: int):
	current_focus_controller = controller
	current_focus_index = index
	var slot = controller.get_dice_slot(index)
	data.set_focused_slot(slot)
	view.show()


func remove_focus_slot(controller: DiceSlotController, index: int):
	controller.unfocus_slot(index)
	data.set_focused_slot(null)
	view.hide()


func remove_current_focus_slot():
	current_focus_controller.unfocus_slot(current_focus_index)
	data.set_focused_slot(null)
	view.hide()


func set_highlight_slot(controller: DiceSlotController, index: int):
	var slot = controller.get_dice_slot(index)
	data.set_highlighted_slot(slot)
	view.show()


func remove_highlight_slot(controller: DiceSlotController, index: int):
	controller.unhighlight_slot(index)
	data.set_highlighted_slot(null)
	view.hide()


func update_ability_buttons(controller: DiceSlotController):
	var abilities = controller.get_owner_unit().get_ability_controller().get_abilities()
	view.update_ability_buttons_icon(abilities)


func set_selected_ability(index: int):
	var player: CharacterController = data.focused_slot.get_owner()
	var ability: AbilityData = player.get_ability_controller().get_ability(index)
	data.set_selected_ability(ability)
	view.hide()


func finalize_targeting():
	var ability: AbilityData = data.selected_ability
	var target_slot: DiceSlotData = data.selected_enemy_slot
	
	data.selected_player_slot.set_selected_ability(ability)
	data.selected_player_slot.set_target_slot(target_slot)
