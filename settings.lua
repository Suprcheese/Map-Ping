data:extend({
	{
		type = "int-setting",
		name = "map-ping-lockout-ticks",
		setting_type = "runtime-global",
		order = "a",
		default_value = 120,
		minimum_value = 5,
		maximum_value = 5000
	},
	{
		type = "int-setting",
		name = "map-ping-duration-ticks",
		setting_type = "startup",
		order = "b",
		default_value = 480,
		minimum_value = 30,
		maximum_value = 5000
	}
})
