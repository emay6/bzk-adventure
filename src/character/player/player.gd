class_name Player extends Actor

func _ready() -> void:
	# hardcoding troy for now
	self.setup(Troy.new())
	$ResourceController.setup(character.max_hp, character.max_ce)
