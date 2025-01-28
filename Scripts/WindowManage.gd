#WindowManage.gd
extends Control

# ---------- Scene References ----------

# ---------- Node References ----------
@onready var close_button = get_node("Titlebar/CloseButton") # Close button
@onready var titlebar = get_node("Titlebar")
#@onready var resize_button = get_node("Panel/ResizeButton")  # Resize button

# ---------- Variables ----------

var is_dragging = false
var drag_offset = Vector2.ZERO
var rich_text_display : RichTextLabel
var default_position = Vector2.ZERO  # Store default position
var default_size = Vector2.ZERO        # Store default size

# ---------- Scene Load ----------

func _ready():
	# Debug prints to check node references
	#print_tree()  # Print the entire node tree to inspect paths
	#print("close_button: ", close_button)
	#print("titlebar: ", titlebar)
	#print("rich_text_display: ", rich_text_display)
	#print("resize_button: ", resize_button)

	# Set the default position and size
	default_position = position
	default_size = custom_minimum_size
	
	# Connect signals only if nodes are valid
	if close_button and not close_button.is_connected("pressed", Callable(self, "_on_close_button_pressed")):
		close_button.connect("pressed", Callable(self, "_on_close_button_pressed"))
	if titlebar and not titlebar.is_connected("gui_input", Callable(self, "_on_panel_gui_input")):
		titlebar.connect("gui_input", Callable(self, "_on_panel_gui_input"))
	#if resize_button and not resize_button.is_connected("gui_input", Callable(self, "_on_resize_button_gui_input")):
		#resize_button.connect("gui_input", Callable(self, "_on_resize_button_gui_input"))
	
	# Get the RichTextLabel and Button nodes
	rich_text_display = $TextBox/RichTextLabel

# Title bar dragging function
func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_dragging = true
				drag_offset = get_global_mouse_position() - global_position
			else:
				is_dragging = false
	elif event is InputEventMouseMotion and is_dragging:
		move_to_front()
		global_position = get_global_mouse_position() - drag_offset
		top_level = true

# Close button function
func _on_close_button_pressed():
	visible = false #if you want to reuse it

# Function to reset the window without losing data
func reset_window():
	position = default_position
	custom_minimum_size = default_size
	visible = true
	move_to_front()

# Resize button input handler
# TO DO
