# Helper script to create Troy sprite variations
# This script can be run in Godot to create the different medal count sprites
# You'll need to manually create the actual sprite images

extends Node

func create_troy_sprite_variations():
	print("Creating Troy sprite variations...")
	
	# Load the base Troy sprite
	var base_sprite = load("res://textures/character/troy_character_idle.png")
	if not base_sprite:
		print("Error: Could not load base Troy sprite")
		return
	
	# Create variations for 1-4 medals
	for medal_count in range(1, 5):
		var sprite_path = "res://textures/character/troy_character_" + str(medal_count) + "medal"
		if medal_count > 1:
			sprite_path += "s"
		sprite_path += ".png"
		
		print("Creating sprite for ", medal_count, " medal(s): ", sprite_path)
		# Note: You'll need to manually create these sprite files
		# They should be variations of the base sprite with medal decorations 
