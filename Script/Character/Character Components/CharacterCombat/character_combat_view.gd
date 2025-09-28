class_name CharacterCombatView
extends Control

enum FacingDirection { FACE_LEFT, FACE_RIGHT }

@export var dice_icon: PackedScene
@export var icon_container: HBoxContainer
@export var panel: Panel
@export var icons: Array[CombatDiceIcon] = []

var facing: FacingDirection
var pool: Array[CombatDiceIcon] = []

func _ready() -> void:
	update_facing(FacingDirection.FACE_RIGHT)


func update_facing(facing_direction: FacingDirection):
	facing = facing_direction
	match facing_direction:
		FacingDirection.FACE_LEFT:
			_face_left()
		FacingDirection.FACE_RIGHT:
			_face_right()


func update_icons(dice: Array[BaseDice]) -> void:
	# Clear existing icons first
	for icon in icons:
		icon_container.remove_child(icon)
		icon.queue_free()
	icons.clear()

	# Add new icons
	for die in dice:
		var new_icon = dice_icon.instantiate() as CombatDiceIcon
		new_icon.show_icon_texture(true)
		new_icon.update_icon_texture(die.get_icon())
		new_icon.show_range_label(false)
		new_icon.show_roll_label(false)

		icon_container.add_child(new_icon)
		icons.append(new_icon)


func update_roll_label(icon_index: int, new_value: int):
	var icon = _get_icon_safe(icon_index)
	if icon:
		icon.update_roll_label(str(new_value))


func update_range_label(icon_index: int, min_val: int, max_val: int):
	var icon = _get_icon_safe(icon_index)
	if icon:
		icon.update_range_label("%d-%d" % [min_val, max_val])


#region Set Visibility Region
func update_icon_texture_visibility(icon_index: int, condition: bool):
	var icon = _get_icon_safe(icon_index)
	if icon:
		icon.show_icon_texture(condition)

func update_roll_label_visibility(icon_index: int, condition: bool):
	var icon = _get_icon_safe(icon_index)
	if icon:
		icon.show_roll_label(condition)

func update_range_label_visibility(icon_index: int, condition: bool):
	var icon = _get_icon_safe(icon_index)
	if icon:
		icon.show_range_label(condition)
#endregion


func _face_left():
	panel.layout_direction = Control.LAYOUT_DIRECTION_LTR

func _face_right():
	panel.layout_direction = Control.LAYOUT_DIRECTION_RTL


func _get_icon_safe(index: int) -> CombatDiceIcon:
	if index < 0 or index >= icons.size():
		push_warning("Invalid icon index: %d" % index)
		return null
	return icons[index]
