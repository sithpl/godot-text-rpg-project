**Godot 4.3**

**Objective**
- Create a decent text-based RPG that requires little effort customize

**User Interface**
- Windows can move around, minimize, and reset (WindowsManage.gd handles general functions)
- Actions: Talk, Look, Help, Hint, Take, Equip, Remove, Move, Quit

_(Processed in PlayBox.gd, looks at AdventureTest.gd for values)_

**Stats**
- BRN = Brawn
- QKN = Quickness
- GRT = Grit
- BNS = Brains

_(Stored in PlayerData.gd, Accessed by Stats.gd)
(Stats can be renamed in PlayerData.gd)_

**Items/Equipment System**
- 5 inventory items
- 6 equip slots

_(Stored in AdventureTest.gd, accessed by PlayerData.gd and Equipment.gd)_

**NPCs**
- Names, dialogues, actions
_(Stored in AdventureTest.gd)_

**ASCII Maps**
- Local maps
- World map
_(Stored in each area in AdventureTest.gd)_

**Progression**
- Primary objectives (use this thing to progress)
- Secondary objectives (stats or other thing)
_(Stored in AdventureTest.gd)_

**-------------------- TO-DO --------------------**

**Character/Game State**
- Save character state
- Save game state
- Export states data as .txt

**User Interface**
- Re-size windows
- Save window locations
- Scale windows to fullscreen or preferred size
- 3 pre-set layouts the user can select
- System Menu appears above windows but cannot be interacted with unless you move a window away from it

**Stats**
- Implement NCH (Notch), Next, and HP
- Implement conditions

**Items/Equipment System**
- Equip doesn't remove item from inventory list
- Capitalize item names after being equipped
- Implement stats for items

**---------- Big Stuff ----------**

**Simple Character Creation**
- Set name
- Assign stats
- Save to external .txt for easy access

**Tutorial**
- Something to help new or those unfamilar with text-based RPGs
