class_name Fire extends Skill

func use(user: Actor, target: Actor) -> void:
	target.damage(15, true)
	super(user, target)
