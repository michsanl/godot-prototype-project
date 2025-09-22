class_name CharacterCombatView
extends Panel

@export var combat_controller: CharacterCombatController
@export var dice_icons: Array[TextureRect]

func _ready() -> void:
	combat_controller.roll_value_changed.connect(_on_roll_value_changed)
	combat_controller.dice_list_changed.connect(dice_list_changed)
	combat_controller.front_die_changed.connect(front_die_changed)

func _on_roll_value_changed(new_value: int):
	pass


func dice_list_changed(dice: Array[IDice]):
	for dice_icon in dice_icons:
		dice_icon.visible = false
	
	for i in range(dice.size()):
		dice_icons[i].visible = true
	


func front_die_changed(die: IDice):
	pass
