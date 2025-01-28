#PlayerData.gd
extends Node

# ---------- Signals ----------

signal equipment_updated # Signal to notify changes in equipment
signal inventory_updated # Signal to notify changes in items
signal stats1_updated # Signal to notify changes in stats1
signal stats2_updated # Signal to notify changes in stats2
signal condition_updated # Signal to notify changes in stats

# ---------- Variables ----------

var adventure_test  # Reference to AdventureTest.gd Node

var inventory : Dictionary = { # Stores items the player has picked up
	"items:": ""
} 
 
var current_equipment : Dictionary = { # Initialize items
	"head": "None",
	"chest": "None",
	"hands": "None",
	"feet": "None",
	"this_hand": "None",
	"that_hand": "None",
}

var stats1 : Dictionary = { # Stores data for player_stats_label1
	"Name": "\n",
	"BRN": 5,
	"QKN": 0,
	"GRT": 0,
	"BNS": 5
}  

var stats2 = { # Stores data for player_stats_label2
	"NTH": 0,
	"Next": 0,
	"HP": 0
} 

var condition = {
	"Status": ""
} # Stores data for player_condition_label


# ---------- Functions ----------

# Signal handler for items picked up
func _on_item_picked_up(item_name: String) -> void:
	#print("Signal handler triggered.") # DEBUG
	#print("Received item from AdventureTest: " + item_name) # DEBUG
	add_to_inventory(item_name)

# Add item to inventory and notify listeners
func add_to_inventory(item_name: String) -> void:
	if not inventory.has(item_name):
		inventory[item_name] = {"equipped": false}  # Flag for equipped status
	emit_signal("inventory_updated", inventory) # Emit signal with updated inventory
	#print("Added ", item_name, " to inventory.") # DEBUG

# Equip a new item and notify listeners
func equip_item(item_name: String) -> void:
	if inventory.has(item_name):
		var item_data = adventure_test.get_item_data(item_name)
		if item_data:
			var slot = item_data["slot"]
			current_equipment[slot] = item_name  # Capitalize words
			inventory[item_name]["equipped"] = true  # Mark as equipped
			emit_signal("equipment_updated", current_equipment)
			emit_signal("inventory_updated", inventory)
			print("Equipped ", item_name, " to ", slot)
		#else:
			#print("Item data not found for ", item_name) # DEBUG
	#else:
		#print(item_name, "is not in your inventory.") # DEBUG

# Unequip an item, mark it as unequipped, and notify listeners
func remove_item(slot: String) -> void:
	if current_equipment.get(slot, "None") != "None":
		var item_name = current_equipment[slot]
		print("Removing item: ", item_name, " from slot: ", slot)  # DEBUG
		current_equipment[slot] = "None"
		if inventory.has(item_name):
			inventory[item_name]["equipped"] = false  # Mark as unequipped
			emit_signal("equipment_updated", current_equipment)
			emit_signal("inventory_updated", inventory)
			print("Unequipped ", item_name, " from ", slot)

# Update stats1_label =$"../../Stats/TextBox/RichTextLabel"
func update_stats1(stat_name: String, value: int) -> void:
	if stats1.has(stat_name):
		stats1[stat_name] = value
		emit_signal("stats1_updated", stats1)
		print(stat_name.capitalize() + " updated to " + str(value) + ".")

# Update stats2_label = $"../../Stats/TextBox/RichTextLabel2"
func update_stats2(stat_name: String, value: int) -> void:
	if stats2.has(stat_name):
		stats2[stat_name] = value
		emit_signal("stats1_updated", stats2)
		print(stat_name.capitalize() + " updated to " + str(value) + ".")

# Update condition_label =$"../../Stats/TextBox2/RichTextLabel"
func update_condition(condition_name: String, value: int) -> void:
	if condition.has(condition_name):
		condition[condition_name] = value
		emit_signal("condition_updated", condition)
		print(condition_name.capitalize() + " updated to " + str(value) + ".")

# Return current equipment
func get_equipment() -> Dictionary:
	return current_equipment

# Return inventory
func get_items() -> Dictionary:
	return inventory

# Return stats1
func get_stats1() -> Dictionary:
	return stats1

# Return stats2
func get_stats2() -> Dictionary:
	return stats2

# Return condition
func get_condition() -> Dictionary:
	return condition

# Connect to AdventureTest.item_picked_up
func connect_to_adventure(adventure_test: Node):
	if adventure_test.has_signal("item_picked_up"):
		self.adventure_test = adventure_test
		if not adventure_test.is_connected("item_picked_up", Callable(self, "_on_item_picked_up")):
			adventure_test.connect("item_picked_up", Callable(self, "_on_item_picked_up"))
			print("Connected to AdventureTest item_picked_up signal.") # DEBUG
		else:
			## Duplicate or existing connections found
			#print("Item picked_up signal already connected.") # DEBUG
			print_connections()  # Call to debug connections
	#else:
		#print("AdventureTest does not have the required signal.") # DEBUG
	#print("Connection attempts completed.") # DEBUG

# Print all connected signals for AdventureTest.item_picked_up
func print_connections():
	# Debug connected signals
	var connections = adventure_test.get_signal_connection_list("item_picked_up")
	print("Current connections for 'item_picked_up':") # DEBUG
	for conn in connections:
		print("Callable: ", str(conn)) # DEBUG
