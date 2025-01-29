# WorldMap.gd
extends Control

@onready var adventure_test : AdventureTest = $"../../Node2D/AdventureTest"
@onready var world_label : RichTextLabel = $RichTextLabel

var world_map : String

func _ready() -> void:
	# Ensure previous connections are removed before making a new one
	if world_label:
		adventure_test.connect("area_loaded", Callable(self, "_on_area_loaded"))
		load_world_map()
	#else:
		#print("Failed to load world_label node") # DEBUG

func load_world_map():
	if len(adventure_test.world_map) > 0:
		#print("WorldMap.gd, world_map loaded") # DEBUG
		world_label.text += adventure_test.world_map
	#else:
		#print("Invalid world_map data") # DEBUG

func _on_area_loaded():
	world_label.text = ""
	load_world_map()
