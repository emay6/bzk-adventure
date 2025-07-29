class_name Actor extends Node2D

var character: Character
var hp_bar: HPBar
var ce_bar: CEBar

func setup(character: Character) -> void:
	self.character = character
	self.hp_bar = find_child("HPBar", true)
	self.ce_bar = find_child("CEBar", true)
	
func damage(amt: int, flash: bool):
	if amt > character.curr_hp:
		amt = character.curr_hp
	elif amt < 0:
		amt = 0
	
	self.character.curr_hp -= amt
	self.hp_bar.apply_damage(amt)
	if flash: self.flash_sprite()

func use_ce(amt: int):
	if amt > character.curr_ce:
		amt = character.curr_ce
	elif amt < 0:
		amt = 0
	
	self.character.curr_ce -= amt
	self.ce_bar.apply_ce_loss(amt)

func flash_sprite():
	for i in range(2):
		$Sprite2D.visible = false
		await get_tree().create_timer(0.05).timeout
		$Sprite2D.visible = true
		await get_tree().create_timer(0.05).timeout
