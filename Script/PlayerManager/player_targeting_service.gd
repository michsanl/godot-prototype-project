class_name PlayerTargetingService
extends Node

enum TargetingState { NONE_SELECTED, SLOT_SELECTED, ABILITY_SELECTED }

@export var character_manager: CharacterManager
@export var view: AbilityView

var player_characters: Array[CharacterController]  = []
var enemy_characters: Array[CharacterController]  = []
var selected_player_slot: DiceSlotData
var selected_enemy_slot: DiceSlotData
var selected_ability_index: int
var state: TargetingState


func _ready() -> void:
	initialize()


func initialize():
	# Gather player characters
	player_characters.append_array(character_manager.get_player_characters())
	enemy_characters.append_array(character_manager.get_enemy_characters())
	
	# Respond when selected slot changed
	for player in player_characters:
		player.get_slot_controller().selected_slot_changed.connect(_on_player_selected_slot_changed)
	for enemy in enemy_characters:
		enemy.get_slot_controller().selected_slot_changed.connect(_on_enemy_selected_slot_changed)
	
	# Respond when ability button pressed
	view.button_pressed.connect(_on_ability_button_pressed)


func set_state(new_sate: TargetingState):
	state = new_sate


func resolve_state_change():
	match state:
		TargetingState.NONE_SELECTED:
			set_state(TargetingState.SLOT_SELECTED)
		TargetingState.SLOT_SELECTED:
			execute_ability_selection()
			set_state(TargetingState.ABILITY_SELECTED)
		TargetingState.ABILITY_SELECTED:
			execute_player_targeting()
			set_state(TargetingState.NONE_SELECTED)


func execute_ability_selection():
	var ability = selected_player_slot.get_owner().get_ability_controller().get_ability(selected_ability_index)
	selected_player_slot.set_selected_ability(ability)


func execute_player_targeting():
	selected_player_slot.set_target_slot(selected_enemy_slot)
	clear_targeting_properties()


#region SUBSCRIBER
func _on_player_selected_slot_changed(new_slot: DiceSlotData):
	set_player_selected_slot(new_slot)
	resolve_state_change()


func _on_enemy_selected_slot_changed(new_slot: DiceSlotData):
	set_enemy_selected_slot(new_slot)
	resolve_state_change()


func _on_ability_button_pressed(index: int):
	set_selected_ability_index(index)
	resolve_state_change()
#endregion


func clear_targeting_properties():
	selected_player_slot = null
	selected_enemy_slot = null
	selected_ability_index = -1

func set_player_selected_slot(new_slot: DiceSlotData):
	selected_player_slot = new_slot

func set_enemy_selected_slot(new_slot: DiceSlotData):
	selected_enemy_slot = new_slot

func set_selected_ability_index(index: int):
	selected_ability_index = index
