class_name TroySkill extends Skill

var medal_cost: int
var medal_req: int

func _init() -> void:
	super()
	self.medal_cost = _skill_info.medal_cost
	self.medal_req = _skill_info.medal_req
