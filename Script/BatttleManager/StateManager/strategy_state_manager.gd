class_name StrategyStateManager
extends Node

signal strategy_ended

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]
@export var view: StrategyView

var _player_dice_slots: Array[DiceSlotData]
var _enemy_dice_slots: Array[DiceSlotData]


func _ready() -> void:
	view.roll_button_pressed.connect(_on_roll_button_pressed)
	view.combat_button_pressed.connect(_on_combat_button_pressed)
	view.set_button_panel_visibility(false)
	view.set_count_panel_visibility(false)


func handle_strategy_state_enter() -> void:
	_set_character_dice_slot_visibility(true)
	_setup_character_active_dice_slots()
	
	view.set_count_label_text("Scene: 1 ")
	view.set_count_panel_visibility(true)
	await get_tree().create_timer(1.0).timeout
	view.set_count_panel_visibility(false)
	
	view.set_button_panel_visibility(true)


func handle_strategy_state_exit() -> void:
	view.set_button_panel_visibility(false)
	view.set_count_panel_visibility(false)
	_set_character_dice_slot_visibility(false)


func _on_roll_button_pressed():
	_roll_character_dice_slot()
	_randomize_character_dice_slot_ability() # Temp method for debug
	_randomize_character_dice_slot_target() # Temp method for debug


func _on_combat_button_pressed():
	strategy_ended.emit()


func _set_character_dice_slot_visibility(condition: bool):
	for player in player_characters:
		player.dice_slot_controller.set_visibility(condition)
	for enemy in enemy_characters:
		enemy.dice_slot_controller.set_visibility(condition)


func _setup_character_active_dice_slots():
	_player_dice_slots.clear()
	for player in player_characters:
		var dice_slots = player.dice_slot_controller.dice_slots
		for dice_slot in dice_slots:
			if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
				_player_dice_slots.append(dice_slot)
	
	_enemy_dice_slots.clear()
	for enemy in enemy_characters:
		var dice_slots = enemy.dice_slot_controller.dice_slots
		for dice_slot in dice_slots:
			if dice_slot.state == DiceSlotData.DiceSlotState.ACTIVE:
				_enemy_dice_slots.append(dice_slot)


func _roll_character_dice_slot():
	for slot in _player_dice_slots:
		slot.roll_speed_value()
	
	for slot in _enemy_dice_slots:
		slot.roll_speed_value()


func _randomize_character_dice_slot_ability():
	for slot in _player_dice_slots:
		var ability = slot.owner_character.ability_controller.ability_list.pick_random()
		slot.set_selected_ability(ability)
	
	for slot in _enemy_dice_slots:
		var ability = slot.owner_character.ability_controller.ability_list.pick_random()
		slot.set_selected_ability(ability)


func _randomize_character_dice_slot_target():
	for player_slot in _player_dice_slots:
		player_slot.set_target_slot(_enemy_dice_slots.pick_random())
	
	for enemy_slot in _enemy_dice_slots:
		enemy_slot.set_target_slot(_player_dice_slots.pick_random())
