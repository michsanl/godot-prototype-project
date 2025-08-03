class_name CharacterBase
extends Node2D


@export var character_targeting: CharacterTargeting 
@export var character_stat: Character_Stat 
@export var character_ability_manager: CharacterAbilityManager

signal strategy_enter(target: CharacterBase)
signal strategy_exit

func handle_strategy_enter(new_target: CharacterBase):
	strategy_enter.emit(new_target)

func handle_strategy_exit():
	strategy_exit.emit()
