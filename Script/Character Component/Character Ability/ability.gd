class_name Ability
extends Node

@export var ability_stats: AbilityStats


#func _ready() -> void:
	#for i in ability_token.size():
		#if ability_token[i] == null:
			#ability_token.clear()
			#set_token_automatically()
			#break
#
#func set_token_automatically():
	#for child in get_children():
		#if child is Ability_Token:
			#ability_token.append(child as Ability_Token) 
	#print(name, " token has been set")
