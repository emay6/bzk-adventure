class_name FloatingDamageText extends Node2D

@onready var label: Label = $Label

var velocity: Vector2 = Vector2.ZERO
var fade_timer: float = 0.0
var fade_duration: float = 1.0
var initial_alpha: float = 1.0

func _ready() -> void:
	# Set up the label
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Create and apply label settings for styling
	var label_settings = LabelSettings.new()
	label_settings.font_size = 48
	label.label_settings = label_settings

func setup(damage: int, position: Vector2) -> void:
	# Set the damage text
	label.text = str(damage)
	
	# Position the text randomly around the sprite
	var random_offset = Vector2(
		randf_range(100, 140),  # 100px right with some randomness
		randf_range(-230, -210)  # 100px up with some randomness
	)
	global_position = position + random_offset
	
	# Set initial velocity (float down)
	velocity = Vector2(randf_range(-10, 10), -30)
	
	# Set initial alpha
	modulate.a = initial_alpha

func _process(delta: float) -> void:
	# Move the text
	position += velocity * delta
	
	# Apply gravity (slow down upward movement)
	velocity.y += 50 * delta
	
	# Update fade timer
	fade_timer += delta
	
	# Fade out over time
	var fade_progress = fade_timer / fade_duration
	modulate.a = initial_alpha * (1.0 - fade_progress)
	
	# Remove when fully faded
	if fade_timer >= fade_duration:
		queue_free() 
