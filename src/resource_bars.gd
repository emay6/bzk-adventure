extends Node

var max_hp: int = 100
var current_hp: int = max_hp
var max_ce: int = 100
var current_ce: int = max_ce
@onready var hp_bar = $VBoxContainer/HealthBar
@onready var ce_bar = $VBoxContainer/CEBar

func _ready() -> void:
	change_hp(max_hp)
	change_ce(max_ce)

# health functions
func apply_damage(dmg: int) -> void:
	change_hp(current_hp - dmg)

func apply_heal(heal: int) -> void:
	change_hp(current_hp + heal)

func change_hp(new_hp: int) -> void:
	if new_hp >= max_hp:
		new_hp = max_hp
	elif new_hp <= 0:
		new_hp = 0
	
	current_hp = new_hp
	update_health_bar()

# cursed energy functions
func apply_ce_loss(dmg: int) -> void:
	change_hp(current_hp - dmg)

func apply_ce_gain(heal: int) -> void:
	change_hp(current_hp + heal)

func change_ce(new_ce: int) -> void:
	if new_ce >= max_ce:
		new_ce = max_ce
	elif new_ce <= 0:
		new_ce = 0
	
	current_ce = new_ce
	update_ce_bar()
	
	
func update_health_bar() -> void:
	hp_bar.value = current_hp
	hp_bar.max_value = max_hp

func update_ce_bar() -> void:
	ce_bar.value = current_ce
	ce_bar.max_value = max_ce
