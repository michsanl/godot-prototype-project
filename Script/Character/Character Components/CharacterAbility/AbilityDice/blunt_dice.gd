class_name BluntDice
extends BaseDice

func _init() -> void:
	dice_type = DiceType.BLUNT

func execute(source: CharacterController, opponent: CharacterController):
	opponent.get_stats().apply_damage(roll_val)
	#var knockback_pos = get_knockback(source, opponent, knockback_power * 3)
	#opponent.apply_knockback(knockback_pos)
	var knockback_dir = get_knockback_dir(source, opponent)
	opponent.apply_knockback_physics(knockback_dir)
	source.get_view().change_to_blunt_sprite()
	if vfx:
		source.get_vfx().set_sprite(vfx)
	await source.get_tree().create_timer(duration).timeout
	source.get_view().change_to_default_sprite()
	source.get_vfx().clear_vfx()

func execute_draw(source: CharacterController, opponent: CharacterController):
	var knockback_pos = get_knockback(source, opponent, knockback_power/2)
	opponent.apply_draw_knockback(knockback_pos)
	source.get_view().change_to_blunt_sprite()
	if vfx:
		source.get_vfx().set_sprite(vfx)
	await source.get_tree().create_timer(duration).timeout
	source.get_view().change_to_default_sprite()
	source.get_vfx().clear_vfx()
