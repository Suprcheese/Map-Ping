script.on_load(function() On_Load() end)

function On_Load()
	if global.selector or global.markers then
		script.on_event(defines.events.on_tick, process_tick)
	end
end

script.on_event(defines.events.on_player_created, function(event)
	if not global.permissions then
		global.permissions = {}
		global.permissions[0] = true
		global.permissions[event.player_index] = true
	else
		global.permissions[event.player_index] = global.permissions[0]
	end
end)

function open_GUI(player_index)
	local player = game.players[player_index]
	local frame = player.gui.left["ping-admin-panel"]
	if frame then
		frame.destroy()
	end
	frame = player.gui.left.add{type = "frame", name = "ping-admin-panel", direction = "vertical"}
	frame.add{type = "label", caption = {"ping-admin-panel-header"}}
	frame.add{type = "table", column_count = 2, name = "ping-admin-panel-table"}
	frame["ping-admin-panel-table"].add{type = "label", caption = {"player-names"}}
	frame["ping-admin-panel-table"].add{type = "label", caption = {"allowed-to-ping"}}
	frame["ping-admin-panel-table"].add{type = "label", caption = {"toggle-all"}}
	frame["ping-admin-panel-table"].add{type = "checkbox", state = global.permissions[0], name = "0"}
	for i, player in pairs(game.players) do
		frame["ping-admin-panel-table"].add{type = "label", caption = player.name}
		frame["ping-admin-panel-table"].add{type = "checkbox", state = global.permissions[player.index], name = player.index .. ""}
	end
	frame["ping-admin-panel-table"].add{type = "button", caption = {"close"}, name = "close-ping-admin-panel"}
end

function close_GUI(player_index)
	local player = game.players[player_index]
	local frame = player.gui.left["ping-admin-panel"]
	if frame then
		frame.destroy()
	end
end

script.on_event(defines.events.on_gui_checked_state_changed, function(event)
	local checkbox = event.element
	if checkbox.parent.name == "ping-admin-panel-table" then
		local index = tonumber(checkbox.name)
		global.permissions[index] = checkbox.state
		if index == 0 then
			for i = 1, #game.players do
				global.permissions[i] = global.permissions[0]
			end
		end
		open_GUI(event.player_index)
	end
end)

script.on_event(defines.events.on_gui_click, function(event)
	if event.element.name == "close-ping-admin-panel" then
		close_GUI(event.player_index)
	end
end)

script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
	if not global.permissions then
		global.permissions = {}
		global.permissions[0] = true
		for i, p in pairs(game.players) do
			global.permissions[p.index] = true
		end
	end
	local index = event.player_index
	local player = game.players[index]
	if player.character then
		if isHolding({name="ping-tool", count=1}, player) then
			if player.admin then
				open_GUI(index)
			end
			if not global.permissions[index] then
				player.print({"permission-denied"})
				return player.cursor_stack.clear()
			end
			player.character_build_distance_bonus = 5000
		else
			player.character_build_distance_bonus = 0
		end
	end
	if global.selector then
		local master = game.players[global.selector]
		if not isHolding({name="ping-tool", count=1}, master) then
			global.selector = nil
		end
	end
end)

function process_tick()
	if global.markers then
		local current_tick = game.tick
		for i = #global.markers, 1, -1 do -- Loop over table backwards because some entries get removed within the loop
			local marker = global.markers[i][1]
			local sub_tick = (current_tick - global.markers[i][2]) % 60
			if marker and marker.valid then
				if sub_tick == 0 then
					local arrow_position = marker.position
					arrow_position.y = arrow_position.y - 7
					local arrow = marker.surface.create_entity({name = "ping-arrow", position = arrow_position, force = marker.force, direction = defines.direction.south})
					arrow.insert({name="coal", count=1})
					global.markers[i][3] = arrow
				elseif sub_tick == 30 then
					if global.markers[i][3] and global.markers[i][3].valid then
						global.markers[i][3].destroy()
					end
				end
				if global.markers[i][2] == current_tick then
					if global.markers[i][3] and global.markers[i][3].valid then
						global.markers[i][3].destroy()
					end
					marker.destroy()
					table.remove(global.markers, i)
				end
			else
				if global.markers[i][3] and global.markers[i][3].valid then
					global.markers[i][3].destroy()
				end
				table.remove(global.markers, i)
			end
		end
	end
	if global.selector then
		local master = game.players[global.selector]
		local selected_entity = master.selected
		if selected_entity then
			for i, player in pairs(master.force.players) do
				player.clear_gui_arrow()
				player.set_gui_arrow({type = "entity", entity = selected_entity})
			end
		end
	else
		for i, player in pairs(game.players) do
			player.clear_gui_arrow()
		end
	end
	if global.markers and #global.markers == 0 then
		global.markers = nil
	end
	if not (global.markers or global.selector) then
		script.on_event(defines.events.on_tick, nil)
	end
end

function isHolding(stack, player)
	local holding = player.cursor_stack
	if holding and holding.valid_for_read and (holding.name == stack.name) and (holding.count >= stack.count) then
		return true
	end
	return false
end

function pingLocation(position, player)
	if not global.permissions[player.index] then
		player.print({"permission-denied"})
		return
	end
	local current_tick = game.tick
	if global.tick and (global.tick > current_tick) then
		return
	end
	global.tick = current_tick + settings.global["map-ping-lockout-ticks"].value
	local ping = player.surface.create_entity({name = "map-ping-explosion", position = position})
	local marker = player.force.add_chart_tag(player.surface, {position = position, text = player.name .. "'s ping location", last_user = player})
	global.markers = global.markers or {}
	table.insert(global.markers, {marker, current_tick + settings.startup["map-ping-duration-ticks"].value})
	for i, p in pairs(player.force.connected_players) do
		-- if settings.get_player_settings(p)["map-ping-custom-alerts"].value then
			p.add_custom_alert(ping, {type = "item", name = "ping-tool"}, {"ping-location", player.name, ping.position.x, ping.position.y}, true)
		-- end
	end
	-- player.force.print({"pinged-location", player.name})
	player.force.play_sound({path = "ping-sound"})
	script.on_event(defines.events.on_tick, process_tick)
end

script.on_event(defines.events.on_built_entity, function(event)
	local index = event.player_index
	local player = game.players[index]
	local entity = event.created_entity
	local entity_name = entity.name
	if entity_name == "entity-ghost" then
		if entity.ghost_name == "ping-tool" then
			if not global.permissions[index] then
				player.print({"permission-denied"})
				return entity.destroy()
			end
			if not global.selector then
				global.selector = index
				script.on_event(defines.events.on_tick, process_tick)
				player.print({"entered-selection-mode"})
			else
				player.print({"error-already-selection", game.players[global.selector].name})
			end
			return entity.destroy()
		end
	end
	if entity_name == "ping-tool" then
		player.cursor_stack.set_stack({name="ping-tool", count=1})
		pingLocation(entity.position, player)
		return entity.destroy()
	end
end)
