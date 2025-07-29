extends Node

const PLAYERS_PATH: String = "res://data/players.json"
const SKILLS_PATH: String = "res://data/skills.json"
const ENEMIES_PATH: String = "res://data/enemies.json"

var _json: JSON = JSON.new()

var _player_information: Dictionary
var _enemy_information: Dictionary
var _skill_information: Dictionary

func _ready() -> void:
	var players = FileAccess.open(PLAYERS_PATH, FileAccess.READ)
	var res
	if players.is_open():
		res = _json.parse(players.get_as_text())
		if res == OK:
			_player_information = _json.data 
		players.close()
	
	var skills = FileAccess.open(SKILLS_PATH, FileAccess.READ)
	if skills.is_open():
		res = _json.parse(skills.get_as_text())
		if res == OK:
			_skill_information = _json.data
		skills.close()
	
	var enemies = FileAccess.open(ENEMIES_PATH, FileAccess.READ)
	if enemies.is_open():
		res = _json.parse(enemies.get_as_text())
		if res == OK:
			_enemy_information = _json.data
		enemies.close()

func get_skill_info(id: String) -> Dictionary:
	return _skill_information[id]

func get_player_info(id: String) -> Dictionary:
	return _player_information[id]

func get_enemy_info(id: String) -> Dictionary:
	return _enemy_information[id]
