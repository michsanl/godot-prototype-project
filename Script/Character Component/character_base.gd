class_name CharacterBase
extends Node2D

signal strategy_enter(target: CharacterBase)
signal strategy_exit

@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var character_ability_manager: CharacterAbilityManager
@export var character_action: CharacterAction
@export var character_movement: CharacterMovement
@export var character_visual: CharacterVisual

@onready var initial_position: Vector2 = self.position


func reset_character_condition():
	self.position = initial_position
	character_action.reset_visual()


#region Character Action
func approach_target_one_sided(target: CharacterBase):
	await character_action.perform_approach_one_sided_action(self, target)


func approach_target_two_sided(target: CharacterBase):
	await character_action.perform_approach_two_sided_action(self, target)


func perform_slash_attack_win(target: CharacterBase):
	await character_action.perform_slash_attack_win(self, target)


func perform_slash_attack_draw(attacker: CharacterBase):
	await character_action.perform_slash_attack_draw(self, attacker)


func perform_damaged_action(attacker: CharacterBase):
	await character_action.perform_damaged_action(self, attacker)
#endregion


#region Character Targeting
func set_target(new_target: CharacterBase) -> void:
	character_targeting.set_target(new_target)


func set_aim_target(new_target: CharacterBase) -> void:
	character_targeting.set_aim_target(new_target)


func remove_target() -> void:
	character_targeting.remove_target()


func remove_aim_target() -> void:
	character_targeting.remove_aim_target()
#endregion


func randomize_dice_point() -> void:
	character_stat.randomize_dice_point()


#region Process Clash Response : Process Owner Token Type
func process_clash_response(clash_data: ClashData):
	var owner_token_type: AbilityToken.TokenType = clash_data.owner_token.token_type
	match owner_token_type:
		clash_data.owner_token.TokenType.ATTACK:
			process_attack_token_clash_response(clash_data)
		clash_data.owner_token.TokenType.GUARD:
			process_guard_token_clash_response(clash_data)
		clash_data.owner_token.TokenType.EVADE:
			process_evade_token_clash_response(clash_data)
#endregion


#region Process Clash Response : Process Combat Result
func process_attack_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			perform_attack_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			perform_attack_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			perform_attack_token_response_on_draw(clash_data)


func process_guard_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			pass
		clash_data.ClashResult.LOSE:
			pass
		clash_data.ClashResult.DRAW:
			pass


func process_evade_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			pass
		clash_data.ClashResult.LOSE:
			pass
		clash_data.ClashResult.DRAW:
			pass
#endregion


#region Play Token Response : Attack Token 
func perform_attack_token_response_on_win(clash_data: ClashData):
	match clash_data.clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : deal full damage
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : deal subtracted damage
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : deal full damage
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass


func perform_attack_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback, 
			character_visual.change_to_damaged_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : take subtracted stagger damage
			# ACTION : perform attack + move back and forth, damaged + knockback
			character_visual.change_to_slash_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : nothing
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass


func perform_attack_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : both dice negated
			# ACTION : perform attack + move back and forth,  
			character_visual.change_to_slash_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : nullify damage
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : nullify damage
			# ACTION : perform attack, 
			character_visual.change_to_slash_sprite()
			pass
#endregion


#region Play Token Response : Guard Token 
func perform_guard_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : deal subtracted stagger damage
			# ACTION : perform guard, 
			character_visual.change_to_guard_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : deal full stagger damage
			# ACTION : perform guard, 
			character_visual.change_to_guard_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : deal full stagger damage
			# ACTION : perform guard, 
			character_visual.change_to_guard_sprite()
			pass


func perform_guard_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : take subtracted damage
			# ACTION : perform damaged, knockback, 
			character_visual.change_to_damaged_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : take full stagger damage 
			# ACTION : perform damaged + back and forth , knockback, 
			character_visual.change_to_damaged_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : nothing
			# ACTION : perform guard
			character_visual.change_to_guard_sprite()
			pass


func perform_guard_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : nullify damage
			# ACTION : perform guard, move back and forth,  
			character_visual.change_to_guard_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : both dice negated
			# ACTION : perform guard, 
			character_visual.change_to_guard_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform NOTHING
			character_visual.change_to_guard_sprite()
			pass
#endregion


#region Perform Token Response : Evade Token 
func perform_evade_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : 
			# ACTION : perform evade, 
			character_visual.change_to_evade_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : recover stagger 
			# ACTION : perform evade, 
			character_visual.change_to_evade_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform NOTHING
			character_visual.change_to_evade_sprite()
			pass


func perform_evade_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback, 
			character_visual.change_to_damaged_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback by guard, 
			character_visual.change_to_damaged_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform NOTHING
			character_visual.change_to_evade_sprite()
			pass


func perform_evade_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			# LOGIC : nullify damage
			# ACTION : perform evade, 
			character_visual.change_to_evade_sprite()
			pass
		clash_data.opponent_token.TokenType.GUARD:
			# LOGIC : both dice negated
			# ACTION : perform nothing, 
			character_visual.change_to_evade_sprite()
			pass
		clash_data.opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform nothing, 
			character_visual.change_to_evade_sprite()
			pass
#endregion


#region Clash Response Methods
# --- Attack vs Attack ---
func perform_attack_vs_attack_on_win_response():
	pass

func perform_attack_vs_attack_on_lose_response():
	pass

func perform_attack_vs_attack_on_draw_response():
	pass


# --- Attack vs Guard ---
func perform_attack_vs_guard_on_win_response():
	pass

func perform_attack_vs_guard_on_lose_response():
	pass

func perform_attack_vs_guard_on_draw_response():
	pass


# --- Attack vs Evade ---
func perform_attack_vs_evade_on_win_response():
	pass

func perform_attack_vs_evade_on_lose_response():
	pass

func perform_attack_vs_evade_on_draw_response():
	pass


# --- Guard vs Attack ---
func perform_guard_vs_attack_on_win_response():
	pass

func perform_guard_vs_attack_on_lose_response():
	pass

func perform_guard_vs_attack_on_draw_response():
	pass


# --- Guard vs Guard ---
func perform_guard_vs_guard_on_win_response():
	pass

func perform_guard_vs_guard_on_lose_response():
	pass

func perform_guard_vs_guard_on_draw_response():
	pass


# --- Guard vs Evade ---
func perform_guard_vs_evade_on_win_response():
	pass

func perform_guard_vs_evade_on_lose_response():
	pass

func perform_guard_vs_evade_on_draw_response():
	pass


# --- Evade vs Attack ---
func perform_evade_vs_attack_on_win_response():
	pass

func perform_evade_vs_attack_on_lose_response():
	pass

func perform_evade_vs_attack_on_draw_response():
	pass


# --- Evade vs Guard ---
func perform_evade_vs_guard_on_win_response():
	pass

func perform_evade_vs_guard_on_lose_response():
	pass

func perform_evade_vs_guard_on_draw_response():
	pass


# --- Evade vs Evade ---
func perform_evade_vs_evade_on_win_response():
	pass

func perform_evade_vs_evade_on_lose_response():
	pass

func perform_evade_vs_evade_on_draw_response():
	pass
#endregion
