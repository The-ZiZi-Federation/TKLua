beta_respec_npc = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			table.insert(opts, "I want a respec please")
			menu = player:menuString(name .. "Hey buddy, want an SP respec?", opts)

			if (menu == "I want a respec please") then
				beta_respec_npc.sagefix(player)
				beta_respec_npc.gatewayfix(player)
				spend_sp.respec(player)
			end
		end
	),
	sagefix = function(player)
		if
			not player:hasSpell("whispering_wind_1") and not player:hasSpell("whispering_wind_2") and
				not player:hasSpell("whispering_wind_3") and
				not player:hasSpell("whispering_wind_4") and
				not player:hasSpell("whispering_wind_5")
		 then
			player:addSpell("whispering_wind_1")
		end
	end,
	gatewayfix = function(player)
		if player.quest["dre_loc_rambles"] >= 2 then
			if not player:hasSpell("gateway") and not player:hasSpell("gateway2") then
				player:addSpell("gateway")
			end
		end
	end
}
