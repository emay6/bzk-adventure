extends Node

const CHARACTERS_PATH: String = "res://data/characters.json"
const CHARACTERS_SKILLS_PATH: String = "res://data/character_skills.json"

var _json: JSON = JSON.new()
var player: Dictionary
var player_skills: Array

func _ready() -> void:
	# grab character info
	var characters = FileAccess.open(CHARACTERS_PATH, FileAccess.READ)
	var res
	if characters.is_open():
		res = _json.parse(characters.get_as_text())
		if res == OK:
			player = _json.data["0"] # hard coding troy for now
	
	# grab character skill info
	var character_skills = FileAccess.open(CHARACTERS_SKILLS_PATH, FileAccess.READ)
	if character_skills.is_open():
		res = _json.parse(character_skills.get_as_text())
		if res == OK:
			player_skills = _json.data["0"]
