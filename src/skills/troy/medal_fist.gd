class_name MedalFist extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(5, true)
	super(user, target)
