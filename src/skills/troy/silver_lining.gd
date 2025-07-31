class_name SilverLining extends TroySkill

func use(user: Actor, target: Actor) -> void:
	target.damage(12, true)
	super(user, target)
