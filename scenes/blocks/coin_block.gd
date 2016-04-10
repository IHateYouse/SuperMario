
extends RigidBody2D

const STATE_OPEN = 0
const STATE_BUMPED = 1
const STATE_CLOSED = 2
export var coin_value = 200
export var coins = 1

var player_class = preload("res://scenes/player_mario/player_mario.gd")

var state = null

func _process(delta):
	if (state == STATE_OPEN):
		for body in self.get_colliding_bodies():
			if body extends player_class:
				get_node("bounce").play("bump")
			coins -= 1
			if coins <= 0:
				if get_node("block").get_frame() < 4:
					get_node("single").stop_all()
					get_node("block").set_frame(3)
				state = STATE_CLOSED
			break

func _ready():
	set_process(true)
	state = STATE_OPEN
	if coins == 1:
		get_node("block").set_frame(0)
		get_node("single").play("single")
	else:
		get_node("block").set_frame(4)
		


