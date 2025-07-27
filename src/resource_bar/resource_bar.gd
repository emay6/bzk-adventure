class_name ResourceBar extends TextureProgressBar

func change_value(new_value: int) -> void:
	if new_value >= max_value:
		new_value = max_value
	elif new_value <= 0:
		new_value = 0
	
	self.value = new_value

func change_max_value(new_max_value: int) -> void:
	self.max_value = new_max_value
