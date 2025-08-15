class_name GuardTokenReseponse
extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual
@export var action_duration: float = 1.0
@export var knockback_offset: float = 100.0
@export var adjacent_offset: float = 50.0


# --- Guard vs Attack ---
func perform_guard_vs_attack_on_win_response():
	# LOGIC : deal subtracted stagger damage
	# ACTION : perform guard
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_attack_on_lose_response():
	# LOGIC : take subtracted damage
	# ACTION : perform damaged + knockback
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_attack_on_draw_response():
	# LOGIC : nullify damage
	# ACTION : perform guard + move back and forth
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout


# --- Guard vs Guard ---
func perform_guard_vs_guard_on_win_response():
	# LOGIC : deal full stagger damage
	# ACTION : perform guard
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_guard_on_lose_response():
	# LOGIC : take full stagger damage 
	# ACTION : perform damaged + back and forth , knockback, 
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_guard_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform guard
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout


# --- Guard vs Evade ---
func perform_guard_vs_evade_on_win_response():
	# LOGIC : deal full stagger damage
	# ACTION : perform guard
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_evade_on_lose_response():
	# LOGIC : nothing
	# ACTION : perform guard
	character_visual.change_to_guard_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_guard_vs_evade_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform NOTHING
	pass
