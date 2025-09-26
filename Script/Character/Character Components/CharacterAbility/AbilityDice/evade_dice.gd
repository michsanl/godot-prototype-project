class_name EvadeDice
extends IDice

func _init() -> void:
	dice_type = DiceType.EVADE

func execute(source: CharacterController, opponent: CharacterController):
	source.get_view().change_to_evade_sprite()
	await source.get_tree().create_timer(duration).timeout
	source.get_view().change_to_default_sprite()

func execute_draw(source: CharacterController, opponent: CharacterController):
	source.get_view().change_to_default_sprite()
	await source.get_tree().create_timer(duration).timeout
	source.get_view().change_to_default_sprite()
