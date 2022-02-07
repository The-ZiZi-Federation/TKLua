weap_element = {
	cast = function(player)
		local weap = player:getEquippedItem(EQ_WEAP)
		if weap ~= nil then
			player:talk(0, "" .. weap.element)
		end

		player:sendAction(6, 20)
		if weap == nil then
			anim(player)
			player:sendMinitext("There are no weapon on your hand")
			return
		else
			--		weap_element.menu(player, NPC(66), weap)
			player:freeAsync()
		end
	end,
	menu = async(
		function(player, npc, weap)
			local t = {graphic = weap.icon, color = weap.iconColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = {"Neutral", "Fire", "Water", "Wood", "Metal", "Earth", "Light", "Dark"}

			menu = player:menuSeq("What element?", opts, {})

			if menu > 0 then
				if weap ~= nil then
					weap.realName = weap.name .. " [" .. opts[menu] .. "]"
					weap.element = 1
					player:sendStatus()
					player:playSound(123)
					player:sendAnimation(253)
				end
			end
		end
	)
}
