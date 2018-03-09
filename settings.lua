data:extend({
	-- Startup
	{
		type = "int-setting",
		name = "map-ping-duration-ticks",
		setting_type = "startup",
		order = "a",
		default_value = 480,
		minimum_value = 30,
		maximum_value = 5000
	},
	-- Runtime (global)
	{
		type = "int-setting",
		name = "map-ping-lockout-ticks",
		setting_type = "runtime-global",
		order = "a",
		default_value = 120,
		minimum_value = 5,
		maximum_value = 5000
	},
	-- Runtime (per player)
	{
		type = "bool-setting",
		name = "map-ping-clean-inventory",
		setting_type = "runtime-per-user",
		order = "a",
		default_value = false
	},
	{
		type = "bool-setting",
		name = "map-ping-admin-panel",
		setting_type = "runtime-per-user",
		order = "b",
		default_value = true
	},
})
