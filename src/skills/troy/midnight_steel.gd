class_name MidnightSteel extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(12 + 16 * 3, true)
	user.use_ce(20)
	super(user, target)
