
extends Node2D

const STATE_OPEN = 0
const STATE_BUMPED = 1
const STATE_CLOSED = 2
export var coin_value = 200
export var coins = 1


var player_class = preload("res://scenes/player/player.gd")


var state = STATE_OPEN

func _integrate_forces(s):
	var lv = s.get_linear_velocity()

	if (state == STATE_OPEN):
		
		var wall_side = 0.0
		for i in range(s.get_contact_count()):
			var cc = s.get_contact_collider_object(i)
			var lcs = get_shape(s.get_contact_local_shape(i)).get_instance_ID()
			var dp = s.get_contact_local_normal(i)
			
			if (cc extends player_class):
				get_node("bounce").play("bump")
				coins -= 1
				if coins <= 0:
					if get_node("block").get_frame() < 4:
						get_node("block").set_frame(3)
					state = STATE_CLOSED
				break

func _ready():
	if coins == 1:
		get_node("block").set_frame(0)
		get_node("single").play("single")
	else:
		get_node("block").set_frame(4)
		


