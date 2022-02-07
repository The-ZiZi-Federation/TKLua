hon_arena_master = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {}

			table.insert(options, "I want to keep fighting!")
			table.insert(options, "Show me mercy!")

			menu = player:menuString(name .. "I'm the Arena Master. How can I help you?", options)

			if menu == "I want to keep fighting!" then
				if (player.state ~= 0) then
					player.speed = 80
					player.state = 0
					player:updateState()
					player:sendAnimation(108)
					player:playSound(112)
					npc:talk(0, "" .. npc.name .. ": Try not to get beat up so badly, " .. player.name .. "!")
					player:addHealth2(10000000)
					player:addMagic(1000000)
					player.registry["lastrez"] = os.time()
				else
					player:dialogSeq({t, name .. "You're already in fighting shape."}, 1)
				end
			elseif menu == "Show me mercy!" then
				if player.state ~= 1 then
					player.state = 1
					player.speed = 80
					player.registry["mounted"] = 0
					player:sendAnimation(14)
					player:playSound(112)
					player.health = 0
					player.magic = 0
					player:flushDuration()
					player:calcStat()
					player:sendStatus()
					player:updateState()
				end
			end
		end
	)
}
