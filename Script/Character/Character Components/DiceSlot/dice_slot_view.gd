class_name DiceSlotView
extends Control

@export var model: DiceSlotModel


func _ready() -> void:
	model.speed_value_changed.connect(update_speed_value)
	model.state_changed.connect(update_state)


func update_speed_value(new_value: int):
	$ValueLabel.text = str(new_value)


func update_state(new_state: DiceSlotModel.DiceSlotState):
	match new_state:
		DiceSlotModel.DiceSlotState.ACTIVE:
			self.visible = true
			$Icon.modulate = Color(1, 1, 1) # normal
		DiceSlotModel.DiceSlotState.HIGHLIGHT:
			$Icon.modulate = Color(1, 1, 0.5) # yellow glow tint
		DiceSlotModel.DiceSlotState.STUNNED:
			$Icon.modulate = Color(0.5, 0.5, 0.5) # gray out
		DiceSlotModel.DiceSlotState.DISABLED:
			self.visible = false
