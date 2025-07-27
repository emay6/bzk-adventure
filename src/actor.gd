class_name Actor extends Node2D

var max_hp: int
var curr_hp: int
var max_ce: int
var curr_ce: int
var speed: int
var base_av: float
var current_av: float
var hp_bar: HPBar
var ce_bar: CEBar

func setup(max_hp: int, max_ce: int, speed: int) -> void:
	self.speed = speed
	self.max_hp = max_hp
	self.curr_hp = max_hp
	self.max_ce = max_ce
	self.curr_ce = max_ce
	self.base_av = TurnManager.calculate_base_av(speed)
	self.current_av = base_av
	
	self.hp_bar = find_child("HPBar", true)
	self.ce_bar = find_child("CEBar", true)
	
func damage(amt: int):
	if amt > curr_hp:
		amt = curr_hp
	elif amt < 0:
		amt = 0
	
	self.curr_hp -= amt
	self.hp_bar.apply_damage(amt)

func use_ce(amt: int):
	if amt > curr_ce:
		amt = curr_ce
	elif amt < 0:
		amt = 0
	
	self.curr_ce -= amt
	self.ce_bar.apply_ce_loss(amt)
