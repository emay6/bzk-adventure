extends CanvasLayer

var skill_buttons: Array[Node]

# temporary av testing functions
func link_av() -> void:
	# hard code actors for test
	$Control/ActionBar/Player1/ActionValue.setup(TurnManager.players[0])
	$Control/ActionBar/Enemy1/ActionValue.setup(TurnManager.enemies[0])

func _ready() -> void:
	# setup buttons for skills
	skill_buttons = find_children("Skill?Button", "BaseButton", true)
	for sb in skill_buttons:
		sb.pressed.connect(_use_skill.bind(sb.get_meta("skill_id")))
	
	# signals
	TurnManager.turn_state_changed.connect(_on_turn_state_changed)
	TurnManager.skill_used.connect(_show_skill_name)

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

func _show_skill_name(name: String):
	$Control/SkillLabel.text = name
	$Control/SkillLabel.visible = true
	await get_tree().create_timer(1).timeout  # Show for 1 second
	$Control/SkillLabel.visible = false
	
func _use_skill(skill_num: int) -> void:
	var player = TurnManager.players[0]
	var enemy = TurnManager.enemies[0]
	player.character.skills[skill_num].use(player, enemy)
	TurnManager.end_turn()
