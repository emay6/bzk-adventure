class_name TroySkill extends Skill

var medal_cost: int
var medal_req: int

func _init() -> void:
	super()
	self.medal_cost = _skill_info.medal_cost
	self.medal_req = _skill_info.medal_req

func can_use(user: Actor, target: Actor) -> bool:
	# Check if user has enough medals for both cost and requirement
	if user.character.get_medal_count() < medal_req:
		return false
	if user.character.get_medal_count() < medal_cost:
		return false
	# Check if user has enough CE
	if user.character.curr_ce < ce_cost:
		return false
	return true

func use(user: Actor, target: Actor) -> void:
	# Spend CE if there's a cost
	if ce_cost > 0:
		user.use_ce(ce_cost)
	
	# Spend medals if there's a cost
	if medal_cost > 0:
		user.character.spend_medals(medal_cost)
	
	super(user, target)
