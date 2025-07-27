class_name CEBar extends ResourceBar

func apply_ce_loss(loss: int) -> void:
	self.change_value(self.value - loss)

func apply_ce_gain(gain: int) -> void:
	self.change_value(self.value + gain)
