class_name CharacterCombatView
extends Panel

@export var combat_controller: CharacterCombatController
@export var dice_icon: PackedScene
@export var icon_container: HBoxContainer

func _ready() -> void:
	combat_controller.roll_value_changed.connect(_on_roll_value_changed)
	combat_controller.dice_list_changed.connect(dice_list_changed)
	combat_controller.front_die_changed.connect(front_die_changed)

func _on_roll_value_changed(new_value: int):
	pass


func dice_list_changed(dice: Array[IDice]):
	remove_all_children(icon_container)
	for die in dice:
		var new_icon = dice_icon.instantiate() as CombatDiceIcon
		new_icon.update_icon(die.get_icon())
		new_icon.update_range_label(_get_value_range_text(die))
		new_icon.update_roll_label(str(die.get_roll_value()))
		icon_container.add_child(new_icon)


func front_die_changed(die: IDice):
	pass


func _get_value_range_text(die: IDice) -> String:
	var min = die.get_min_val()
	var max = die.get_max_val()
	return str(die.get_min_val(), "-", die.get_max_val())


func remove_all_children(parent_node: Node):
	var children = parent_node.get_children()
	for child in children:
		parent_node.remove_child(child)
		child.queue_free()
