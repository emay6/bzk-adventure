extends Node2D

var hp_bar: HPBar
var ce_bar: CEBar

func _ready() -> void:
	hp_bar = $VBoxContainer/HPBar
	ce_bar = $VBoxContainer/CEBar

func setup(max_hp: int, max_ce: int) -> void:
	hp_bar.change_max_value(max_hp)
	hp_bar.change_value(max_hp)
	ce_bar.change_max_value(max_ce)
	ce_bar.change_value(max_ce)
	
