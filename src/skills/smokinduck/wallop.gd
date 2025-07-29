class_name Wallop extends Skill

func use(user: Actor, target: Actor) -> void:
	target.damage(20, true)
	super(user, target)
