dye_merchant = {
	click = async(
		function(player, npc)
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = {}
			table.insert(opts, "Browse dyes")
			table.insert(opts, "Get rid of my dye")
			table.insert(opts, "Exit")
			local opts2 = {"Yes", "No"}

			menu = player:menuString("<b>[Armor Dye]\n\nI am a dye maker, I can dye your armor for you.", opts)

			if menu == "Browse dyes" then
				player.registry["saved_dye"] = player.armorColor
				player.armorColor = 0
				if player.gfxClone == 0 then
					clone.equip(player, player)
					clone.equip(player, npc)
				else
					clone.gfx(player, player)
					clone.gfx(player, npc)
				end
				player:sendStatus()
				player:updateState()
				player:refresh()
				--	if player.gfxArmorC > 10 then player.gfxArmorC = 10 end
				--	player.gfxArmorC = 0
				player.gfxClone = 1
				player:sendStatus()
				player:updateState()
				player:refresh()
				player.registry["browse_dye_limit"] = 36
				dye_merchant_browse.click(player, npc)
			elseif menu == "Get rid of my dye" then
				confirm = player:menuString("<b>[Armor Dye]\n\nThis will erase any dye you have!\n\nContinue?", opts2)
				if confirm == "Yes" then
					player.armorColor = 0
					player.gfxClone = 0
					player:sendAnimation(251)
					player:sendStatus()
					player:updateState()
					player:refresh()
				end
			end
		end
	),
	wipe = function(player)
		if player.m == 2002 then
			player.gfxClone = 0
			player:updateState()
		end
	end
}

dye_merchant_browse = {
	click = function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this dye")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_dye_limit"]
		local model
		local price

		if limit == 36 then
			model = " Dye Browser "
		end

		clone.gfx(player, npc)
		menu = player:menuString("<b>[" .. model .. "]", opts)

		if menu == "Next ->>" then
			player.gfxArmorC = player.gfxArmorC + 1
			if limit == 36 then
				if player.gfxArmorC > limit then
					player.gfxArmorC = 1
				end
				if player.gfxArmorC < 1 then
					player.gfxArmorC = 36
				end
			end
			player:sendStatus()
			player:updateState()
			player:refresh()
			dye_merchant_browse.click(player, npc)
		elseif menu == "I want this dye" then
			local buy = {"Buy", "No, thanks"}
			ok = player:menuString("<b>[" .. model .. "]\n\nDo you want this dye?\n\nThe cost is 2,500 coins.", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.registry["saved_dye"] = 0
					player.armorColor = player.gfxArmorC
					player.gfxClone = 0
					player:sendStatus()
					player:updateState()
					player:sendAnimation(251)
					player:sendMinitext("You changed your dye!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:sendStatus()
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:sendStatus()
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			player.gfxArmorC = player.gfxArmorC - 1
			if limit == 36 then
				if player.gfxArmorC > limit then
					player.gfxArmorC = 1
				end
				if player.gfxArmorC < 1 then
					player.gfxArmorC = 36
				end
			end
			player:sendStatus()
			player:updateState()
			dye_merchant_browse.click(player, npc)
		else
			player.gfxClone = 0
			player:sendStatus()
			player:updateState()
		end
	end
}
