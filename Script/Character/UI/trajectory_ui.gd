class_name TrajectoryUI
extends Line2D

var dice_slot: DiceSlotData
var start_point: Vector2
var end_point: Vector2
var trajectory_segments: int = 100
var arc_height: float = -150.0
var follow_mouse_trajectory: bool = false
var line: Line2D = self


func _process(_delta: float) -> void:
	if follow_mouse_trajectory == true:
		_draw_trajectory_to_mouse()


func set_trajectory_to_mouse(condition: bool):
	follow_mouse_trajectory = condition


func _show_canvas():
	self.visible = true


func _hide_canvas():
	self.visible = false


func clear_trajectory():
	line.clear_points()

func draw_trajectory(target_pos: Vector2):
	start_point = self.position
	end_point = to_local(target_pos)
	clear_trajectory()
	
	for i in range(trajectory_segments + 1):
		var t := i / float(trajectory_segments) 
		var pos : Vector2 = lerp(start_point, end_point, t) 
		var arc_offset: = get_parabolic_offset(t)
		pos.y += arc_offset
		line.add_point(pos)


func _draw_trajectory_to_mouse():
	clear_trajectory()
	
	var a = position
	for i in range(trajectory_segments + 1):
		var b = _get_mouse_position()
		var t := i / float(trajectory_segments) 
		var pos : Vector2 = lerp(a, b, t) 
		pos.y += arc_height * 4 * t * (1 - t)
		line.add_point(pos)


func get_parabolic_offset(segment: float) -> float:
	var height = arc_height * 4 * segment * (1 - segment)
	return height


func _setup_trajectory_coordinate():
	end_point = _get_target_position()


func _get_target_position() -> Vector2:
	var target: CharacterController = dice_slot.target_dice_slot.owner_character
	var target_position: Vector2 = to_local(target.global_position)
	return target_position


func _get_mouse_position() -> Vector2:
	var global_pos = get_viewport().get_camera_2d().get_global_mouse_position()
	var local_position = to_local(global_pos)
	return local_position
