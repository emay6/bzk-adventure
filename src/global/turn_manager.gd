extends Node

enum TurnState {
	PLAYER,
	ENEMY
}

signal turn_state_changed(new_state: TurnState)
signal actor_changed(new_actor: Actor)
signal av_changed
signal skill_used(skill_name: String)

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
		if p.character.current_av < lowest_av:
			lowest_av = p.character.current_av 
			next_actor = p
	for e in enemies:
		if e.character.current_av < lowest_av:
			lowest_av = e.character.current_av
			next_actor = e
	
	return next_actor

func next_turn() -> void:
	var next_actor = _get_next_actor()
	var next_actor_av = next_actor.character.current_av
	
	# update avs of all actors
	players.map(func(p): p.character.current_av -= next_actor_av)
	enemies.map(func(e): e.character.current_av -= next_actor_av)
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
	current_actor.character.current_av = current_actor.character.base_av
	next_turn()

# hard coded for 1v1s for now
func get_target(is_player: bool) -> Actor:
	return self.players[0] if is_player else self.enemies[0]
