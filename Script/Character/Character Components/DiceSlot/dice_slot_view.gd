class_name DiceSlotView
extends Control


func initialize(dice_slot: DiceSlotData):
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
			$Icon.modulate = Color(1, 1, 1) # normal
		DiceSlotData.DiceSlotState.ACTIVE:
			self.visible = true
			$Icon.modulate = Color(1, 1, 1) # normal
		DiceSlotData.DiceSlotState.HIGHLIGHT:
			$Icon.modulate = Color(1, 1, 0.5) # yellow glow tint
		DiceSlotData.DiceSlotState.STUNNED:
			$Icon.modulate = Color(0.5, 0.5, 0.5) # gray out


func update_target(new_target: DiceSlotData):
	if new_target == null:
		$Trajectory.clear_trajectory()
	else:
		$Trajectory.draw_trajectory(new_target.view.global_position)
