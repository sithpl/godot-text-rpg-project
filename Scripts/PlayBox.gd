#PlayBox.gd
extends ScrollContainer

class_name PlayBox

# ---------- Node References ----------

@onready var text_box : RichTextLabel = $RichTextLabel
@onready var input_box : LineEdit = $"../PlayerInput/LineEdit" # Player input
@onready var comm_push : RichTextLabel = $"../../Communication/TextBox/RichTextLabel" # Dialogue pushed to Communication Window
@onready var player_data : PlayerData = $"../../Node2D/PlayerData" # PlayerData.gd Node
@onready var adventure_test : AdventureTest = $"../../Node2D/AdventureTest" # AdventureTest.gd Node

# ---------- Auto Scroll ----------

var max_scroll_length = 0 
@onready var scrollbar = get_v_scroll_bar()

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value 
		self.scroll_vertical = max_scroll_length

# ---------- Scene Load ----------

func _ready():
	# Auto Scroll
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value
	# PlayBox and LineEdit check
	if text_box == null or input_box == null:
		print("Error: Nodes not found. Check node structure!") # DEBUG
		return
	comm_push.text = ""
	# Connect to TextBox
	input_box.connect("text_submitted", Callable(self, "_on_text_submitted"))
	
	player_data.connect_to_adventure(adventure_test)

# Handle input submission
func _on_text_submitted(new_text: String):
	input_box.text = ""  # Clear input
	
	var cleaned_text = remove_common_words(new_text.to_lower())
	var commands = cleaned_text.split(" ")
	var action = commands[0]
	var target = ""
	var item_name = ""
	var look_where = ""

	# Handle commands
	if (action == "talk" or action == "take" or action == "look") and commands.size() > 1 and commands[1] == "to":
		target = concatenate_array(commands.slice(2))
		item_name = concatenate_array(commands.slice(2))
		look_where = concatenate_array(commands.slice(2))
	else:
		target = concatenate_array(commands.slice(1))
		item_name = concatenate_array(commands.slice(1))
		look_where = concatenate_array(commands.slice(1))

	match action:
		"talk":
			handle_talk(target)
		"look":
			handle_look(look_where)
		"help":
			if commands.size() > 1:
				handle_help(commands[1])
			else:
				handle_help("")
		"hint":
			handle_hint()
		"take":
			handle_take(item_name)
		"equip":
			handle_equip(item_name)
		"remove":
			handle_remove(item_name)
		"move":
			handle_move(target)
		"quit":
			get_tree().quit()
		_:
			text_box.text += "[color=#09ff00]" + "Unknown command: " + new_text + "[/color]\n"

# ---------- Parse Player Input ----------

func remove_common_words(text: String) -> String:
	var common_words = ["the", "a", "an", "at", "to"]
	for word in common_words:
		text = text.replace(" " + word + " ", " ")
	return text

func concatenate_array(array: Array) -> String:
	var result = ""
	for i in range(array.size()):
		result += array[i]
		if i < array.size() - 1:
			result += " "
	return result

# ---------- Input Actions (Talk, Look, Help, etc.) ----------

func handle_talk(npc_name: String):
	if npc_name.strip_edges() == "":
		list_npcs()
	else:
		var npc_data = adventure_test.get_npc_data(npc_name)
		if npc_data != {}:  # Check if npc_data is valid
			text_box.text += "[color=#09ff00][Talk] You speak to " + npc_data["name"] + ". " + npc_data["action"] + "[/color]\n"
			comm_push.text += "[color=#09ff00]" + npc_data["dialogue"] + "[/color]\n"
			print("Spoke to " + npc_name)  # Debug message
		else:
			text_box.text += "[color=#ff0000]There is no one by that name to talk to here.[/color]\n"
			print("NPC not found: " + npc_name)  # Debug message

func handle_look(direction):
	var look_dir = adventure_test.get_look_desc(direction)
	if len(look_dir) > 0:  # Check if look_dir is valid
		print("handle_look call: ") # DEBUG
		text_box.text += "[color=#09ff00][Look] " + look_dir + "[/color]\n"
		print("Player looked:  " + direction)  # DEBUG
	else:
		text_box.text += "[color=#ff0000][Look] Invalid direction or item. Try 'around', 'north', [item], etc.[/color]\n"
		print("Invalid direction: " + direction)  # DEBUG

