class_name Beady extends BaseEnemy

var loaded = false
var take_aim = false

func _init() -> void:
	var char_info = GameManager.get_enemy_info("beady")
	super(char_info.max_hp, char_info.speed)
	self.skills[1] = Reload.new()
	self.skills[2] = TakeAim.new()
	self.skills[3] = Fire.new()
	self.skills[4] = Calculate.new()
	self.skills[5] = Headshot.new()

func act() -> void:
	var target = self._get_player()
	var user = TurnManager.enemies[0] # change this later
	if turn_count == 0: # reloads on first turn
		self.skills[1].use(user, target)
		print("Beady reloads")
		loaded = true
		turn_count += 1
	else:
		if loaded == true and take_aim == false: # if loaded, 50% chance to fire, 50% chance to take aim
			var roll = randf()
			if roll < 0.5:
				self.skills[2].use(user, target)
				take_aim = true
			else:
				self.skills[3].use(user, target)
				loaded = false
		elif loaded == true and take_aim == true: # if taken aim, 67% chance to headshot, 33% chance to calculate 
			var roll = randf()
			if roll < 0.67:
				self.skills[5].use(user, target)
				loaded = false
				take_aim = false
			else:
				self.skills[4].use(user, target)
		else:
			self.skills[1].use(user, target)
			print("Beady reloads")
			loaded = true
