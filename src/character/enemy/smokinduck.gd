class_name SmokinDuck extends BaseEnemy

func _init() -> void:
	var char_info = GameManager.get_enemy_info("smokinduck")
	super(char_info.max_hp, char_info.speed)
	self.skills[1] = Wallop.new()

func act() -> void:
	var target = self._get_player()
	var user = TurnManager.enemies[0] # change this later
	if turn_count % 2 == 0:
		self.skills[1].use(user, target)
		print("Smokin' Duck puffs his cigar")
	else:
		print("Smokin Duck stands tuffly")