func handle_help(command=""):
	# Clear the text box
	if command.length() == 0:
		text_box.text += "[color=#09ff00][Help] Available commands:[/color]"
		text_box.text += "[color=#09ff00] talk, look, move, take, equip, remove, hint, quit.[/color]\n"
		text_box.text += "[color=#09ff00][Help] Type 'help command' to see further details. Example: 'help talk'[/color]\n"
	else:
		match command:
			"talk":
				text_box.text += "[color=#09ff00][Help] 'talk' to speak to NPCs. Example: 'talk to person'[/color]\n"
			"look":
				text_box.text += "[color=#09ff00][Help] 'look' to look around. Example: 'look west'[/color]\n"
			"move":
				text_box.text += "[color=#09ff00][Help] 'move' to move to the next area. Example: 'move west'[/color]\n"
			"take":
				text_box.text += "[color=#09ff00][Help] 'take' to pickup an [item]. Example: 'take knife'[/color]\n"
			"equip":
				text_box.text += "[color=#09ff00][Help] 'equip' to equip an [item]. Example: 'equip knife'[/color]\n"
			"remove":
				text_box.text += "[color=#09ff00][Help] 'remove' to remove an equipped [item]. Example: 'remove knife'[/color]\n"
			"hint":
				text_box.text += "[color=#09ff00][Help] 'hint' for assistance.[/color]\n"
			"quit":
				text_box.text += "[color=#09ff00][Help] 'quit' to exit the game[/color]\n"
			_:
				text_box.text += "[color=#ff0000][Help] Unknown command. Available commands: 'talk', 'look', 'move', 'take', 'equip', 'remove', 'hint', 'quit'.[/color]\n"

func handle_hint():
	text_box.text += "[color=#09ff00]" + "[Hint] " + adventure_test.hint + "[/color]\n"

func handle_take(item_name: String):
	var item_data = adventure_test.get_item_data(item_name)
	if item_data != {}:  # Check if item_data is valid
		print("handle_take call: ") # DEBUG
		#print(adventure_test.current_items) # DEBUG
		player_data.add_to_inventory(item_name)
		text_box.text += "[color=#09ff00][Take] You picked up the " + item_name + "[/color]\n"
	else:
		text_box.text += "[color=#ff0000][Take] There is no item to take.[/color]\n"

func handle_equip(item_name: String):
	if player_data.inventory.has(item_name):
		print("handle_equip call: ") # DEBUG
		#print(player_data.inventory) # DEBUG
		player_data.equip_item(item_name)
		text_box.text += "[color=#09ff00][Equip] You equipped the " + item_name + "[/color]\n"
	else:
		text_box.text += "[color=#ff0000]That item is not in your inventory.[/color]\n"

func handle_remove(item_name: String):
	var found_slot = "None"  # Default to None if no slot found
	# Find the slot where the item is equipped
	for slot in player_data.current_equipment.keys():
		if player_data.current_equipment[slot].to_lower() == item_name.to_lower():
			found_slot = slot
			break
	if found_slot != "None":
		print("handle_remove call: ")  # DEBUG
		print(player_data.inventory)  # DEBUG
		player_data.remove_item(found_slot)  # Call remove_item with the found slot
		text_box.text += "[color=#09ff00][Equip] You unequipped the " + item_name + "[/color]\n"
	else:
		text_box.text += "[color=#ff0000]That item is not equipped.[/color]\n"

func handle_move(direction: String):
	var exit_areas = adventure_test.get_exits()  # Get available exits from AdventureTest
	if exit_areas.has(direction):
		var next_area = exit_areas[direction]
		print("Attempting to move " + direction + " to " + next_area)  # DEBUG
		if adventure_test.can_move_to(next_area) == true:
			adventure_test.load_area(next_area)
			text_box.text += "[color=#09ff00][Move] You traveled " + direction + ".[/color]\n"
			print("Player moved " + direction + " and loaded into " + next_area)  # DEBUG
		else:
			print("Cannot move " + direction + ". Objective not completed.")  # DEBUG
	else:
		text_box.text += "[color=#09ff00][Move] You cannot go that way.[/color]\n"
		print("Invalid direction or no exit in that direction.")  # DEBUG

func list_npcs():
	var npc_list = adventure_test.npcs.keys()
	if npc_list.size() > 0:
		text_box.text += "[color=#09ff00][Talk] You can talk to: [/color]\n"
		for npc in npc_list:
			text_box.text += "[color=#09ff00]" + npc.capitalize() + "[/color]\n"
	else:
		text_box.text += "[color=#ff0000][Talk] There is no one to talk to here.[/color]\n"
