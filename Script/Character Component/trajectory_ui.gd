class_name TrajectoryUI
extends Line2D

@export var character_targeting: CharacterTargeting

var start_point: Vector2
var end_point: Vector2
var trajectory_segments: int = 100
var arc_height: float = -150.0
var follow_mouse_trajectory: bool = false
var line: Line2D = self

func _process(delta: float) -> void:
	if follow_mouse_trajectory == true:
		_draw_trajectory_to_mouse()


func _on_character_targeting_target_changed() -> void:
	_setup_trajectory_coordinate()
	_draw_trajectory()


func _on_character_targeting_target_removed() -> void:
	line.clear_points()


func _draw_trajectory():
	for i in range(trajectory_segments + 1):
		var t := i / float(trajectory_segments) 
		var pos : Vector2 = lerp(start_point, end_point, t) 
		var arc_offset := arc_height * 4 * t * (1 - t)  # parabolic offset
		pos.y += arc_offset
		line.add_point(pos)


func _draw_trajectory_to_mouse():
	line.clear_points()
	var a = get_parent().position
	for i in range(trajectory_segments + 1):
		var b = _get_mouse_position()
		var t := i / float(trajectory_segments) 
		var pos : Vector2 = lerp(a, b, t) 
		pos.y += arc_height * 4 * t * (1 - t)
		line.add_point(pos)


func _setup_trajectory_coordinate():
	start_point = self.position
	end_point = _get_target_position()


func _get_target_position():
	var target: Character_Base = character_targeting.current_target
	var target_position: Vector2 = to_local(target.global_position)
	return target_position


func _get_mouse_position():
	var global_position = get_viewport().get_camera_2d().get_global_mouse_position()
	var local_position = to_local(global_position)
	return local_position
