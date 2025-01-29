# LocalMaps.gd
extends Control

@onready var adventure_test : AdventureTest = $"../../Node2D/AdventureTest"
@onready var local_label : RichTextLabel = $RichTextLabel

var local_map : String

func _ready() -> void:
	# Ensure previous connections are removed before making a new one
	if local_label:
		adventure_test.connect("area_loaded", Callable(self, "_on_area_loaded"))
		load_local_map()
	#else:
		#print("Failed to load world_label node") # DEBUG

func load_local_map():
	if len(adventure_test.local_map) > 0:
		#print("LocalMap.gd, local_map loaded") # DEBUG
		local_label.text += adventure_test.local_map
	#else:
		#print("Invalid world_map data") # DEBUG

func _on_area_loaded():
	local_label.text = ""
	load_local_map()
