extends Node

@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual
@export var action_duration: float = 1.0
@export var knockback_offset: float = 100.0
@export var adjacent_offset: float = 50.0


# --- Evade vs Attack ---
func perform_evade_vs_attack_on_win_response():
	# LOGIC : restore stagger point
	# ACTION : perform evade
	character_visual.change_to_evade_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_evade_vs_attack_on_lose_response():
	# LOGIC : take full damage
	# ACTION : perform damaged + knockback
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_evade_vs_attack_on_draw_response():
	# LOGIC : nullify damage
	# ACTION : perform evade
	character_visual.change_to_evade_sprite()
	await get_tree().create_timer(action_duration).timeout


# --- Evade vs Guard ---
func perform_evade_vs_guard_on_win_response():
	# LOGIC : recover stagger 
	# ACTION : perform evade
	character_visual.change_to_evade_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_evade_vs_guard_on_lose_response():
	# LOGIC : take full stagger damage
	# ACTION : perform damaged + knockback
	character_visual.change_to_damaged_sprite()
	await get_tree().create_timer(action_duration).timeout

func perform_evade_vs_guard_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform nothing
	pass


# --- Evade vs Evade ---
func perform_evade_vs_evade_on_win_response():
	# LOGIC : both dice negated
	# ACTION : perform NOTHING
	pass

func perform_evade_vs_evade_on_lose_response():
	# LOGIC : both dice negated
	# ACTION : perform NOTHING
	pass

func perform_evade_vs_evade_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform NOTHING
	pass
