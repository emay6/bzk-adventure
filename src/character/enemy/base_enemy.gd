class_name BaseEnemy extends Character

var turn_count: int

func _init(max_hp: int, speed: int):
	super(max_hp, 0, speed)

func act() -> void:
	pass

func _get_player() -> Player:
	return TurnManager.players[0]
