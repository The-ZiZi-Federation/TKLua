

engrave_item = {

cast = function(player)

	player:freeAsync()
	engrave_item.click(player, core)
end,
	

click = async(function(player, npc)
	

--	clone.gfx(player, npc)

	local t = {graphic = convertGraphic(1190, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local inven = {}
	local text = "<b>[Engrave Item]\n\n"
	
	for i = 0, player.maxInv do
		item = player:getInventoryItem(i)
		if item ~= nil then
			if item.type >= 3 and item.type <= 18 then
				table.insert(inven, item.id)
			end
		end
	end

	if #inven == 0 then
		anim(player)
		player:sendMinitext("You are lacking engraveable materials.")
	return else
		choice = player:sell(text.."What item do you wish to engrave?", inven)
		item = player:getInventoryItem(choice-1)
		if item == nil then return false else
			input = tostring(player:input(text.."What do you declare this item be dubbed:\n\n<b>Note:\n(Must in 3 - 23 Characters)"))
			if input ~= nil then
				icon = {graphic = item.icon, color = item.iconC}
				player.npcGraphic = icon.graphic
				player.npcColor = icon.color
				player.dialogType = 0
				if string.len(input) > 27 then
					player:dialogSeq({icon, text.."This engrave is too long to fit the item"})
				return else
					confirm = player:menuSeq(text.."Are you sure to dubbed: "..input.."? Engrave is permanent!", {"Yes, Im sure", "Cancel"}, {})
					if confirm == 1 then
						item.realName = "** "..input.." **"
						player:updateInv()
						player:dialogSeq({icon, text.."This item will now be dubbed: "..item.realName..""})
					end
				end
			end
		end
	end
end)
}









