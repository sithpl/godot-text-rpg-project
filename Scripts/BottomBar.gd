#BottomBar.gd
extends Control

# ---------- Scene References ----------

# ---------- Node References ----------
@onready var menu_button = get_node("Panel/HBoxContainer/MenuButton")
@onready var stats_button = get_node("Panel/HBoxContainer/StatsButton")
@onready var equip_button = get_node("Panel/HBoxContainer/EquipmentButton")
@onready var main_button = get_node("Panel/HBoxContainer/MainButton")
@onready var comm_button = get_node("Panel/HBoxContainer/CommButton")
@onready var lmap_button = get_node("Panel/HBoxContainer/LocalMapButton")
@onready var wmap_button = get_node("Panel/HBoxContainer/WorldMapButton")

# ---------- Scene Load ----------

func _ready():
	# Debug prints to check node references
	#print_tree()  # Print the entire node tree to inspect paths
	#print("stats_button: ", stats_button)
	#print("equip_button: ", equip_button)
	#print("main_button: ", main_button)
	#print("comm_button: ", comm_button)
	#print("lmap_button: ", lmap_button)
	#print("wmap_button: ", wmap_button)
	
	if stats_button and not stats_button.is_connected("pressed", Callable(self, "_on_stats_button_pressed")):
		stats_button.connect("pressed", Callable(self, "_on_stats_button_pressed"))
	if equip_button and not equip_button.is_connected("pressed", Callable(self, "_on_equip_button_pressed")):
		equip_button.connect("pressed", Callable(self, "_on_equip_button_pressed"))
	if main_button and not main_button.is_connected("pressed", Callable(self, "_on_main_button_pressed")):
		main_button.connect("pressed", Callable(self, "_on_main_button_pressed"))
	if comm_button and not comm_button.is_connected("pressed", Callable(self, "_on_comm_button_pressed")):
		comm_button.connect("pressed", Callable(self, "_on_comm_button_pressed"))
	if lmap_button and not lmap_button.is_connected("pressed", Callable(self, "_on_lmap_button_pressed")):
		lmap_button.connect("pressed", Callable(self, "_on_lmap_button_pressed"))
	if wmap_button and not wmap_button.is_connected("pressed", Callable(self, "_on_wmap_button_pressed")):
		wmap_button.connect("pressed", Callable(self, "_on_wmap_button_pressed"))

func _on_menu_button_pressed():
	if $"../SystemMenu".visible == false:
		$"../SystemMenu".visible = true
	else:
		$"../SystemMenu".visible = false

func _on_stats_button_pressed():
	if $"../Stats".visible == false:
		$"../Stats".visible = true
	else:
		$"../Stats".visible = false

func _on_equipment_button_pressed():
	if $"../Equipment".visible == false:
		$"../Equipment".visible = true
	else:
		$"../Equipment".visible = false

func _on_main_button_pressed():
	if $"../Main".visible == false:
		$"../Main".visible = true
	else:
		$"../Main".visible = false

func _on_comm_button_pressed():
	if $"../Communication".visible == false:
		$"../Communication".visible = true
	else:
		$"../Communication".visible = false

func _on_local_map_button_pressed():
	if $"../Local Map".visible == false:
		$"../Local Map".visible = true
	else:
		$"../Local Map".visible = false

func _on_world_map_button_pressed():
	if $"../World Map".visible == false:
		$"../World Map".visible = true
	else:
		$"../World Map".visible = false
