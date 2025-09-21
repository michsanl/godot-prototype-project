class_name DiceSlotView
extends Control

signal button_pressed(index: int)

var index: int

func initialize(dice_slot: DiceSlotData, new_index: int):
	index = new_index
	dice_slot.speed_value_changed.connect(update_speed_value)
	dice_slot.state_changed.connect(update_state)
	dice_slot.target_slot_changed.connect(update_target)
	update_speed_value(dice_slot.speed_value)
	update_state(dice_slot.state)
	update_target(dice_slot.target_dice_slot)


func update_speed_value(new_value: int):
	$ValueLabel.text = str(new_value)


func update_state(new_state: DiceSlotData.DiceSlotState):
	match new_state:
		DiceSlotData.DiceSlotState.INACTIVE:
			self.visible = false
			#$Icon.modulate = Color(1, 1, 1) # normal
		DiceSlotData.DiceSlotState.ACTIVE:
			self.visible = true
			#$Icon.modulate = Color(1, 1, 1) # normal
		DiceSlotData.DiceSlotState.HIGHLIGHT:
			self.visible = true
			#$Icon.modulate = Color(1, 1, 0.5) # yellow glow tint
		DiceSlotData.DiceSlotState.STUNNED:
			self.visible = true
			#$Icon.modulate = Color(0.5, 0.5, 0.5) # gray out


func update_target(new_target: DiceSlotData):
	if new_target != null:
		$Trajectory.draw_trajectory(new_target.view.global_position)
	else:
		$Trajectory.clear_trajectory()


func _on_button_toggled() -> void:
	button_pressed.emit(index)
