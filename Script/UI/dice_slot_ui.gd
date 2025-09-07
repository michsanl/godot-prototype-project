extends Button

@export var dice_slot: DiceSlotData


func _on_dice_slot_speed_value_changed(value: int) -> void:
	set_text(value as String)
