local null =	{
		filename = "__Map Ping__/graphics/null.png",
		priority = "low",
		width = 32,
		height = 32,
		scale = 1,
		shift = {0, 0},
		frame_count = 1
}

data:extend({
	{
		type = "container",
		name = "ping-tool",
		icon = "__Map Ping__/graphics/PingTool.png",
		flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
		max_health = 1,
		corpse = "small-remnants",
		inventory_size = 0,
		collision_box = {{0,0}, {0,0}},
		collision_mask = {},
		picture =
		{
			filename = "__Map Ping__/graphics/PingTool.png",
			width = 32,
			height = 32,
			shift = {0, 0}
		}
	},

	{
		type = "train-stop",
		name = "map-ping-marker",
		icon = "__Map Ping__/graphics/PingTool.png",
		flags = {"placeable-off-grid", "placeable-neutral", "player-creation", "filter-directions"},
		order = "y",
		selectable_in_game = false,
		minable = {mining_time = 1, result = "train-stop"},
		max_health = 0,
		render_layer = "air-object",
		final_render_layer = "air-object",
		collision_box = {{0,0}, {0,0}},
		selection_box = {{0,0}, {0,0}},
		drawing_box = {{0,0}, {0,0}},
		tile_width = 1,
		tile_height = 1,
		animation_ticks_per_frame = 60,
		animations =
		{
			north = null,
			east = null,
			south = null,
			west = null,
		},
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0 },
		working_sound =
		{
			sound = { filename = "__base__/sound/train-stop.ogg", volume = 0 }
		},
		circuit_wire_connection_points = {},
		circuit_connector_sprites =
		{
			get_circuit_connector_sprites({0.5625-1, 1.03125}, {0.5625-1, 1.03125}, 0), --N
			get_circuit_connector_sprites({-0.78125, 0.28125-1}, {-0.78125, 0.28125-1}, 6), --E
			get_circuit_connector_sprites({-0.28125+1, 0.28125}, {-0.28125+1, 0.28125}, 0), --S
			get_circuit_connector_sprites({0.03125, 0.28125+1}, {0.03125, 0.28125+1}, 6), --W
		},
	},

	{
		type = "smoke-with-trigger",
		name = "map-ping-explosion",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
			filename = "__Map Ping__/graphics/Pingsplosion.png",
			priority = "low",
			width = 192,
			height = 192,
			frame_count = 20,
			animation_speed = 0.2,
			line_length = 5,
			scale = 1,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 60 * 5,
		spread_duration = 10,
	}
})