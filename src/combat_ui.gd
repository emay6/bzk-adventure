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

func show_skill_name(name: String):
	$Control/SkillLabel.text = name
	$Control/SkillLabel.visible = true
	await get_tree().create_timer(1).timeout  # Show for 1 second
	$Control/SkillLabel.visible = false
	
func _on_skill_1_button_pressed() -> void:
	TurnManager.enemies[0].damage(5)
	TurnManager.enemies[0].flash_sprite()
	show_skill_name("Medal Fist")
	TurnManager.end_turn()

func _on_skill_2_button_pressed() -> void:
	TurnManager.players[0].use_ce(5)
	show_skill_name("Bronze Armor")
	TurnManager.end_turn()

func _on_skill_3_button_pressed() -> void:
	TurnManager.enemies[0].damage(12)
	TurnManager.players[0].use_ce(7)
	TurnManager.enemies[0].flash_sprite()
	show_skill_name("Silver Lining")
	TurnManager.end_turn()

func _on_skill_4_button_pressed() -> void:
	TurnManager.enemies[0].damage(16 * 3)
	TurnManager.players[0].use_ce(10)
	TurnManager.enemies[0].flash_sprite()
	show_skill_name("Gold Rush")
	TurnManager.end_turn()

func _on_skill_5_button_pressed() -> void:
	TurnManager.enemies[0].damage(5 + 12 + 16 * 3)
	TurnManager.players[0].use_ce(20)
	TurnManager.enemies[0].flash_sprite()
	show_skill_name("Midnight Steel")
	TurnManager.end_turn()
