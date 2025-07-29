class_name Troy extends Character

var medal_count: int

func _init() -> void:
	var char_info = GameManager.get_player_info("troy")
	super(char_info.max_hp, char_info.max_ce, char_info.speed)
	self.skills[1] = MedalFist.new()
	self.skills[2] = BronzeArmor.new()
	self.skills[3] = SilverLining.new()
	self.skills[4] = GoldRush.new()
	self.skills[5] = MidnightSteel.new()
