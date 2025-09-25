class_name CharacterController
extends Node2D

@export var is_player: bool
@export var char_name: String
@export var data: CharacterData
@export var stats: CharacterStats
@export var sprite: CharacterSprite
@export var vfx: VFXController
@export var movement: CharacterMovement
@export var health_controller: HealthController
@export var dice_slot_controller: DiceSlotController
@export var ability_controller: CharacterAbilityController
@export var action_controller: CharacterActionController
@export var combat_controller: CharacterCombatController

# FIXME: 
var _initial_position: Vector2
var _initial_slot_amount: int = 2

func _ready() -> void:
	_initialize_childs()
	_initial_position = self.position


func _initialize_childs():
	sprite.initialize(self)
	movement.initialize(self)
	ability_controller.initialize(self)
	action_controller.initialize(self)
	dice_slot_controller.initialize(self, _initial_slot_amount)
	health_controller.initialize(self, 100)


#region GETTER Methods
func get_character_name() -> String:
	return char_name
func get_data() -> CharacterData:
	return data
func get_view() -> CharacterSprite:
	return sprite
func get_vfx() -> VFXController:
	return vfx
func get_movement() -> CharacterMovement:
	return movement
func get_health() -> HealthController:
	return health_controller
func get_slot_controller() -> DiceSlotController:
	return dice_slot_controller
func get_ability_controller() -> CharacterAbilityController:
	return ability_controller
func get_action_controller() -> CharacterActionController:
	return action_controller
func get_combat_controller() -> CharacterCombatController:
	return combat_controller
#endregion


#region Combat Controller API
func initialize_combat(dice_slot: DiceSlotData):
	if dice_slot == null:
		push_warning("Initiating combat with null slot")
		
	combat_controller.initialize_combat(dice_slot)


func update_front_die():
	combat_controller.update_front_dice()


func roll_front_die() -> void:
	combat_controller.roll_front_die()


func pop_front_die() -> void:
	combat_controller.pop_front_die()


func has_dice() -> bool:
	return combat_controller.has_dice()


func execute_front_die(target: CharacterController) -> void:
	await combat_controller.get_front_die().execute(self, target)


func execute_front_die_draw(target: CharacterController) -> void:
	await combat_controller.get_front_die().execute_draw(self, target)


func get_roll_value() -> int:
	return combat_controller.get_roll_value()
#endregion


#region Dice Slot Controller API
func roll_slot_speed(index: int):
	dice_slot_controller.roll_dice_slot_speed(index)

func clear_slot_speed(index: int):
	dice_slot_controller.clear_dice_slot_speed(index)

func set_slot_system_visibility(condition: bool):
	dice_slot_controller.set_system_visibility(condition)

func set_slot_ability(index: int, new_ability: AbilityData):
	if new_ability:
		dice_slot_controller.select_slot_ability(index, new_ability)
	else:
		dice_slot_controller.unselect_slot_ability(index)

func set_slot_target(index: int, target_index: int, target_contr: DiceSlotController):
	if target_contr:
		dice_slot_controller.select_slot_target(index, target_index, target_contr)
	else:
		dice_slot_controller.unselect_slot_target(index)

func clear_active_slots_data():
	dice_slot_controller.clear_active_slots_data()

func get_active_dice_slot(index: int) -> DiceSlotData:
	return dice_slot_controller.get_active_dice_slot(index)

func get_random_active_dice_slot() -> DiceSlotData:
	return dice_slot_controller.get_random_active_dice_slot()

func get_active_dice_slots() -> Array[DiceSlotData]:
	return dice_slot_controller.get_active_dice_slots()
#endregion


#region Ability Controller API
func get_random_ability() -> AbilityData:
	return ability_controller.get_random_ability()
func get_ability(index: int) -> AbilityData:
	return ability_controller.get_ability(index)
func get_abilities() -> Array[AbilityData]:
	return ability_controller.get_abilities()
#endregion


#region Action Controller
func approach_target_one_sided(target: CharacterController):
	await action_controller.perform_approach_one_sided_action(target)


func approach_target_two_sided(target: CharacterController):
	await action_controller.perform_approach_two_sided_action(self, target)
#endregion


#region Combat
func apply_knockback(final_pos: Vector2):
	movement.perform_backward_movement(final_pos)
	action_controller.perform_damaged_action()


func apply_draw_knockback(final_pos: Vector2):
	movement.perform_backward_movement(final_pos)
#endregion


func reset_position():
	self.position = _initial_position


func reset_visual():
	sprite.change_to_default_sprite()
