class_name StatsController
extends Node

@export var view: StatsView

var owner_unit: CharacterController

func initialize(new_owner: CharacterController):
	owner_unit = new_owner
	
