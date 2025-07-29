class_name SilverLining extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(12, true)
	user.use_ce(7)
	super(user, target)
