#Main.gd
extends Node

@onready var adventure_test = $Node2D/AdventureTest  
@onready var player_data = $Node2D/PlayerData  
@onready var equipment = $Equipment/TextBox  

func _ready():
	# Connect AdventureTest to PlayerData
	player_data.connect_to_adventure(adventure_test)

	# Initialize Equipment to listen for updates from PlayerData
	if player_data.has_signal("equipment_updated"):
		player_data.connect("equipment_updated", Callable(equipment, "_on_equipment_updated"))
	if player_data.has_signal("inventory_updated"):
		player_data.connect("inventory_updated", Callable(equipment, "_on_inventory_updated"))
