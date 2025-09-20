class_name BluntDice
extends IDice

func _init() -> void:
	dice_type = DiceType.BLUNT

func execute(owner: CharacterController, opponent: CharacterController):
	opponent.get_health().damage(roll_val)
	
	owner.get_view().change_to_blunt_sprite()
	if vfx:
		owner.get_vfx().set_sprite(vfx)
	
	await owner.get_tree().create_timer(duration).timeout
	
	owner.get_view().change_to_default_sprite()
	owner.get_vfx().clear_vfx()
