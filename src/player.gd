class_name Player extends Actor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hardcoding troy values for now
	self.setup(100, 100, 201)
	$ResourceController.setup(self.max_hp, 100)
