class_name SlashDice
extends BaseDice

func _init() -> void:
	dice_type = DiceType.SLASH

func execute(owner: CharacterController, opponent: CharacterController):
	opponent.get_stats().apply_damage(roll_val)
	var knockback_pos = get_knockback(owner, opponent, knockback_power * 3)
	opponent.apply_knockback(knockback_pos)
	owner.get_view().change_to_slash_sprite()
	if vfx:
		owner.get_vfx().set_sprite(vfx)
	await owner.get_tree().create_timer(duration).timeout
	owner.get_view().change_to_default_sprite()
	owner.get_vfx().clear_vfx()

func execute_draw(owner: CharacterController, opponent: CharacterController):
	var knockback_pos = get_knockback(owner, opponent, knockback_power/2)
	opponent.apply_draw_knockback(knockback_pos)
	owner.get_view().change_to_slash_sprite()
	if vfx:
		owner.get_vfx().set_sprite(vfx)
	await owner.get_tree().create_timer(duration).timeout
	owner.get_view().change_to_default_sprite()
	owner.get_vfx().clear_vfx()
