class_name Character extends Node

var max_hp: int
var curr_hp: int
var max_ce: int
var curr_ce: int
var speed: int
var base_av: float
var current_av: float
var skills: Dictionary[int, Skill]

func _init(max_hp: int, max_ce: int, speed: int) -> void:
	self.speed = speed
	self.max_hp = max_hp
	self.curr_hp = max_hp
	self.max_ce = max_ce
	self.curr_ce = max_ce
	self.base_av = TurnManager.calculate_base_av(speed)
	self.current_av = base_av
