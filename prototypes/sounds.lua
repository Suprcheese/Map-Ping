data:extend({
	{
		type = "explosion",
		name = "ping-sound",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Map Ping__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		{
			filename = "__Map Ping__/sound/Ping.ogg",
			volume = 0
		},
		},
	}
})