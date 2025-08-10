class_name ClashData
extends Resource

enum ClashResult { WIN, LOSE, DRAW }

var clash_result: ClashResult
var opponent: CharacterBase
var opponent_token: AbilityToken
var opponent_token_value: int

var owner_token: AbilityToken
var owner_token_value: int

#enum AttackTokenClashResult {
	#ATTACK_VS_ATTACK_WIN, 
	#ATTACK_VS_GUARD_WIN, 
	#ATTACK_VS_EVADE_WIN, 
	#ATTACK_VS_ATTACK_LOSE, 
	#ATTACK_VS_GUARD_LOSE, 
	#ATTACK_VS_EVADE_LOSE, 
	#ATTACK_VS_ATTACK_DRAW, 
	#ATTACK_VS_GUARD_DRAW, 
	#ATTACK_VS_EVADE_DRAW, 
#}
#
#enum GuardTokenClashResult {
	#GUARD_VS_ATTACK_WIN, 
	#GUARD_VS_GUARD_WIN, 
	#GUARD_VS_EVADE_WIN, 
	#GUARD_VS_ATTACK_LOSE, 
	#GUARD_VS_GUARD_LOSE, 
	#GUARD_VS_EVADE_LOSE, 
	#GUARD_VS_ATTACK_DRAW, 
	#GUARD_VS_GUARD_DRAW, 
	#GUARD_VS_EVADE_DRAW, 
#}
