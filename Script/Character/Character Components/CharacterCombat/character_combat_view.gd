class_name CharacterCombatView
extends Panel

# 

@export var combat_controller: CharacterCombatController
@export var dice_icon: PackedScene
@export var icon_container: HBoxContainer

var icons: Array[CombatDiceIcon]

func _ready() -> void:
	combat_controller.dice_list_changed.connect(_on_dice_list_changed)
	combat_controller.roll_value_changed.connect(_on_post_roll)
	combat_controller.front_die_changed.connect(_on_pre_roll)
	combat_controller.combat_initialized.connect(_on_combat_initialized)
	combat_controller.combat_finalized.connect(_on_combat_finalized)
	
	hide()

# FIXME: implement object pooling
func _on_combat_initialized(dice: Array[IDice]):
	icons.clear()
	remove_all_children(icon_container)
	for die in dice:
		var new_icon = dice_icon.instantiate() as CombatDiceIcon
		new_icon.show_icon(true)
		new_icon.update_icon(die.get_icon())
		new_icon.show_range_label(false)
		new_icon.show_roll_label(false)
		icons.append(new_icon)
		icon_container.add_child(new_icon)
		
	show()


func _on_combat_finalized():
	hide()


# FIXME: implement object pooling
func _on_dice_list_changed(dice: Array[IDice]):
	icons.clear()
	remove_all_children(icon_container)
	for die in dice:
		var new_icon = dice_icon.instantiate() as CombatDiceIcon
		new_icon.update_icon(die.get_icon())
		new_icon.show_range_label(false)
		new_icon.show_roll_label(false)
		icons.append(new_icon)
		icon_container.add_child(new_icon)


func _on_pre_roll(die: IDice):
	var front_icon = icons[0]
	front_icon.show_range_label(true)
	front_icon.show_roll_label(true)
	front_icon.update_range_label(_get_value_range_text(die))
	front_icon.update_roll_label("?")
	pass


func _on_post_roll(new_value: int):
	var front_icon = icons[0]
	front_icon.update_roll_label(str(new_value))
	front_icon.show_icon(false)


func _get_value_range_text(die: IDice) -> String:
	var min_val = die.get_min_val()
	var max_val = die.get_max_val()
	return str(min_val, "-", max_val)


func remove_all_children(parent_node: Node):
	var children = parent_node.get_children()
	for child in children:
		parent_node.remove_child(child)
		child.queue_free()
