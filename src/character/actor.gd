class_name Actor extends Node2D

var character: Character
var hp_bar: HPBar
var ce_bar: CEBar
var animation_timer: Timer
var current_frame: int = 0
var total_frames: int = 4

func setup(character: Character) -> void:
	self.character = character
	self.hp_bar = find_child("HPBar", true)
	self.ce_bar = find_child("CEBar", true)
	
	# Setup animation timer
	animation_timer = Timer.new()
	animation_timer.wait_time = 0.2  # 5 FPS
	animation_timer.timeout.connect(_on_animation_timer_timeout)
	add_child(animation_timer)
	animation_timer.start()
	
	# Connect to character's sprite update signal if it exists
	if character.has_signal("sprite_changed"):
		character.sprite_changed.connect(_update_sprite)
		character.sprite_changed.connect(_update_ui)
		# Set initial sprite
		_update_sprite()
	
func damage(amt: int, flash: bool):
	if amt > character.curr_hp:
		amt = character.curr_hp
	elif amt < 0:
		amt = 0
	
	self.character.curr_hp -= amt
	self.hp_bar.apply_damage(amt)
	
	# Spawn floating damage text
	spawn_floating_damage(amt)
	
	if flash: self.flash_sprite()

func spawn_floating_damage(damage: int) -> void:
	# Create floating damage text instance
	var damage_text = preload("res://scenes/combat/floating_damage_text.tscn").instantiate()
	get_tree().current_scene.add_child(damage_text)
	
	# Setup the damage text with the damage amount and sprite position
	damage_text.setup(damage, global_position)

func use_ce(amt: int):
	if amt > character.curr_ce:
		amt = character.curr_ce
	elif amt < 0:
		amt = 0
	
	self.character.curr_ce -= amt
	self.ce_bar.apply_ce_loss(amt)

func flash_sprite():
	var sprite = get_node_or_null("AnimatedSprite2D")
	if not sprite:
		sprite = get_node_or_null("Sprite2D")
	
	if sprite:
		for i in range(2):
			sprite.visible = false
			await get_tree().create_timer(0.05).timeout
			sprite.visible = true
			await get_tree().create_timer(0.05).timeout

func _on_animation_timer_timeout() -> void:
	var sprite = get_node_or_null("Sprite2D")
	if sprite and sprite.texture:
		current_frame = (current_frame + 1) % total_frames
		sprite.frame = current_frame

func _update_sprite() -> void:
	var animated_sprite = get_node_or_null("AnimatedSprite2D")
	var sprite = get_node_or_null("Sprite2D")
	
	if animated_sprite:
		if character.has_method("get_animation_data"):
			var anim_data = character.get_animation_data()
			var sprite_texture = load(anim_data.texture_path)
			if sprite_texture:
				# Create new sprite frames
				var sprite_frames = SpriteFrames.new()
				sprite_frames.add_animation("idle")
				sprite_frames.set_animation_speed("idle", anim_data.animation_speed)
				sprite_frames.set_animation_loop("idle", true)
				
				# Add frames from the sprite sheet
				var hframes = anim_data.get("hframes", 1)
				for i in range(hframes):
					var frame_rect = Rect2(i * sprite_texture.get_width() / hframes, 0, 
										 sprite_texture.get_width() / hframes, sprite_texture.get_height())
					var frame_texture = AtlasTexture.new()
					frame_texture.atlas = sprite_texture
					frame_texture.region = frame_rect
					sprite_frames.add_frame("idle", frame_texture, 1.0)
				
				animated_sprite.sprite_frames = sprite_frames
				animated_sprite.play("idle")
			else:
				print("Warning: Could not load sprite at path: ", anim_data.texture_path)
		elif character.has_method("get_sprite_path"):
			# Fallback to old system
			var sprite_path = character.get_sprite_path()
			var sprite_texture = load(sprite_path)
			if sprite_texture:
				var sprite_frames = animated_sprite.sprite_frames
				if sprite_frames:
					sprite_frames.set_animation_frame("idle", 0, sprite_texture)
			else:
				print("Warning: Could not load sprite at path: ", sprite_path)
	elif sprite:
		# Handle Sprite2D animation
		if character.has_method("get_animation_data"):
			var anim_data = character.get_animation_data()
			var sprite_texture = load(anim_data.texture_path)
			if sprite_texture:
				sprite.texture = sprite_texture
				total_frames = anim_data.get("hframes", 4)
				animation_timer.wait_time = 1.0 / anim_data.get("animation_speed", 5.0)
				current_frame = 0
				sprite.frame = current_frame
			else:
				print("Warning: Could not load sprite at path: ", anim_data.texture_path)
		elif character.has_method("get_sprite_path"):
			# Fallback to old system
			var sprite_path = character.get_sprite_path()
			var sprite_texture = load(sprite_path)
			if sprite_texture:
				sprite.texture = sprite_texture
				current_frame = 0
				sprite.frame = current_frame
			else:
				print("Warning: Could not load sprite at path: ", sprite_path)

func _update_ui() -> void:
	# Update skill availability when character state changes
	var combat_ui = get_tree().get_first_node_in_group("combat_ui")
	if combat_ui and combat_ui.has_method("update_skill_availability"):
		combat_ui.update_skill_availability()
