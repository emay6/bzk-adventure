class_name ActionValue extends Label

var actor: Actor

func setup(actor: Actor) -> void:
	self.actor = actor
	TurnManager.av_changed.connect(_update_av)

func _update_av() -> void:
	self.text = str(roundi(actor.character.current_av))
