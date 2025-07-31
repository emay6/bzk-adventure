class_name Enemy extends Actor

func _ready() -> void:
	# disable ce bar for enemies
	$ResourceController/VBoxContainer/CEBar.visible = false
	
	self.setup(Beady.new())
	$ResourceController.setup(character.max_hp, character.max_ce)
	
	# signals
	TurnManager.turn_state_changed.connect(_on_turn_state_changed)

func _on_turn_state_changed(turn: TurnManager.TurnState):
	if turn == TurnManager.TurnState.ENEMY:
		await get_tree().create_timer(1.0).timeout
		self.character.act()
		TurnManager.skill_used.emit()
		TurnManager.end_turn()
