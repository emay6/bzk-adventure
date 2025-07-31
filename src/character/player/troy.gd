class_name Troy extends Character

var medal_count: int = 0
const MAX_MEDALS: int = 4

signal sprite_changed

func _init() -> void:
	var char_info = GameManager.get_player_info("troy")
	super(char_info.max_hp, char_info.max_ce, char_info.speed)
	self.skills[1] = MedalFist.new()
	self.skills[2] = BronzeArmor.new()
	self.skills[3] = SilverLining.new()
	self.skills[4] = GoldRush.new()
	self.skills[5] = MidnightSteel.new()

func gain_medal() -> void:
	if medal_count < MAX_MEDALS:
		medal_count += 1
		print("Troy gained a medal! Medals: ", medal_count)
		sprite_changed.emit()

func spend_medals(amount: int) -> bool:
	if medal_count >= amount:
		medal_count -= amount
		print("Troy spent ", amount, " medals. Medals remaining: ", medal_count)
		sprite_changed.emit()
		return true
	return false

func get_medal_count() -> int:
	return medal_count

func get_sprite_path() -> String:
	match medal_count:
		0: return "res://textures/character/troy_character_idle.png"
		1: return "res://textures/character/troy_character_bronze_idle.png"
		2: return "res://textures/character/troy_character_silver_idle.png"
		3: return "res://textures/character/troy_character_gold_idle.png"
		4: return "res://textures/character/troy_character_midnight_idle.png"
		_: return "res://textures/character/troy_character_idle.png"

func get_animation_data() -> Dictionary:
	var sprite_path = get_sprite_path()
	return {
		"texture_path": sprite_path,
		"hframes": 4,
		"animation_speed": 5.0
	}
