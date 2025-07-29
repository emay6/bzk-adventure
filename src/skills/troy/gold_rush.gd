class_name GoldRush extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(16 * 3, true)
	user.use_ce(10)
	super(user, target)
