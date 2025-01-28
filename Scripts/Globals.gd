#Globals.gd
extends Node

# ---------- Assets ----------
@onready var start_map = "res://Assets/TXTs/Maps/start.txt"
@onready var world_map = "res://Assets/TXTs/Maps/world.txt"

# Utility function to capitalize all letters in a string
static func capitalize_all(text: String) -> String:
	return text.to_upper()

# Utility function to capitalize the first letter of each word
static func capitalize_words(text: String) -> String:
	var words = text.split(" ")
	var capitalized_text = ""
	for word in words:
		capitalized_text += word.capitalize() + " "
	return capitalized_text.strip_edges()  # Remove trailing space
