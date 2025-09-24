class_name TargetingManager
extends Node

@export var character_manager: CharacterManager
@export var view: AbilityView

var data: TargetingData
var player_characters: Array[CharacterController]  = []
var enemy_characters: Array[CharacterController]  = []

func _ready() -> void:
	initialize()


func initialize():
	data = TargetingData.new()
	view.initialize(data)
	
	player_characters.append_array(character_manager.get_player_characters())
	enemy_characters.append_array(character_manager.get_enemy_characters())
	
	view.button_pressed.connect(_on_ability_button_pressed)
	EventBus.slot_focus_entered.connect(_on_slot_focus_entered)
	EventBus.slot_focus_exited.connect(_on_on_slot_focus_exited)


func _on_ability_button_pressed(index: int):
	var player: CharacterController = data.selected_player_slot.get_owner()
	var ability: AbilityData = player.get_ability_controller().get_ability(index)
	data.set_selected_ability(ability)
	view.hide()


func _on_slot_focus_entered(dice_slot: DiceSlotData):
	data.set_player_selected_slot(dice_slot)
	view.show()


func _on_on_slot_focus_exited():
	data.set_enemy_selected_slot(null)


func finalize_targeting():
	var ability: AbilityData = data.selected_ability
	var target_slot: DiceSlotData = data.selected_enemy_slot
	
	data.selected_player_slot.set_selected_ability(ability)
	data.selected_player_slot.set_target_slot(target_slot)
