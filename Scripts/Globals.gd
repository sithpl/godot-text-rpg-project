#Globals.gd
extends Node

# Capitalize all letters in a string
static func capitalize_all(text: String) -> String:
	return text.to_upper()

# Capitalize the first letter of each word in a string
static func capitalize_words(text: String) -> String:
	var words = text.split(" ")
	var capitalized_text = ""
	for word in words:
		capitalized_text += word.capitalize() + " "
	return capitalized_text.strip_edges()  # Remove trailing space
