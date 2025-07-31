class_name MedalFist extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(_skill_info.damage + user.character.get_medal_count() * _skill_info.magic, true)
	
	user.character.gain_medal()
	
	super(user, target)
