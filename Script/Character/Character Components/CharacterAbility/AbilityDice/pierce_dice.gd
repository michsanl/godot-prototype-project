class_name PierceDice
extends BaseDice

func _init() -> void:
	dice_type = DiceType.PIERCE

func execute(owner: CharacterController, opponent: CharacterController):
	opponent.get_stats().apply_damage(roll_val)
	opponent.apply_knockback_physics(_get_direction(opponent))
	owner.get_view().change_to_pierce_sprite()
	if vfx:
		owner.get_vfx().set_sprite(vfx)
	await owner.get_tree().create_timer(duration).timeout
	owner.get_view().change_to_default_sprite()
	owner.get_vfx().clear_vfx()

func execute_draw(owner: CharacterController, opponent: CharacterController):
	var knockback_pos = get_knockback(owner, opponent, knockback_power/2)
	opponent.apply_draw_knockback(knockback_pos)
	owner.get_view().change_to_pierce_sprite()
	if vfx:
		owner.get_vfx().set_sprite(vfx)
	await owner.get_tree().create_timer(duration).timeout
	owner.get_view().change_to_default_sprite()
	owner.get_vfx().clear_vfx()
