extends Node2D

func _ready() -> void:
	# signals
	TurnManager.turn_changed.connect(_on_turn_changed)

func _on_turn_changed(turn: TurnManager.TurnState):
	if turn == TurnManager.TurnState.ENEMY_TURN:
		await get_tree().create_timer(1.0).timeout
		print("Mr. C slaps Troy")
		TurnManager.change_turn()
