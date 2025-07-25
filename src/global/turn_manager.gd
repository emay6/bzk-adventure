extends Node

enum TurnState {
	PLAYER_TURN,
	ENEMY_TURN
}

signal turn_changed(turn)

var current_turn
var player
var enemy

func set_player_turn():
	print("player turn start")
	current_turn = TurnState.PLAYER_TURN
	turn_changed.emit(current_turn)

func set_enemy_turn():
	print("enemy turn start")
	current_turn = TurnState.ENEMY_TURN
	turn_changed.emit(current_turn)

func change_turn():
	if current_turn == TurnState.PLAYER_TURN:
		set_enemy_turn()
	else:
		set_player_turn()
