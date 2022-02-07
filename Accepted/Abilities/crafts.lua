pulverizing = {
	uncast = function(player)
		mortar.click(player, npc)
	end
}

concocting = {
	concoct = function(
		player,
		craftingItem01,
		craftingItem01Count,
		craftingItem02,
		craftingItem02Count,
		craftingItem03,
		craftingItem03Count,
		craftingItem04,
		craftingItem04Count,
		craftedItem,
		craftedItemName,
		duration)
		if player:hasDuration("concocting") or player:hasDuration("working") then
			return
		end

		player:setDuration("concocting", 10000000)
		working.work(
			player,
			craftingItem01,
			craftingItem01Count,
			craftingItem02,
			craftingItem02Count,
			craftingItem03,
			craftingItem03Count,
			craftingItem04,
			craftingItem04Count,
			craftedItem,
			craftedItemName,
			duration
		)
	end,
	while_cast = function(player)
		local potionStandObj = getObjFacing(player, player.side)
		local weap = player:getEquippedItem(EQ_WEAP)

		if potionStandObj == nil then
			player:setDuration("concocting", 0)
			player:setDuration("working", 0)
		else
			if (potionStandObj == 13593 or potionStandObj == 13523) then
				if player:hasDuration("working") then
					return
				else
					-- This is the actual stuff
					--working.work(player, craftingItem01, craftingItem01Count, craftingItem02, craftingItem02Count, craftingItem03, craftingItem03Count, craftingItem04, craftingItem04Count, craftedItem, craftedItemName, duration)
				end
			else
				player:setDuration("concocting", 0)
			end
		end

		--[[  USE THIS FOR THINGS THAT NEED A WEAPON LIKE PULVERIZATION
	if weap == nil then
		player:setDuration("concocting", 0)
		player:setDuration("working", 0)
	end
]]
	 --
	end,
	 --
	--[[  USE THIS FOR THINGS THAT NEED A WEAPON LIKE PULVERIZATION
while_cast_250 = function(player)

local weap = player:getEquippedItem(EQ_WEAP)

	if weap.yname ~= "pestle" and weap.yname ~= "bronze_tongs" and weap.yname ~= "silver_tongs" and weap.yname ~= "golden_tongs" then 
		player:setDuration("concocting", 0) 
		player:setDuration("working", 0) 
	end
end, 

]] uncast = function(
		player)
		player:calcStat()
		potionStand.click(player, npc)
	end
}

