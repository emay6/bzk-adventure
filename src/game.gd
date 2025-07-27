extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# link combat ui visibility to parent
	visibility_changed.connect(_on_visibility_changed)
	
	# initialize turn manager
	# hard code players/enemies for now
	var players: Array[Player] = [$Player]
	var enemies: Array[Enemy] = [$Enemy]
	TurnManager.setup(players, enemies)
	$CombatUI.link_av()
	
	# start turn
	TurnManager.next_turn()

func _on_visibility_changed() -> void:
	if has_node("CombatUI"):
		$CombatUI.visible = visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
