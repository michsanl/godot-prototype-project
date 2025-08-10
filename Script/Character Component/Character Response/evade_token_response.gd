extends Node


# --- Evade vs Attack ---
func perform_evade_vs_attack_on_win_response():
	# LOGIC : restore stagger point
	# ACTION : perform evade, 
	pass

func perform_evade_vs_attack_on_lose_response():
	# LOGIC : take full damage
	# ACTION : perform damaged, knockback, 
	pass

func perform_evade_vs_attack_on_draw_response():
	# LOGIC : nullify damage
	# ACTION : perform evade, 
	pass


# --- Evade vs Guard ---
func perform_evade_vs_guard_on_win_response():
	# LOGIC : recover stagger 
	# ACTION : perform evade, 
	pass

func perform_evade_vs_guard_on_lose_response():
	# LOGIC : take full stagger damage
	# ACTION : perform damaged, knockback by guard, 
	pass

func perform_evade_vs_guard_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform nothing, 
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
	# ACTION : perform nothing, 
	pass
