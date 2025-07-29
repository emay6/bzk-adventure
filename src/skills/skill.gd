class_name Skill extends Node

var damage: int
var heal: int
var magic: int
var ce_cost: int
var skill_name: String
var skill_description: String
var target: Actor
var user: Actor

var _skill_info

signal used_skill(skill_name: String)

func _init() -> void:
	_skill_info = GameManager.get_skill_info(self.get_class_name())
	self.skill_name = _skill_info.get("name")
	self.skill_description = _skill_info.get("description")
	self.damage = _skill_info.get("damage", 0)
	self.heal = _skill_info.get("heal", 0)
	self.magic = _skill_info.get("magic", 0)
	self.ce_cost = _skill_info.get("ce_cost", 0)
	self.target = null
	self.user = null

func use(user: Actor, target: Actor) -> void:
	TurnManager.skill_used.emit(self.skill_name)

func get_class_name() -> String:
	return self.get_script().get_global_name()
