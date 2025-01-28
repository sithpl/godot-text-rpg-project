#AdventureTest.gd
extends Node

class_name AdventureTest

# ---------- Signals ----------

# Signal for when an item is picked up
signal item_picked_up(item_name)
signal objective_updated(new_objective : String)
signal area_loaded

# --------- Node References ----------
@onready var text_box : RichTextLabel = $"../../Main/TextBox/RichTextLabel"
@onready var input_box : LineEdit = $"../../Main/PlayerInput/LineEdit"
@onready var comm_push : RichTextLabel = $"../../Communication/TextBox/RichTextLabel"
@onready var player_data : PlayerData = $"../PlayerData"  # Reference to PlayerData
@onready var play_box : PlayBox = $"../../Main/TextBox"

# ---------- Variables ----------

var begin_text : String
var hint : String
var current_objective : String
var completed_message : String
var objective_completed : bool = false
var current_area : String

# ---------- Scene Load ----------

var area_items: Dictionary = {}  # Initialize items dictionary
var npcs: Dictionary = {}  # Initialize NPCs dictionary
var look_desc : Dictionary = {} # Initialize look dictionary
var exits: Dictionary = {} # Initialize exits dictionary
var current_items = {}   # To store items for the current area
var world_map : String
var local_map : String

func _ready():
	connect("item_picked_up", Callable(self, "_on_item_picked_up"))
	connect("objective_updated", Callable(self, "_on_objective_updated"))
	player_data.connect("equipment_updated", Callable(self, "_on_equipment_updated"))
	player_data.connect("inventory_updated", Callable(self, "_on_inventory_updated"))
	load_area("starting_area")
	text_box.text += "[color=#09ff00]" + begin_text + "[/color]\n"

# ---------- STARTING AREA ----------

# Track area objective compleletion to freely move
var start_area_done : bool = false
func starting_area():
	# ---------- World Map Loaction ----------
	world_map = '''
		[color=09ff00]
				[ ]
				[X][/color]
	'''
	# --------- Area Load ----------
	current_area = "starting_area"
	begin_text = "[color=#09ff00][Area] Your story begins here...[/color]."
	# --------- Hints ----------
	if not start_area_done:
		hint = "Find something to help you clear a path."
	else:
		hint = "No hints available."
	# --------- Objectives ----------
	current_objective = "Small branches and tall grass block your path."
	completed_message = "You cut the overgrowth back with your rusty machete."
	objective_completed = false
	# --------- Look ----------
	look_desc = {
		"around": "Nothing much here.",
		"north": "You see a muddy, overgrown road. A [stranger] leans against a tree.",
		"east": "A [rusty machete] sticks out of a tree stump.",
		"south": "The path is blocked by dense undergrowth.",
		"west": "Thick vegetation obstructs your view.",
		"rusty machete": "It might have a few good whacks left in it."
		}
	# --------- NPCs and Dialogue ----------
	npcs = {
		"stranger": {
			"name": "Stranger",
			"action": "He raises a tired hand and points at the road leading North.",
			"dialogue": "Stranger says,[i]'Hellhole is o'er yonder, fella.'[/i]"
		}
	}
	# --------- Items in the Area ----------
	area_items = {
		"rusty machete": { "slot": "this_hand" } 
	}
	# --------- Exits ----------
	exits = {
		"north": "northroad_1" # northroad_1()
	}
	# ---------- Local Map ----------
	local_map = '''[color=09ff00]~~~~~~~~~~~~~~~~|       |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|       |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|       |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~/         ‾‾‾‾‾|~~~~~~~~~~~~~~~~
~~~~~~~~~~~~/               |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~/‾‾  S             |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|                  |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|              @   |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|                  |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|        X         |~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|                  /~~~~~~~~~~~~~~~~~~~
~~~~~~~~~|__________________/~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[/color]
	'''

# ---------- NORTHROAD1 ----------

var northroad_1_done : bool = false
func northroad_1():
	# ---------- World Map Loaction ----------
	world_map = '''
		[color=09ff00]
				[ ]
				[X]	[ ]
				[ ][/color]
	'''
	# --------- Area Load ----------
	current_area = "northroad_1"
	begin_text = "[color=#09ff00][Area] You stand in the middle of a dilapidated road.[/color]."
	# --------- Hints ----------
	hint = "No hints available."
	# --------- Objectives ----------
	current_objective = "None."
	completed_message = "None."
	objective_completed = false
	# --------- Look ----------
	look_desc = {
		"around": "The muddy road leads North and South. A [local] gives a seemingly friendly wave.",
		"north": "You see flickers of light from a nearby town ahead.",
		"east": "Pluff mud, not a good idea to step into that.",
		"south": "That's where we started.",
		"west": "[Something] is poking out of the mud.",
		"something" : "It's a piece of [sheet metal]."
		}
	# --------- NPCs and Dialogue ----------
	npcs = {
		"local": {
			"name": "Local",
			"action": "She pats the sweat from her head with a dirty rag.",
			"dialogue": "Local says, [i]I seen many fellas like you pass by. All down on their luck and tryin' to find their come up. Speak to Jessup down the road there. He'll help you out.[/i]"
		}
	}
	# --------- Items in the Area ----------
	area_items = {
		"sheet metal": { "slot": "chest" }
	}
	# --------- Exits ----------
	exits = {
		"north": "hellhole",
		"south": "starting_area",
		"east": "eastroad_1"
	}
	# ---------- Local Map ----------
	local_map = '''[color=09ff00]~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|      L |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~|        |~#~#~#~#~#~#~#~#~#~#~#~
~~~~~~~~~~~~~~~~|   X    |#~#~#~#~#~#~#~#~#~#~#~#
~~~~~~~@~~~~~~~~|        |~#~#~#~#~#~#~#~#~#~#~#~
~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~[/color]
	'''

