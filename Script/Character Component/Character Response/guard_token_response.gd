extends Node


# --- Guard vs Attack ---
func perform_guard_vs_attack_on_win_response():
	# LOGIC : deal subtracted stagger damage
	# ACTION : perform guard, 
	pass

func perform_guard_vs_attack_on_lose_response():
	# LOGIC : take subtracted damage
	# ACTION : perform damaged, knockback, 
	pass

func perform_guard_vs_attack_on_draw_response():
	# LOGIC : nullify damage
	# ACTION : perform guard, move back and forth,  
	pass


# --- Guard vs Guard ---
func perform_guard_vs_guard_on_win_response():
	# LOGIC : deal full stagger damage
	# ACTION : perform guard, 
	pass

func perform_guard_vs_guard_on_lose_response():
	# LOGIC : take full stagger damage 
	# ACTION : perform damaged + back and forth , knockback, 
	pass

func perform_guard_vs_guard_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform guard, 
	pass


# --- Guard vs Evade ---
func perform_guard_vs_evade_on_win_response():
	# LOGIC : deal full stagger damage
	# ACTION : perform guard, 
	pass

func perform_guard_vs_evade_on_lose_response():
	# LOGIC : nothing
	# ACTION : perform guard
	pass

func perform_guard_vs_evade_on_draw_response():
	# LOGIC : both dice negated
	# ACTION : perform NOTHING
	pass
