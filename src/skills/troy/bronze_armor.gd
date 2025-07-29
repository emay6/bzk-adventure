class_name BronzeArmor extends TroySkill

func use(user: Actor, target: Actor) -> void:
	user.use_ce(5)
	super(user, target)
