extends Node

enum TurnState {
	PLAYER,
	ENEMY
}

signal turn_state_changed(new_state)
signal actor_changed(new_actor)
signal av_changed

const AV_CONSTANT: float = 10000.0

var turn_state: TurnState
var current_actor: Actor
var players: Array[Player]
var enemies: Array[Enemy]

func setup(players: Array[Player], enemies: Array[Enemy]):
	self.players = players
	self.enemies = enemies

func calculate_base_av(spd: int) -> float:
	return AV_CONSTANT / spd

func _get_next_actor() -> Actor:
	# grab lowest av of all actors (change this later, it sucks)
	var lowest_av = 9999
	var next_actor: Actor
	for p in players:
		if p.current_av < lowest_av:
			lowest_av = p.current_av
			next_actor = p
	for e in enemies:
		if e.current_av < lowest_av:
			lowest_av = e.current_av
			next_actor = e
	
	return next_actor

func next_turn() -> void:
	var next_actor = _get_next_actor()
	var next_actor_av = next_actor.current_av
	
	# update avs of all actors
	players.map(func(p): p.current_av -= next_actor_av)
	enemies.map(func(e): e.current_av -= next_actor_av)
	av_changed.emit()
	
	# update turn state
	if next_actor is Player:
		turn_state = TurnState.PLAYER
	elif next_actor is Enemy:
		turn_state = TurnState.ENEMY
	turn_state_changed.emit(turn_state)
	
	current_actor = next_actor
	actor_changed.emit(current_actor)

func end_turn() -> void:
	current_actor.current_av = current_actor.base_av
	next_turn()

#func set_player_turn():
	#print("player turn start")
	#current_turn = TurnState.PLAYER_TURN
	#turn_changed.emit(current_turn)
#
#func set_enemy_turn():
	#print("enemy turn start")
	#current_turn = TurnState.ENEMY_TURN
	#turn_changed.emit(current_turn)
#
#func change_turn():
	#if current_turn == TurnState.PLAYER_TURN:
		#set_enemy_turn()
	#else:
		#set_player_turn()
