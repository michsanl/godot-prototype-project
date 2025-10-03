class_name CameraManager
extends Node

@export var camera: PhantomCamera2D

func update_camera_to_default():
	camera.follow_mode = PhantomCamera2D.FollowMode.NONE

func update_camera_to_group(group: Array[CharacterController]):
	camera.follow_targets.clear()
	camera.follow_targets.append_array(group)
	camera.follow_mode = PhantomCamera2D.FollowMode.GROUP
	
