extends CanvasLayer

var skill_buttons

# temporary av testing functions
func link_av() -> void:
	# hard code actors for test
	$Control/ActionBar/Player1/ActionValue.setup(TurnManager.players[0])
	$Control/ActionBar/Enemy1/ActionValue.setup(TurnManager.enemies[0])

func _ready() -> void:
	
	skill_buttons = [$Control/SkillButtonContainer/Skill1Rect/Skill1Button,
	$Control/SkillButtonContainer/Skill2Rect/Skill2Button,
	$Control/SkillButtonContainer/Skill3Rect/Skill3Button,
	$Control/SkillButtonContainer/Skill4Rect/Skill4Button,
	$Control/SkillButtonContainer/Skill5Rect/Skill5Button]
	#for i in range(skill_buttons.size()):
		#skill_buttons[i].text = GameManager.player_skills[i].name
	
	# signals
	TurnManager.turn_state_changed.connect(_on_turn_state_changed)

func enable_skills() -> void:
	for button in skill_buttons:
		button.disabled = false

func disable_skills() -> void:
	for button in skill_buttons:
		button.disabled = true

func _on_turn_state_changed(new_turn: TurnManager.TurnState):
	if (new_turn == TurnManager.TurnState.PLAYER):
		enable_skills()
	else:
		disable_skills()

func _on_skill_1_button_pressed() -> void:
	TurnManager.enemies[0].damage(5)
	TurnManager.end_turn()

func _on_skill_2_button_pressed() -> void:
	TurnManager.players[0].use_ce(5)
	TurnManager.end_turn()

func _on_skill_3_button_pressed() -> void:
	TurnManager.enemies[0].damage(12)
	TurnManager.players[0].use_ce(7)
	TurnManager.end_turn()

func _on_skill_4_button_pressed() -> void:
	TurnManager.enemies[0].damage(16 * 3)
	TurnManager.players[0].use_ce(10)
	TurnManager.end_turn()

func _on_skill_5_button_pressed() -> void:
	TurnManager.enemies[0].damage(5 + 12 + 16 * 3)
	TurnManager.players[0].use_ce(20)
	TurnManager.end_turn()
