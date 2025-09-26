class_name CharacterCombatView
extends Control

@export var dice_icon: PackedScene
@export var icon_container: HBoxContainer

var icons: Array[CombatDiceIcon] = []

func update_icons(dice: Array[BaseDice]):
	_clear_icons()
	_add_icons(dice)


func update_front_icon_post_roll(new_value: int):
	var front_icon = icons[0]
	front_icon.update_roll_label(str(new_value))
	front_icon.show_icon(false)


func update_front_icon_pre_roll(die: BaseDice):
	var front_icon = icons[0]
	front_icon.show_range_label(true)
	front_icon.show_roll_label(true)
	front_icon.update_range_label(_get_value_range_text(die))
	front_icon.update_roll_label(" ")


func _get_value_range_text(die: BaseDice) -> String:
	var min_val = die.get_min_val()
	var max_val = die.get_max_val()
	return str(min_val, "-", max_val)


func _remove_all_children(parent_node: Node):
	var children = parent_node.get_children()
	for child in children:
		parent_node.remove_child(child)
		child.queue_free()


func _clear_icons():
	icons.clear()
	_remove_all_children(icon_container)


# FIXME: implement object pooling
func _add_icons(dice: Array[BaseDice]):
	for die in dice:
		var new_icon = dice_icon.instantiate() as CombatDiceIcon
		new_icon.show_icon(true)
		new_icon.update_icon(die.get_icon())
		new_icon.show_range_label(false)
		new_icon.show_roll_label(false)
		icons.append(new_icon)
		icon_container.add_child(new_icon)
