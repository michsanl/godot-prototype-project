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
	view.button_pressed.connect(_on_ability_button_pressed)
	
	player_characters.append_array(character_manager.get_player_characters())
	enemy_characters.append_array(character_manager.get_enemy_characters())
	
	for player in player_characters:
		player.get_slot_controller().dice_slot_pressed.connect(_on_player_slot_pressed)
	for enemy in enemy_characters:
		enemy.get_slot_controller().dice_slot_pressed.connect(_on_enemy_slot_pressed)


func _on_player_slot_pressed(dice_slot: DiceSlotData):
	data.set_player_selected_slot(dice_slot)
	view.show()


func _on_ability_button_pressed(index: int):
	var player: CharacterController = data.selected_player_slot.get_owner()
	var ability: AbilityData = player.get_ability_controller().get_ability(index)
	data.set_selected_ability(ability)
	view.hide()


func _on_enemy_slot_pressed(dice_slot: DiceSlotData):
	data.set_enemy_selected_slot(dice_slot)
	finalize_targeting()


func finalize_targeting():
	var ability: AbilityData = data.selected_ability
	var target_slot: DiceSlotData = data.selected_enemy_slot
	
	data.selected_player_slot.set_selected_ability(ability)
	data.selected_player_slot.set_target_slot(target_slot)
