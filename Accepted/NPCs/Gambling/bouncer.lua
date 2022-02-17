club_bouncer = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		club_bouncer.bounce(player, npc)
	end,
	bounce = async(
		function(player, npc)
			local RandomX = math.random(3, 5)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}

			if player.registry["Gambling_VIP"] == 1 then
				table.insert(options, "Enter VIP Lounge")

				if not player:hasSpell("teleport_casino") then
					player.registry["learned_teleport_casino"] = 1
					player:addSpell("teleport_casino")
					player:updateState()
				end

				menu =
					player:menuString(name .. "Good day to you, VIP " .. player.name .. "! \n\nWhat would you like to do?", options)
			elseif player.registry["Gambling_VIP"] == 0 then
				if player:hasSpell("teleport_casino") then
					player.registry["learned_teleport_casino"] = 0
					player:removeSpell("teleport_casino")
					player:updateState()
				end

				if player:hasLegend("Gambling_VIP") then
					player:removeLegendbyName("Gambling_VIP")
				end

				menu =
					player:menuString(
					name .. "Good day to you, " .. player.name .. "! \n\nYou will need to attain VIP status to access this lounge.",
					options
				)
			end

			if menu == "Enter VIP Lounge" then
				player:warp(1042, RandomX, 17)
			end
		end
	)
}
