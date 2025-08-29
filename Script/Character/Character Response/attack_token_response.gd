class_name AttackTokenReseponse
extends Node

@export var movement_helper: CharacterMovement
@export var sprite_controller: CharacterSprite
@export var action_duration: float = 1.0
@export var knockback_offset: float = 100.0
@export var adjacent_offset: float = 50.0


# --- Attack vs Attack ---
func perform_attack_vs_attack_on_win_response():
	# LOGIC : deal full damage
	# ACTION : attack, knockback target
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_attack_on_draw_response():
	# LOGIC : negate both dice
	# ACTION : attack + back and forth
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_attack_on_lose_response():
	# LOGIC : take full damage
	# ACTION : damaged, 
	sprite_controller.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout


# --- Attack vs Guard ---
func perform_attack_vs_guard_on_win_response():
	# LOGIC : deal subtracted damage
	# ACTION : attack, 
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_guard_on_draw_response():
	# LOGIC : deal no damage
	# ACTION : attack + back and forth
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_guard_on_lose_response():
	# LOGIC : take subtracted stagger damage
	# ACTION : damaged + knockback
	sprite_controller.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout


# --- Attack vs Evade ---
func perform_attack_vs_evade_on_win_response():
	# LOGIC : deal full damage
	# ACTION : attack
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_evade_on_draw_response():
	# LOGIC : attack miss
	# ACTION : attack
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_attack_vs_evade_on_lose_response():
	# LOGIC : attack miss
	# ACTION : attack
	sprite_controller.change_to_slash_sprite()
	await get_tree().create_timer(action_duration).timeout