working = {
	work = function(
		player,
		craftingItem01,
		craftingItem01Count,
		craftingItem02,
		craftingItem02Count,
		craftingItem03,
		craftingItem03Count,
		craftingItem04,
		craftingItem04Count,
		craftedItem,
		craftedItemName,
		duration)
		local localDuration = duration
		local localcraftingItem01 = craftingItem01
		local localcraftingItem01Count = craftingItem01Count
		local localcraftingItem02 = craftingItem02
		local localcraftingItem02Count = craftingItem02Count
		local localcraftingItem03 = craftingItem03
		local localcraftingItem03Count = craftingItem03Count
		local localcraftingItem04 = craftingItem04
		local localcraftingItem04Count = craftingItem04Count
		local localcraftedItem = craftedItem
		local localcraftedItemName = craftedItemName

		local potionStandObj = getObjFacing(player, player.side)

		-- I they cannot cast for some reason.
		if not player:canCast(1, 1, 0) then
			return
		end
		-- If they are already "Working"
		if player:hasDuration("working") then
			return
		end

		if player.registry["working"] > 0 then
			player.registry["working"] = 0
		end

		if potionStandObj ~= nil then
			--concocting
			if (potionStandObj == 13593 or potionStandObj == 13523) then
				if
					player:hasItem(craftingItem01, craftingItem01Count) == true and
						player:hasItem(craftingItem02, craftingItem02Count) == true and
						craftingItem03 == "" and
						craftingItem04 == ""
				 then
					player:sendAction(28, 250)
					player:sendAnimation(313) -- Display the spell graphic / animation for the skill
					player:removeItem(craftingItem01, craftingItem01Count) -- Take away the item to be worked
					player:removeItem(craftingItem02, craftingItem02Count) -- Take away the item to be worked
					player:playSound(120)
					player:setDuration("working", duration)
					skill.leveling(player, totalEXP, ability) -- Give XP to Skill
					player:addItem(craftedItem, totalCrafted) -- and the items(s) produced

					if totalCrafted == 1 then -- Display message showing what was created
						player:talkSelf(2, "I have made a " .. craftedItemName)
					elseif numberPotions > 1 then
						player:talkSelf(2, "I have made " .. totalCrafted .. " " .. craftedItemName .. "s.")
					end
				elseif
					player:hasItem(craftingItem01, craftingItem01Count) == true and
						player:hasItem(craftingItem02, craftingItem02Count) == true and
						player:hasItem(craftingItem03, craftingItem03Count) == true and
						craftingItem04 == ""
				 then
					player:sendAction(28, 250)
					player:sendAnimation(313) -- Display the spell graphic / animation for the skill
					player:removeItem(craftingItem01, craftingItem01Count) -- Take away the item to be worked
					player:removeItem(craftingItem02, craftingItem02Count) -- Take away the item to be worked
					player:removeItem(craftingItem03, craftingItem03Count) -- Take away the item to be worked
					player:playSound(120)
					player:setDuration("working", duration)
					skill.leveling(player, totalEXP, ability) -- Give XP to Skill
					player:addItem(craftedItem, totalCrafted) -- and the items(s) produced

					if totalCrafted == 1 then -- Display message showing what was created
						player:talk(0, "I have made a " .. craftedItemName)
					elseif numberPotions > 1 then
						player:talk(0, "I have made " .. totalCrafted .. " " .. craftedItemName .. "s.")
					end
				elseif
					player:hasItem(craftingItem01, craftingItem01Count) == true and
						player:hasItem(craftingItem02, craftingItem02Count) == true and
						player:hasItem(craftingItem03, craftingItem03Count) == true and
						player:hasItem(craftingItem04, craftingItem04Count) == true
				 then
					player:sendAction(28, 250)
					player:sendAnimation(313) -- Display the spell graphic / animation for the skill
					player:removeItem(craftingItem01, craftingItem01Count) -- Take away the item to be worked
					player:removeItem(craftingItem02, craftingItem02Count) -- Take away the item to be worked
					player:removeItem(craftingItem03, craftingItem03Count) -- Take away the item to be worked
					player:removeItem(craftingItem04, craftingItem04Count) -- Take away the item to be worked
					player:playSound(120)
					player:setDuration("working", duration)
					skill.leveling(player, totalEXP, ability) -- Give XP to Skill
					player:addItem(craftedItem, totalCrafted) -- and the items(s) produced

					if totalCrafted == 1 then -- Display message showing what was created
						player:talk(0, "I have made a " .. craftedItemName)
					elseif numberPotions > 1 then
						player:talk(0, "I have made " .. totalCrafted .. " " .. craftedItemName .. "s.")
					end
				else
					player:talkSelf(0, "I don't have everything I need on me!")
					return
				end
				player:playSound(120)
				player:setDuration("working", 6000)
			else
				anim(player)
				player:setDuration("concocting", 0)
				player:msg(4, "[INFO] You need materials for this ability (Wool, etc.)", player.ID)
			end
		end

		working.work(
			player,
			localcraftingItem01,
			localcraftingItem01Count,
			localcraftingItem02,
			localcraftingItem02Count,
			locallocalcraftingItem03,
			localcraftingItem03Count,
			localcraftingItem04,
			localcraftingItem04Count,
			localcraftedItem,
			localcraftedItemName,
			localduration
		)
	end,
	-------------------- WHILE CAST -----------------------------------

	while_cast = function(player)
		local obj = getObjFacing(player, player.side)
		local r = math.random(5)

		if obj ~= nil then
			--concocting
			if obj == 3204 and player.m == 3127 then
				--pulverizing
				player:sendAnimation(272)
			elseif (obj >= 14937 and obj <= 14938) and player.m == 3129 then
				player:sendAnimation(269)
			end
		else
			player:setDuration("working", 0)
		end
		player:talkSelf(2, "Progress: " .. player.registry["ability"] .. "%")
	end,
	-------------- UNCAST ----------------------------------------------

	uncast = function(player)
		player:updateState()
		player:calcStat()
	end
}
