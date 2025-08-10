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


#region Play Token Response : Attack Token 
func perform_attack_token_response_on_win(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : deal full damage
			# ACTION : perform attack, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : deal subtracted damage
			# ACTION : perform attack, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : deal full damage
			# ACTION : perform attack, 
			pass


func perform_attack_token_response_on_lose(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : take subtracted stagger damage
			# ACTION : perform attack + move back and forth, damaged + knockback
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : nothing
			# ACTION : perform attack, 
			pass


func perform_attack_token_response_on_draw(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : both dice negated
			# ACTION : perform attack + move back and forth,  
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : nullify damage
			# ACTION : perform attack, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : nullify damage
			# ACTION : perform attack, 
			pass
#endregion


#region Play Token Response : Guard Token 
func perform_guard_token_response_on_win(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : deal subtracted stagger damage
			# ACTION : perform guard, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : deal full stagger damage
			# ACTION : perform guard, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : deal full stagger damage
			# ACTION : perform guard, 
			pass


func perform_guard_token_response_on_lose(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : take subtracted damage
			# ACTION : perform damaged, knockback, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : take full stagger damage 
			# ACTION : perform damaged + back and forth , knockback, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : nothing
			# ACTION : perform guard
			pass


func perform_guard_token_response_on_draw(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : nullify damage
			# ACTION : perform guard, move back and forth,  
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : both dice negated
			# ACTION : perform guard, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform nothing
			pass
#endregion


#region Perform Token Response : Evade Token 
func perform_evade_token_response_on_win(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : 
			# ACTION : perform evade, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : recover stagger 
			# ACTION : perform evade, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform nothing
			pass


func perform_evade_token_response_on_lose(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : take full damage
			# ACTION : perform damaged, knockback by guard, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform nothing
			pass


func perform_evade_token_response_on_draw(opponent_token: AbilityToken):
	match opponent_token.token_type:
		opponent_token.TokenType.ATTACK:
			# LOGIC : nullify damage
			# ACTION : perform evade, 
			pass
		opponent_token.TokenType.GUARD:
			# LOGIC : both dice negated
			# ACTION : perform nothing, 
			pass
		opponent_token.TokenType.EVADE:
			# LOGIC : both dice negated
			# ACTION : perform nothing, 
			pass
#endregion