# ---------- EASTROAD1 ----------

var eastroad_1_done : bool = false
func eastroad_1():
	# ---------- World Map Loaction ----------
	world_map = '''
		[color=09ff00]
				[ ]
				[ ]	[X]
				[ ][/color]
	'''
	# --------- Area Load ----------
	current_area = "eastroad_1"
	begin_text = "[color=#09ff00][Area] You are managing to keep yourself from sinking too much, but for how long...[/color]."
	# --------- Hints ----------
	hint = "No hints available."
	# --------- Objectives ----------
	current_objective = "None."
	completed_message = "None."
	objective_completed = false
	# --------- Look ----------
	look_desc = {
		"around": "The pluff mud makes it difficult to stand in place without sinking.",
		"north": "It's dark and scary that direction...not a good idea.",
		"east": "It's dark and scary that direction...not a good idea.",
		"south": "It's dark and scary that direction...not a good idea.",
		"west": "You see a road that leads North and South."
		}
	# --------- NPCs and Dialogue ----------
	npcs = {
	}
	# --------- Items in the Area ----------
	area_items = {
	}
	# --------- Exits ----------
	exits = {
		"west": "northroad_1"
	}
	local_map = '''[color=09ff00]~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~/               |~~~~~~~~~
~~~~~~~~~~~~~~~~~~~|                |~~~~~~~~~
~~~~~~~~~~~~~~~~~~~|           @    |~~~~~~~~
~#~#~#~#~#~#~|‾‾‾‾‾                 |~~~~~~~ 
#~#~#~#~#~#~#|              X        |~~~~~~~
~#~#~#~#~#~#~|______                  |~~~~~~~ 
~~~~~~~~~~~~~~~~~~~|                   |~~~~~~~~~
~~~~~~~~~~~~~~~~~~~|                   |~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~|                  |~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~|_________________/~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	'''

# ---------- HELLHOLE ----------

var hellhole_done : bool = false
func hellhole():
	# ---------- World Map Loaction ----------
	world_map = '''
		[color=09ff00]
				[ ]
			[ ]	[X]
				[ ]	[ ]
				[ ][/color]
	'''
	# --------- Area Load ----------
	current_area = "hellhole"
	begin_text = "[color=#09ff00][Area] You find yourself in the remnants of what once seemed to be a bustling area.[/color]"
	# --------- Hints ----------
	hint = "Speak to the locals."
	# --------- Objectives ----------
	current_objective = "None."
	completed_message = "None."
	objective_completed = false
	# --------- Look ----------
	look_desc = {
		"around": "[Something] about this place makes you feel uneasy.",
		"north": "The road leads North out of town.",
		"east": "You see a large wooden building with signs of damage on the roof. A [sign] swings by the front door",
		"south": "The road leads South out of town.",
		"west": "The road leads West to a small shack on the outskirts.",
		"sign": "LAZY LUCENNE'S",
		"something": "[Brains] You aren't sure why..."
		}
	var stats1 = player_data.get_stats1()
	if stats1["BNS"] >= 5:
		look_desc["something"] = "[Brains] Based on this location and decaying remains, you can tell this was once a thriving fishing town, now abandoned by industry and left to decay."
	# --------- NPCs and Dialogue ----------
	npcs = {
		"beggar": {
			"name": "Beggar",
			"action": "He frowns he turns to speak to you.",
			"dialogue": "Beggar says, [i]I see you as broke as I am so do both'a us a favor and git t' gittin.[/i]"
		}
	}
	# --------- Items in the Area ----------
	area_items = {
	}
	# --------- Exits ----------
	exits = {
		"south": "northroad_1",
		"north": "northroad_2",
		"west" : "westroad_1"
	}
	local_map = '''[color=09ff00]~~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~
~|‾‾‾‾‾‾‾‾‾‾|~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~
~|   S   |~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~
~|_______|~~~~|        |~~~~|‾‾‾‾‾‾‾‾‾‾‾‾‾|~~~~~
~~~~~~~~~~~~~/        |~~~~~|         |~~~~~
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾          ‾‾‾‾‾‾‾‾‾|         |~~~~~
				   X    ____|    I    |~~~~~
______________         |~~~~|         |~~~~~
~~~~~~~~~~~~~~|        |~~~~|         |~~~~~
~|‾‾‾|~~~~~~~~~|        |~~~~|_________|~~~~~
~|  |~|‾‾‾|~~~~| B      |~~~~~~~~~~~~~~~~~~~~~~~
~|__|~|  |~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~|__|~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~|        |~~~~~~~~~~~~~~~~~~~~~~~~~
	[/color]'''

