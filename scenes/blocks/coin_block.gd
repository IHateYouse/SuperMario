
extends RigidBody2D

const STATE_OPEN = 0
const STATE_BUMPED = 1
const STATE_CLOSED = 2
export var coin_value = 200
export var coins = 1

var bump_cooldown = 0

var player_class = preload("res://scenes/player_mario/player_mario.gd")

var state = null

func _integrate_forces(s):
	if state == STATE_OPEN:
		for i in range(s.get_contact_count()):
			var cc = s.get_contact_collider_object(i)
			if cc extends player_class:
				state = STATE_BUMPED
				get_node("bounce").play("bump")
				coins -= 1
				bump_cooldown = 0.25
				if coins <= 0:
				#	if get_node("block").get_frame() < 4:
					get_node("single").stop_all()
					get_node("block").set_frame(3)
					state = STATE_CLOSED
				break

func _process(delta):
	if state == STATE_BUMPED and bump_cooldown >= 0:
		bump_cooldown -= delta
		if bump_cooldown <= 0:
			bump_cooldown = 0
			state = STATE_OPEN

func _ready():
	set_process(true)
	state = STATE_OPEN
	if coins == 1:
		get_node("block").set_frame(0)
		get_node("single").play("single")
	else:
		get_node("block").set_frame(4)
		


