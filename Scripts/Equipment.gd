extends Node

class_name Equipment

# ---------- Node References ----------

@onready var equip_label : RichTextLabel = $RichTextLabel  # Reference RichTextLabel node
@onready var item_label : RichTextLabel = $RichTextLabel2  # Reference RichTextLabel node

# ---------- Variables ----------

var player_data : PlayerData  # Reference PlayerData script

# ---------- Scene Load ----------

func _ready():
	#if equip_label == null:
		#print("Error: equip_label node not found!") # DEBUG
	#else:
		#print("equip_label node found!") # DEBUG
	#if item_label == null:
		#print("Error: item_label node not found!") # DEBUG
	#else:
		#print("item_label node found!") # DEBUG
	
	# Get PlayerData instance
	player_data = get_node("/root/PlayerData")  # Adjust path if needed
	if player_data != null:
		# Connect to the equipment_updated signal
		player_data.connect("equipment_updated", Callable(self, "_on_equipment_updated"))
		# Connect to the inventory_updated signal
		player_data.connect("inventory_updated", Callable(self, "_on_inventory_updated"))
		
		# Initialize the equipment and items display
		_on_equipment_updated(player_data.get_equipment())
		_on_inventory_updated(player_data.get_items())
	else:
		print("Error: PlayerData node not found!") # DEBUG

# Signal handler for when equipment is updated
func _on_equipment_updated(new_equipment : Dictionary) -> void:
	print("Equipment.on_equipment_updated(new_equipment)")
	var equip_text = ""
	for key in new_equipment.keys():
		equip_text += "[color=#09ff00]" + key.capitalize() + ": " + new_equipment[key] + "[/color]\n"
	equip_label.bbcode_text = equip_text

# Update the equipment display
func update_equipment(equipment : Dictionary) -> void:
	print("Equipment.update_equipment(equipment)")
	if equip_label != null:
		var equip_text = ""
		for key in equipment.keys():
			equip_text += "[color=#09ff00]" + key.capitalize() + ": " + str(equipment[key]) + "[/color]\n"
		equip_label.bbcode_text = equip_text
	else:
		print("equip_label is null!") # DEBUG

# Signal handler for when items are updated
func _on_inventory_updated(new_items: Dictionary) -> void:
	print("Equipment.on_inventory_updated(new_items)")
	var item_text = ""
	for key in new_items.keys():
		item_text += "[color=#09ff00]" + key.capitalize() + "[/color]\n"
	item_label.bbcode_text = item_text
	
# Update the items display
func update_items(items : Dictionary) -> void:
	print("Equipment.update_items(items)")
	if item_label != null:
		var item_text = ""
		for key in items.keys():
			item_text += "[color=#09ff00]" + key.capitalize() + item_text[key] + "[/color]\n"
		item_label.bbcode_text = item_text
	else:
		print("item_label is null!") # DEBUG
