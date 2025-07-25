extends CanvasLayer

var skill_buttons

func _ready() -> void:
	skill_buttons = $Control/SkillButtonContainer.get_children()
	for i in range(skill_buttons.size()):
		skill_buttons[i].text = GameManager.player_skills[i].name
	
	# signals
	TurnManager.turn_changed.connect(_on_turn_changed)

func enable_skills() -> void:
	for button in skill_buttons:
		button.disabled = false

func disable_skills() -> void:
	for button in skill_buttons:
		button.disabled = true

func _on_turn_changed(turn: TurnManager.TurnState):
	if (turn == TurnManager.TurnState.PLAYER_TURN):
		enable_skills()
	else:
		disable_skills()

func resolve_turn():
	TurnManager.change_turn()
	await get_tree().create_timer(1.0).timeout # simulate animation time

func _on_skill_1_button_pressed() -> void:
	print("Troy skill 1")
	resolve_turn()

func _on_skill_2_button_pressed() -> void:
	print("Troy skill 2")
	resolve_turn()

func _on_skill_3_button_pressed() -> void:
	print("Troy skill 3")
	resolve_turn()

func _on_skill_4_button_pressed() -> void:
	print("Troy skill 4")
	resolve_turn()

func _on_skill_5_button_pressed() -> void:
	print("Troy skill 5")
	resolve_turn()
