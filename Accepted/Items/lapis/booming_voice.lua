booming_voice = {
	use = function(player)
		player:freeAsync()
		booming_voice.click(player)
	end,
	click = async(
		function(player, npc)
			local item = player:getInventoryItem(player.invSlot)
			local user = player:getUsers()
			local text1 = ""
			local text2 = ""

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			if player:hasItem(item.yname, 1) == true then
				if player:removeItemSlot(player.invSlot, 1) == true then
					text1 = tostring(player:input("What would you like to shout?((Part 1))"))
					text2 = tostring(player:input("What would you like to shout?((Part 2))"))
					broadcast(-1, "[" .. player.name .. "]: " .. text1 .. " " .. text2)
					player:sendAction(6, 20)
				end
			end
		end
	)
}
