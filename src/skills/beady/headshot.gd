class_name Headshot extends Skill

func use(user: Actor, target: Actor) -> void:
	target.damage(30, true)
	super(user, target)
