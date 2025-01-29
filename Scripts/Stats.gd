#Stats.gd
extends Node

class_name Stats

# ---------- Node References ----------

@onready var stats1_label : RichTextLabel = $RichTextLabel
@onready var stats2_label : RichTextLabel = $RichTextLabel2
@onready var condition_label : RichTextLabel = $"../TextBox2/RichTextLabel"

# ---------- Variables ----------

var player_data : PlayerData  # Reference PlayerData script

func _ready():
	#if not stats1_label:
		#print("Error: stats1_label node not found!")  # DEBUG
	#else:
		#print("stats1_label node found!")  # DEBUG
	#if not stats2_label:
		#print("Error: stats2_label node not found!")  # DEBUG
	#else:
		#print("stats2_label node found!")  # DEBUG
	#if not condition_label:
		#print("Error: condition_label node not found!")  # DEBUG
	#else:
		#print("condition_label node found!")  # DEBUG
	
	# Fetch PlayerData instance
	player_data = get_node("/root/PlayerData")  # Adjust path if necessary
	if player_data:
		# Connect to the signals only once
		player_data.connect("stats1_updated", Callable(self, "_on_stats1_updated"))
		player_data.connect("stats2_updated", Callable(self, "_on_stats2_updated"))
		player_data.connect("condition_updated", Callable(self, "_on_condition_updated"))
		
		# Initialize the UI display with current data
		_on_stats1_updated(player_data.get_stats1())
		_on_stats2_updated(player_data.get_stats2())
		_on_condition_updated(player_data.get_condition())
	else:
		print("Error: PlayerData node not found!")  # DEBUG

func _on_stats1_updated(new_stats: Dictionary) -> void:
	var stats_text = ""
	for key in new_stats.keys():
		stats_text += "[color=#09ff00]" + Globals.capitalize_all(key) + ": " + str(new_stats[key]) + "[/color]\n"
	stats1_label.bbcode_text = stats_text

func _on_stats2_updated(new_stats: Dictionary) -> void:
	var stats_text = ""
	for key in new_stats.keys():
		stats_text += "[color=#09ff00]" + Globals.capitalize_all(key) + ": " + str(new_stats[key]) + "[/color]\n"
	stats2_label.bbcode_text = stats_text

func _on_condition_updated(new_status: Dictionary) -> void:
	var status_text = ""
	for key in new_status.keys():
		status_text += "[color=#09ff00]" + key.capitalize() + ": " + str(new_status[key]) + "[/color]\n"
	condition_label.bbcode_text = status_text
