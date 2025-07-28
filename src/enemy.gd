class_name Enemy extends Actor

func _ready() -> void:
	# disable ce bar for enemies
	$ResourceController/VBoxContainer/CEBar.visible = false
	self.setup(300, 0, 100)
	$ResourceController.setup(self.max_hp, 0)
	
	# signals
	TurnManager.turn_state_changed.connect(_on_turn_state_changed)

func _on_turn_state_changed(turn: TurnManager.TurnState):
	if turn == TurnManager.TurnState.ENEMY:
		await get_tree().create_timer(1.0).timeout
		print("Smokin' Duck takes a puff from his cigar")
		TurnManager.players[0].damage(20)
		TurnManager.players[0].flash_sprite()
		TurnManager.end_turn()