# ---------- COMPLETING EACH AREA ----------

func can_move_to(next_area):
	# Starting Area Objective
	if current_area == "starting_area":
		if not start_area_done:
			var equipment = player_data.get_equipment()
			var stats1 = player_data.get_stats1()
			if equipment["this_hand"] == "Rusty Machete" or equipment["this_hand"] == "rusty machete":
				start_area_done = true
				objective_completed = true
				current_objective = completed_message
				text_box.text += "[color=#09ff00][Completed] " + completed_message + "[/color]\n"
			elif stats1["BRN"] >= 5:
				start_area_done = true
				objective_completed = true
				text_box.text += "[color=#09ff00][Brawn] You easily break or push branches and grass until you reach an opening on the other side.[/color]\n"
				print("Objective completed: " + str(objective_completed) + "\n") # DEBUG
		if start_area_done:
			load_area("northroad_1")
			return true
		else:
			text_box.text += "[color=#09ff00][Move] " + current_objective + "[/color]\n"
	# Northroad1 Objective
	if current_area == "northroad_1":
		if next_area == "eastroad_1":
			var stats1 = player_data.get_stats1()
			if stats1["QKN"] >= 5:
				if not northroad_1_done:
					northroad_1_done = true
					text_box.text += "[color=#09ff00][Quickness] You swiftly traverse the mud and arrive at a spot where it's a bit stiffer.[/color]\n"
					load_area("eastroad_1")
				if northroad_1_done:
					load_area("eastroad_1")
			else:
				text_box.text += "[color=#09ff00][Move] You take a few steps and sink quickly into the mud before leaping backwards to safety.[/color]\n"
		else:
			objective_completed
			return true
			load_area(next_area)
	# Eastroad1 Objective
	if current_area == "eastroad_1":
		if not eastroad_1_done:
			eastroad_1_done = true
			objective_completed = true
		load_area(next_area)
		return true
	# Hellhole Objective
	if current_area == "hellhole":
		if not hellhole_done:
			hellhole_done = true
			objective_completed = true
		load_area(next_area)
		return true
	## Handle other areas
	#else:
		#load_area(next_area)
		#return true
	return false

# ---------- GET DATA ----------

# Safely get item data
func get_item_data(item_name: String) -> Dictionary:
	return area_items.get(item_name, {})

# Safely get NPC data
func get_npc_data(npc_name: String) -> Dictionary:
	return npcs.get(npc_name, {})

# Safely get look data
func get_look_desc(direction: String) -> String:
	return look_desc.get(direction, "")

# Safely get exit data
func get_exits() -> Dictionary:
	return exits

# Load an area by calling the corresponding function in AdventureTest.gd
func load_area(area_name: String):
	if has_method(area_name):
		area_items.clear()  # Ensure area_items is always a valid dictionary
		npcs.clear()  # Ensure npcs is always a valid dictionary
		look_desc.clear()  # Ensure npcs is always a valid dictionary
		exits.clear()  # Ensure npcs is always a valid dictionary
		call(area_name)
		emit_signal("area_loaded")
		#print("Area loaded: " + area_name)  # DEBUG
		#print(world_map)
		#print(area_items)  # DEBUG
		#print(npcs)  # DEBUG
		#print(look_desc)  # DEBUG
		#print(exits)
	#else:
		#print("Error: '" + area_name + "' does not exist.")  # DEBUG

#func update_text_box():
	#text_box.text = "[color=#09ff00]" + begin_text + "[/color]\n"

# ---------- HANDLE SIGNALS ----------

#func pick_up_item(item_name: String) -> void:
	#emit_signal("item_picked_up", item_name)
	#print("Emitting signal for item: " + item_name)

# Handle item update signal
func _on_item_picked_up(item_name: String):
	print("Received item from AdventureTest: " + item_name)  # DEBUG

# Handle equipment update signal
func _on_equipment_updated(current_equipment: Dictionary):
	print("Equipment updated: ", current_equipment) # DEBUG
	
# Handle inventory update signal
func _on_inventory_updated(inventory: Dictionary):
	print("Inventory updated: ", inventory) # DEBUG

# Signal handler for the objective update
func _on_objective_updated(new_objective: String):
	print("Objective updated: " + new_objective) # DEBUG
