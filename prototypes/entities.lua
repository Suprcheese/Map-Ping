local null =	{
		filename = "__Map Ping__/graphics/null.png",
		priority = "low",
		width = 32,
		height = 32,
		scale = 1,
		shift = {0, 0},
		frame_count = 1,
		direction_count = 1
}

data:extend({
	{
		type = "container",
		name = "ping-tool",
		icon = "__Map Ping__/graphics/PingTool.png",
		icon_size = 32,
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

	-- {
		-- type = "train-stop",
		-- name = "map-ping-marker",
		-- icon = "__Map Ping__/graphics/PingTool.png",
		-- flags = {"placeable-off-grid", "placeable-neutral", "player-creation", "filter-directions"},
		-- order = "y",
		-- selectable_in_game = false,
		-- minable = {mining_time = 1, result = "train-stop"},
		-- max_health = 1,
		-- render_layer = "air-object",
		-- final_render_layer = "air-object",
		-- collision_box = {{0,0}, {0,0}},
		-- selection_box = {{0,0}, {0,0}},
		-- drawing_box = {{0,0}, {0,0}},
		-- tile_width = 1,
		-- tile_height = 1,
		-- animation_ticks_per_frame = 60,
		-- animations =
		-- {
			-- north = null,
			-- east = null,
			-- south = null,
			-- west = null,
		-- },
		-- vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0 },
		-- working_sound =
		-- {
			-- sound = { filename = "__base__/sound/train-stop.ogg", volume = 0 }
		-- },
		-- circuit_wire_connection_points = {},
		-- circuit_connector_sprites =
		-- {
			-- get_circuit_connector_sprites({0.5625-1, 1.03125}, {0.5625-1, 1.03125}, 0), --N
			-- get_circuit_connector_sprites({-0.78125, 0.28125-1}, {-0.78125, 0.28125-1}, 6), --E
			-- get_circuit_connector_sprites({-0.28125+1, 0.28125}, {-0.28125+1, 0.28125}, 0), --S
			-- get_circuit_connector_sprites({0.03125, 0.28125+1}, {0.03125, 0.28125+1}, 6), --W
		-- },
	-- },

	{
		type = "car",
		name = "ping-arrow",
		icon = "__Map Ping__/graphics/PingTool.png",
		icon_size = 32,
		flags = {"pushable", "placeable-neutral", "player-creation", "placeable-off-grid"},
		minable = {mining_time = 1, result = "car"},
		max_health = 1,
		order = "y",
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",
		energy_per_hit_point = 1,
		resistances = {},
		collision_box = {{0,0}, {0,0}},
		selection_box = {{0,0}, {0,0}},
		effectivity = 0.5,
		braking_power = "200kW",
		burner =
		{
			effectivity = 0.6,
			fuel_inventory_size = 1,
			smoke = {}
		},
		consumption = "150kW",
		friction = 2e-3,
		light = nil,
		animation = null,
		turret_animation = null,
		turret_rotation_speed = 0.35 / 60,
		sound_no_fuel =
		{
			{
				filename = "__base__/sound/fight/car-no-fuel-1.ogg",
				volume = 0.6
			},
		},
		stop_trigger_speed = 0.2,
		stop_trigger =
		{
			{
				type = "play-sound",
				sound =
				{
					{
						filename = "__base__/sound/car-breaks.ogg",
						volume = 0.6
					},
				}
			},
		},
		sound_minimum_speed = 0.2;
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0 },
		working_sound =
		{
			sound =
			{
				filename = "__base__/sound/car-engine.ogg",
				volume = 0
			},
			activate_sound =
			{
				filename = "__base__/sound/car-engine-start.ogg",
				volume = 0
			},
			deactivate_sound =
			{
				filename = "__base__/sound/car-engine-stop.ogg",
				volume = 0
			},
			match_speed_to_activity = true,
		},
		open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0 },
		close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0 },
		rotation_speed = 0.015,
		weight = 700,
		guns = {},
		inventory_size = 0
	},

	{
		type = "smoke-with-trigger",
		name = "map-ping-explosion",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
			layers =
			{
				{
					width = 256,
					height = 256,
					flags = { "compressed" },
					priority = "low",
					frame_count = 128,
					shift = {0, 0},
					animation_speed = 1,
					stripes =
					{
						{
							filename = "__Map Ping__/graphics/Pingsplosion1.png",
							width_in_frames = 8,
							height_in_frames = 8,
						},
						{
							filename = "__Map Ping__/graphics/Pingsplosion2.png",
							width_in_frames = 8,
							height_in_frames = 8,
						}
					}
				}
			}
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = settings.startup["map-ping-duration-ticks"].value,
		fade_away_duration = settings.startup["map-ping-duration-ticks"].value / 4,
		spread_duration = 10,
	}
})
