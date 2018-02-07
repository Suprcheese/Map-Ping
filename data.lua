require("prototypes.items")
require("prototypes.recipes")
require("prototypes.entities")
require("prototypes.sounds")

data:extend({
	{
		type = "custom-input",
		name = "map-ping-hotkey",
		key_sequence = "SHIFT + P",
		consuming = "script-only"
	}
})
