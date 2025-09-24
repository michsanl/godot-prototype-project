class_name StrategyStateManager
extends Node

signal strategy_ended

@export var player_characters: Array[CharacterController]
@export var enemy_characters: Array[CharacterController]
@export var view: StrategyView
@export var strategy_post_roll: IStrategyPostRoll

var scene_count: int = 0

func _ready() -> void:
	view.roll_button_pressed.connect(_on_roll_button_pressed)
	view.combat_button_pressed.connect(_on_combat_button_pressed)
	view.set_button_panel_visibility(false)
	view.set_count_panel_visibility(false)


func handle_strategy_state_enter() -> void:
	scene_count += 1
	view.set_count_label_text(str("Scene: ", scene_count))
	view.set_count_panel_visibility(true)
	_set_character_dice_slot_visibility(true)
	await get_tree().create_timer(1.0).timeout
	view.set_button_panel_visibility(true)
	view.set_count_panel_visibility(false)


func handle_strategy_state_exit() -> void:
	view.set_button_panel_visibility(false)
	view.set_count_panel_visibility(false)
	_set_character_dice_slot_visibility(false)


func _on_combat_button_pressed():
	strategy_ended.emit()


func _on_roll_button_pressed():
	# Fixed methods
	roll_slots(player_characters)
	roll_slots(enemy_characters)
	
	# Temporary Methods
	strategy_post_roll.execute(player_characters, enemy_characters)


func roll_slots(characters: Array[CharacterController]):
	for character: CharacterController in characters:
		for i in range(character.get_active_slots().size()):
			character.roll_slot_speed(i)


func _set_character_dice_slot_visibility(condition: bool):
	for player in player_characters:
		player.set_slot_system_visibility(condition)
	for enemy in enemy_characters:
		enemy.set_slot_system_visibility(condition)
