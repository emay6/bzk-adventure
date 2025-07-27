class_name HPBar extends ResourceBar

func apply_damage(dmg: int) -> void:
	self.change_value(self.value - dmg)

func apply_heal(heal: int) -> void:
	self.change_value(self.value + heal)
