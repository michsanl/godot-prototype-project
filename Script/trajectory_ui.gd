extends Line2D
class_name Trajectory_UI

var start_point: Vector2
var end_point: Vector2
var number_of_points: int = 100
var height: float = -150.0
var line:= self

#func _process(delta: float) -> void:
	#draw_parabola_to_mouse(height, number_of_points)

func draw_parabola(a: Vector2, b: Vector2, arc_height: float, segments: int):
	line.clear_points()

	for i in range(segments + 1):
		var t := i / float(segments)  # 0.0 to 1.0
		var pos : Vector2 = lerp(a, b, t)  # linear interpolation
		var arc_offset := arc_height * 4 * t * (1 - t)  # parabolic offset
		pos.y += arc_offset
		line.add_point(pos)

func draw_parabola_to_mouse(arc_height: float, segments: int):
	line.clear_points()
	var a = get_parent().position

	for i in range(segments + 1):
		var b = get_mouse_position()
		var t := i / float(segments)  # 0.0 to 1.0
		var pos : Vector2 = lerp(a, b, t)  # linear interpolation
		var arc_offset := arc_height * 4 * t * (1 - t)  # parabolic offset
		pos.y += arc_offset
		line.add_point(pos)

func get_mouse_position():
	return get_viewport().get_camera_2d().get_local_mouse_position()
