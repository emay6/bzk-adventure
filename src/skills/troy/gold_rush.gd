class_name GoldRush extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(16 * 3, true)
	super(user, target)
