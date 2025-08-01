extends Node2D
class_name Character_Base

@export var target_manager: Character_Targeting 
@export var character_stat: Character_Stat 
@export var character_ability: Character_Ability

signal strategy_enter(target: Character_Base)
signal strategy_exit

func handle_strategy_enter(new_target: Character_Base):
	strategy_enter.emit(new_target)

func handle_strategy_exit():
	strategy_exit.emit()
