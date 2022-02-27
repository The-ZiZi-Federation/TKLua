	--[[ On Events ]]-----------------------------------------------------------------------------------
	--> onClick(player, target)					--> onBreak(player)
	--> onSwing(player)                			        --> onThrow(player,item)
	--> onViewBoard(player)          		   		--> onAction(player)
	--> onTradeButton(player)           				--> onSign(player, signType)
	--> onLevel(player)                 				--> onLook(player, block)
	--> onPickUp(player,item)           				--> onDismount(player)
	--> onDrop(player,item)             				--> remount(player)
	--> onEquip(player,item)            				--> onSummonedMount(player)
	--> onUnequip(player,item)          				--> onCreation(player)
	--> onDeathPlayer(player)           				--> onTurn(player)
	--> onCast(player)						--> onF5Key(player)
	--> onLeaveGroup(player)					--> onGroupXP(player, target)
	--> onWalk(player)						--> onSpecialMapAttack(player)
	--> onWalk(player)             					--> onLeaveGroup(player)
	--> onClick(player, target)    					--> onGroupXP(player)
	--> onSwing(player)            					--> onViewBoard(player)
	--> onF4Key(player)            					--> onUpdateBoard(player)
	--> onTradeKey(player)         					--> onSpecialMapR(player)

onSpawn = function(mob)

--	Player(4):talk(0,"Spawned "..mob.name)

--	mob:warp(mob.m, math.random(1, mob.xmax), math.random(1, mob.ymax))
	

	if mob.mobID > 1900 and mob.mobID < 1909 then --if the mob is one of the Crypt chests
		spawnChestRandomly(mob)
	end

end

onClick = function(player, target)

	if target.blType == BL_MOB then
		local pct = math.floor((target.health / target.maxHealth) * 100)
		player:sendMinitext(""..target.name.." ("..pct.."%)")
	elseif target.blType == BL_PC then
		local npc = NPC(1)
			
		if target.registry["v_open"] == 1 and target:hasDuration("vending_menu") then
			if target.ID == player.ID then
				player:freeAsync()
				vending_menu.click2(player, npc) 
				return 
			else
				if player.gmLevel > 0 then player:msg(0, "[INFO] 'onClick' character's menu will disable when target is on vending. Please use option from F1 > God tools", player.ID) end
	
				player:freeAsync()
				vending_menu.showShop(player, target, npc)
			end
		return else
			if player.registry["gm_click"] == 0 then
				if player.gmLevel > 0 then
				--	npc.gfxClone = 1
				--	player.lastClick = npc.ID
					player.dialogType = 0
					player:freeAsync()
					click.menu(player, target, npc)
				end
			return else
				player:freeAsync()
				duel.menu(player, target, npc)
			end
		end
	end
end

onDismount = function(player)

	local spawnLoc
	local side = player.side

	if player.state == 3 then 
		player.state = 0
		player.registry["mounted"] = 0
		player:updateState()
		if player.speed < 80 then player.speed = 80 end
		player:calcStat()
		if player.registry["wild_horse"] == 1 then
			if side == 0 then
				player:spawn(8, player.x, player.y-1, 1, player.m)
			elseif side == 1 then
				player:spawn(8, player.x+1, player.y, 1, player.m)
			elseif side == 2 then
				player:spawn(8, player.x, player.y+1, 1, player.m)
			elseif side == 3 then
				player:spawn(8, player.x-1, player.y, 1, player.m)
			end
			player.registry["wild_horse"] = 0
		end
	end
	player:setDuration("dismounting", 1000)
end

onF4Key = function(player)

end

-----------------------------------------------------------------------------------------------------
onF6Key = function(player)


end

onF12Key = function(player)
	

end

-----------------------------------------------------------------------------------------------------

onTradeKey = function(player) 
	

end

-----------------------------------------------------------------------------------------------------

onLeaveGroup = function(player)	


end

-----------------------------------------------------------------------------------------------------

onSpecialMapR = function(player)
	

end	

-----------------------------------------------------------------------------------------------------

onSpecialMapAttack = function(player)

end

-----------------------------------------------------------------------------------------------------
	
onAction = function(player)
	
	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local r = math.random(1, 2)
	local action = player.action

	--if player.state == 2 then
	--	if player:hasDuration("shadow") then return else
	--		player.state = 0
	--		player:updateState()
	--	end
	--end
	if action > 2 then
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "wind_walk" or mob[i].yname == "decoy" or mob[i].yname == "illusion" then
					if mob[i].owner == player.ID then
						mob[i]:sendAction(action, 75)
					end
				end
			end
		end
	end
	if action == 4 or action == 5 then
		if player:hasDuration("invisible") then
			player:setDuration("invisible", 0)
		end
	end
		
	christmas.pick(player, player.action)
	if action == 4 then snow_ball.pick(player) end
end

-----------------------------------------------------------------------------------------------------

onDrop = function(player,item)

	characterLog.dropWrite(player, item)
	dailyStardrop.onDrop(player, item)
end


onDropGold = function(player, item)

end

-----------------------------------------------------------------------------------------------------

onEquip = function(player, item)

	local item = player:getInventoryItem(player.invSlot)
	
	if player.m >= 15000 and player.m < 16000 and player.gmLevel == 0 then player:talkSelf(0,""..player.name..": It is not a bug. Stop trying to cheat!") return end
	player:equip()
	
end

-----------------------------------------------------------------------------------------------------

onUnequip = function(player, item)

	if player.m >= 15000 and player.m < 16000 and player.gmLevel == 0 then player:talkSelf(0,""..player.name..": It is not a bug. Stop trying to cheat!") return end
	player:takeOff()
	
end

-----------------------------------------------------------------------------------------------------

onThrow = function(player,item)
	--local y = player:getInventoryItem(player.invSlot) --returns inventory slot
	--player:talk(0,"Slot: "..player.invSlot.." Item returned "..y.name)
	player:throwItem()
end

-----------------------------------------------------------------------------------------------------

onLook = function(player, block)

    onSign(player, 1)
	player:lookAt(block.ID)
	
    local might = block.might
	local will = block.will
	local armor = block.armor
	local playerArmor = player.armor
	local mobBaseAttackSpeed = block.baseAttack
	local subpath, gmLvl = "", ""

	local mobAttackSpeed = (1000 / mobBaseAttackSpeed)
	local mightBonusPct = ((might / (might + 50)) ^1.1)
	local bareHandDamage = might + (might * mightBonusPct)  -- new derived stat.
	local bareHandBonus = math.floor((bareHandDamage * .1))
	if bareHandBonus < 1 then
		bareHandBonus = 1
	end
	local bareHandBonusDamage = math.random(1,bareHandBonus)
	local maxBareHandDamage = math.floor(bareHandDamage + bareHandBonusDamage)

	local damagePerSecond = bareHandDamage * mobAttackSpeed
	local maxDPS = maxBareHandDamage * mobAttackSpeed
	local avgDPS = ((damagePerSecond + maxDPS) / 2)
	
	local armorPhysReduction = (armor/(armor + 510))   -- gives a max of 66% absorb at 999 points
	local willMagReduction = (will / (will + 1000))

	local playerArmorPhysReduction = (playerArmor/(playerArmor + 510))   -- gives a max of 66% absorb at 999 points
	
	local swingDamageAfterArmor = (bareHandDamage - (bareHandDamage * (playerArmorPhysReduction)))
	local maxSwingDamageAfterArmor = (maxBareHandDamage - (maxBareHandDamage * (playerArmorPhysReduction)))

	local damagePerSecondAfterArmor = (damagePerSecond - (damagePerSecond * (playerArmorPhysReduction)))
		
	if player.gmLevel > 0 then
		if block.blType == BL_PC then
			if block.gmLevel > 0 then gmLvl = ",  gmLevel : "..block.gmLevel.."" end
			if block.class > 4 then subpath = ",  SubClass: "..block.classNameMark.."" end
			player:msg(0, "", player.ID)
			player:msg(0, " - Name      :  "..block.name.." (Id: "..block.ID..") / Level: "..block.level..""..gmLvl, player.ID)
			player:msg(0, " - Class     :  "..block:baseClassName()..""..subpath.." / Totem: "..block:totemName().."", player.ID)		
			player:msg(0, " - Vita      :  "..format_number(block.health).." / "..format_number(block.maxHealth).."  ("..string.format("%.2f", (block.health/block.maxHealth*100)).."%)", player.ID)
			player:msg(0, " - Mana      :  "..format_number(block.magic).." / "..format_number(block.maxMagic).."  ("..string.format("%.2f", (block.magic/block.maxMagic*100)).."%)", player.ID)
			player:msg(0, "", player.ID)
		
		elseif block.blType == BL_MOB then
			player:msg(0, "", player.ID)
			player:msg(0, "Name       :  "..block.name.."  [(mobId: "..block.mobID..") | (spawnId: "..block.ID..")]", player.ID)
			player:msg(0, "Vita       :  "..string.format("%8d", (block.health)).."/"..string.format("%8d",(block.maxHealth)).." ("..string.format("%.2f", (block.health/block.maxHealth*100)).."%)     | Armor     :  "..string.format("%6d", (block.armor)).." (Phys Abs % = "..string.format("%.2f", (armorPhysReduction*100)).."%)", player.ID)
			player:msg(0, "Might      :  "..string.format("%6d", (block.might)).." | Grace      :  "..string.format("%6d", (block.grace)).."   | Will      :  "..string.format("%6d", (block.will)).." (Mag Abs % =  "..string.format("%.2f", (willMagReduction*100)).."%)", player.ID)
			player:msg(0, "Atk Speed  :  "..string.format("%6d", (mobBaseAttackSpeed)).." | Move Speed :  "..string.format("%6d", round(block.baseMove)).."", player.ID)
			player:msg(0, "Dmg P/Swing:  "..string.format("%6d", round(bareHandDamage)).." - "..string.format("%6d", round(maxBareHandDamage)).."                 | Dmg P/Sec :  "..string.format("%6d", round(avgDPS)).."", player.ID)
			player:msg(0, "PlayerArmor:  "..string.format("%6d", round(playerArmor)).." (Phys Abs % = "..string.format("%.2f",(playerArmorPhysReduction*100)).."%)", player.ID)
			player:msg(0, "DPSw -Armor:  "..string.format("%6d", round(swingDamageAfterArmor)).." - "..string.format("%6d", round(maxSwingDamageAfterArmor)).."                 | DPS -Armor:  "..string.format("%6d", round(damagePerSecondAfterArmor)).."", player.ID)
			player:msg(0, "Target: "..block.target.."", player.ID)
			player:msg(0, "Attacker: "..block.attacker.."", player.ID)
			player:msg(0, "Experience :  "..format_number(block.experience).."", player.ID)
			player:msg(0, "", player.ID)
			
		elseif block.blType == BL_NPC then
			--player:msg(0, "==============================================================================================================================", player.ID)
			--player:msg(0, "Name   : "..block.name.." (Id: "..block.ID..")", player.ID)
			--player:msg(0, "Class  : "..block.classNameMark.."", player.ID)
			--player:msg(0, "Health : "..format_number(block.health).."/"..format_number(block.maxHealth).." ("..string.format("%.2f", (block.health/block.maxHealth*100)).."%)", player.ID)
			--player:msg(0, "Magic  : "..format_number(block.magic).."/"..format_number(block.maxMagic).." ("..string.format("%.2f", (block.magic/block.maxMagic*100)).."%)", player.ID)
			--player:msg(0, "==============================================================================================================================", player.ID)	
		end	
	end
end

-----------------------------------------------------------------------------------------------------

onTurn = function(player)

	local obj = getObject(player.m, player.x, player.y)
	local dpass = getPass(player.m, player.x, player.y+1)

	onSign(player, 3)
	publicBoards(player)
	
	if player.drunk == 1 then
		if player.side == 0 then
			player.side = 2
		elseif player.side == 1 then
			player.side = 3
		elseif player.side == 3 then
			player.side = 1
		elseif player.side == 2 then
			player.side = 0
		end
		player:sendSide()
	end

	if player.m == 15015 then
		if player.side == 0 then
			if obj ~= 14349 then
				if obj ~= 14347 then
					player.side = 1
					player:sendSide()
					player:sendMinitext("Nothing to climb!")
				end
			end
		elseif player.side == 2 then
			if getTile(player.m,player.x,player.y) == 41641 then
				player.side = 3
				player:sendSide()
				player:sendMinitext("Nothing to climb!")
			return
			end
		end
	end
	
	if player:hasDuration("decoy") then
	
		decoy.turn(player)
	end
end

-----------------------------------------------------------------------------------------------------
	
--if owner if can pickup item. also if GMlevel > 0

onPickUp = function(player,item)

--if player.m == 1 then Player(4):talk(0,"id: "..item.id) end
--if player.m == 1 then Player(4):talk(0,"name: "..item.name) end
--if player.m == 1 then Player(4):talk(0,"cursed: "..item.cursed) end

--	if item.cursed > 0 then
--		if player.ID ~= item.cursed then
--			player:sendMinitext("These items are cursed to "..getOfflineID(item.cursed))
--			return
--		elseif player.ID == item.cursed then
--			item.cursed = 0
--		end
--	end
	
	local curseCheck = 0
	
	local prohibitedItems = {252,253,254,255,256,257,854,6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965, 21001}
	
	
	if player.gmLevel == 0 then
		for i = 1, #prohibitedItems do
			
			if item.id == prohibitedItems[i] then
				anim(player)
				player:sendMinitext("You cannot pickup this item.")
				return
			end
		end
	end

---------single item pickup (comma)---------------------------------------------------------------

	if player.pickUpType == 0 then		
		groundItems = player:getObjectsInCell(player.m, player.x, player.y, BL_ITEM)
		if #groundItems > 0 then
			for i = 1, 1 do
				if groundItems[i].id <=12 then  --If it is coins
					if groundItems[i].cursed == 0 or groundItems[i].cursed == player.ID then
				       	groundItems[i]:delete()
				       	player:addGold(groundItems[i].amount)
					elseif groundItems[i].cursed > 0 and groundItems[i].cursed ~= player.ID then
						curseCheck = groundItems[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItems[i].cursed))
					end
				elseif groundItems[i].id > 12 then  --If it is not coins
					if groundItems[i].cursed == 0 or groundItems[i].cursed == player.ID then
						--characterLog.pickUpWrite(player, groundItems[i], 1)
						player:pickUp(groundItems[i].ID)
					elseif groundItems[i].cursed > 0 and groundItems[i].cursed ~= player.ID then
						curseCheck = groundItems[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItems[i].cursed))
					end
				end
			end
		end
	end
	
---------multi item pickup (shift+comma)---------------------------------------------------------------

	if player.pickUpType == 1 then		
		groundItems = player:getObjectsInCell(player.m, player.x, player.y, BL_ITEM)
		if #groundItems > 0 then
			for i = 1, #groundItems do
				if groundItems[i].id <=12 then  --If it is coins
					if groundItems[i].cursed == 0 or groundItems[i].cursed == player.ID then
				       	groundItems[i]:delete()
				       	player:addGold(groundItems[i].amount)
					elseif groundItems[i].cursed > 0 and groundItems[i].cursed ~= player.ID then
						curseCheck = groundItems[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItems[i].cursed))
					
					end
				elseif groundItems[i].id > 12 then  --If it is not coins
					if groundItems[i].cursed == 0 or groundItems[i].cursed == player.ID then
						--characterLog.pickUpWrite(player, groundItems[i], groundItems[i].amount)
						player:pickUp(groundItems[i].ID)
					elseif groundItems[i].cursed > 0 and groundItems[i].cursed ~= player.ID then
						curseCheck = groundItems[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItems[i].cursed))
					end
				end
			end
		end
	end

---------area item pickup (control+comma)---------------------------------------------------------------

	if player.pickUpType == 3 then
		local groundItem1 = player:getObjectsInCell(player.m, player.x, player.y, BL_ITEM)
		local groundItem2 = player:getObjectsInCell(player.m, player.x-1, player.y, BL_ITEM)
		local groundItem3 = player:getObjectsInCell(player.m, player.x+1, player.y, BL_ITEM)
		local groundItem4 = player:getObjectsInCell(player.m, player.x, player.y-1, BL_ITEM)
		local groundItem5 = player:getObjectsInCell(player.m, player.x, player.y+1, BL_ITEM)
		local groundItem6 = player:getObjectsInCell(player.m, player.x-1, player.y-1, BL_ITEM)
		local groundItem7 = player:getObjectsInCell(player.m, player.x-1, player.y+1, BL_ITEM)
		local groundItem8 = player:getObjectsInCell(player.m, player.x+1, player.y-1, BL_ITEM)
		local groundItem9 = player:getObjectsInCell(player.m, player.x+1, player.y+1, BL_ITEM)
		
		local surroundingPC1 = player:getObjectsInCell(player.m, player.x, player.y, BL_PC)
		local surroundingPC2 = player:getObjectsInCell(player.m, player.x-1, player.y, BL_PC)
		local surroundingPC3 = player:getObjectsInCell(player.m, player.x+1, player.y, BL_PC)
		local surroundingPC4 = player:getObjectsInCell(player.m, player.x, player.y-1, BL_PC)
		local surroundingPC5 = player:getObjectsInCell(player.m, player.x, player.y+1, BL_PC)
		local surroundingPC6 = player:getObjectsInCell(player.m, player.x-1, player.y-1, BL_PC)
		local surroundingPC7 = player:getObjectsInCell(player.m, player.x-1, player.y+1, BL_PC)
		local surroundingPC8 = player:getObjectsInCell(player.m, player.x+1, player.y-1, BL_PC)
		local surroundingPC9 = player:getObjectsInCell(player.m, player.x+1, player.y+1, BL_PC)		
		
		local surroundingNPC1 = player:getObjectsInCell(player.m, player.x, player.y, BL_NPC)
		local surroundingNPC2 = player:getObjectsInCell(player.m, player.x-1, player.y, BL_NPC)
		local surroundingNPC3 = player:getObjectsInCell(player.m, player.x+1, player.y, BL_NPC)
		local surroundingNPC4 = player:getObjectsInCell(player.m, player.x, player.y-1, BL_NPC)
		local surroundingNPC5 = player:getObjectsInCell(player.m, player.x, player.y+1, BL_NPC)
		local surroundingNPC6 = player:getObjectsInCell(player.m, player.x-1, player.y-1, BL_NPC)
		local surroundingNPC7 = player:getObjectsInCell(player.m, player.x-1, player.y+1, BL_NPC)
		local surroundingNPC8 = player:getObjectsInCell(player.m, player.x+1, player.y-1, BL_NPC)
		local surroundingNPC9 = player:getObjectsInCell(player.m, player.x+1, player.y+1, BL_NPC)	
		
		if #groundItem1 > 0 then
			for i = 1, #groundItem1 do
				if groundItem1[i].id <=12 then  --If it is coins
					if groundItem1[i].cursed == 0 or groundItem1[i].cursed == player.ID then
						if #surroundingNPC1 == 0 then   --if no one is standing on it
							groundItem1[i]:delete()
							player:addGold(groundItem1[i].amount)
						end
					elseif groundItem1[i].cursed > 0 and groundItem1[i].cursed ~= player.ID then	
						curseCheck = groundItem1[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem1[i].cursed))
					end
				elseif groundItem1[i].id > 12 then  --If it is not coins
					if groundItem1[i].cursed == 0 or groundItem1[i].cursed == player.ID then
						if #surroundingNPC1 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem1[i], groundItem1[i].amount)
							player:pickUp(groundItem1[i].ID) 
						end
					elseif groundItem1[i].cursed > 0 and groundItem1[i].cursed ~= player.ID then
						curseCheck = groundItem1[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem1[i].cursed))
					end
				end
			end			
		end

		if #groundItem2 > 0 then
			for i = 1, #groundItem2 do
				if groundItem2[i].id <=12 then  --If it is coins
					if groundItem2[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC2 == 0 and #surroundingNPC2 == 0 then   --if no one is standing on it
							groundItem2[i]:delete()
							player:addGold(groundItem2[i].amount)
						end
					elseif groundItem2[i].cursed == player.ID then --if it is cursed to the player
						groundItem2[i]:delete()
				       	player:addGold(groundItem2[i].amount)
					elseif groundItem2[i].cursed > 0 and groundItem2[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem2[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem2[i].cursed))
					end
					
				elseif groundItem2[i].id > 12 then  --If it is an item
					if groundItem2[i].cursed == 0 then --if it is not cursed
						if #surroundingPC2 == 0 and #surroundingNPC2 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem2[i], groundItem2[i].amount)
							player:pickUp(groundItem2[i].ID)
						end
		
					elseif groundItem2[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem2[i], groundItem2[i].amount)
						player:pickUp(groundItem2[i].ID)
		
					elseif groundItem2[i].cursed > 0 and groundItem2[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem2[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem2[i].cursed))
					end
				end
			end			
		end
		
		
		if #groundItem3 > 0 then
			for i = 1, #groundItem3 do
				if groundItem3[i].id <=12 then  --If it is coins
					if groundItem3[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC3 == 0 and #surroundingNPC3 == 0 then   --if no one is standing on it
							groundItem3[i]:delete()
							player:addGold(groundItem3[i].amount)
						end
					elseif groundItem3[i].cursed == player.ID then --if it is cursed to the player
						groundItem3[i]:delete()
				       	player:addGold(groundItem3[i].amount)
					elseif groundItem3[i].cursed > 0 and groundItem3[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem3[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem3[i].cursed))
					end
					
				elseif groundItem3[i].id > 12 then  --If it is an item
					if groundItem3[i].cursed == 0 then --if it is not cursed
						if #surroundingPC3 == 0 and #surroundingNPC3 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem3[i], groundItem3[i].amount)
							player:pickUp(groundItem3[i].ID)
						end
		
					elseif groundItem3[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem3[i], groundItem3[i].amount)
						player:pickUp(groundItem3[i].ID)
		
					elseif groundItem3[i].cursed > 0 and groundItem3[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem3[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem3[i].cursed))
					end
				end
			end			
		end

		if #groundItem4 > 0 then
			for i = 1, #groundItem4 do
				if groundItem4[i].id <=12 then  --If it is coins
					if groundItem4[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC4 == 0 and #surroundingNPC4 == 0 then   --if no one is standing on it
							groundItem4[i]:delete()
							player:addGold(groundItem4[i].amount)
						end
					elseif groundItem4[i].cursed == player.ID then --if it is cursed to the player
						groundItem4[i]:delete()
				       	player:addGold(groundItem4[i].amount)
					elseif groundItem4[i].cursed > 0 and groundItem4[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem4[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem4[i].cursed))
					end
					
				elseif groundItem4[i].id > 12 then  --If it is an item
					if groundItem4[i].cursed == 0 then --if it is not cursed
						if #surroundingPC4 == 0 and #surroundingNPC4 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem4[i], groundItem4[i].amount)
							player:pickUp(groundItem4[i].ID)
						end
		
					elseif groundItem4[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem4[i], groundItem4[i].amount)
						player:pickUp(groundItem4[i].ID)
		
					elseif groundItem4[i].cursed > 0 and groundItem4[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem4[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem4[i].cursed))
					end
				end
			end			
		end

		if #groundItem5 > 0 then
			for i = 1, #groundItem5 do
				if groundItem5[i].id <=12 then  --If it is coins
					if groundItem5[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC5 == 0 and #surroundingNPC5 == 0 then   --if no one is standing on it
							groundItem5[i]:delete()
							player:addGold(groundItem5[i].amount)
						end
					elseif groundItem5[i].cursed == player.ID then --if it is cursed to the player
						groundItem5[i]:delete()
				       	player:addGold(groundItem5[i].amount)
					elseif groundItem5[i].cursed > 0 and groundItem5[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem5[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem5[i].cursed))
					end
					
				elseif groundItem5[i].id > 12 then  --If it is an item
					if groundItem5[i].cursed == 0 then --if it is not cursed
						if #surroundingPC5 == 0 and #surroundingNPC5 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem5[i], groundItem5[i].amount)
							player:pickUp(groundItem5[i].ID)
						end
		
					elseif groundItem5[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem5[i], groundItem5[i].amount)
						player:pickUp(groundItem5[i].ID)
		
					elseif groundItem5[i].cursed > 0 and groundItem5[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem5[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem5[i].cursed))
					end
				end
			end			
		end

		if #groundItem6 > 0 then
			for i = 1, #groundItem6 do
				if groundItem6[i].id <=12 then  --If it is coins
					if groundItem6[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC6 == 0 and #surroundingNPC6 == 0 then   --if no one is standing on it
							groundItem6[i]:delete()
							player:addGold(groundItem6[i].amount)
						end
					elseif groundItem6[i].cursed == player.ID then --if it is cursed to the player
						groundItem6[i]:delete()
				       	player:addGold(groundItem6[i].amount)
					elseif groundItem6[i].cursed > 0 and groundItem6[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem6[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem6[i].cursed))
					end
					
				elseif groundItem6[i].id > 12 then  --If it is an item
					if groundItem6[i].cursed == 0 then --if it is not cursed
						if #surroundingPC6 == 0 and #surroundingNPC6 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem6[i], groundItem6[i].amount)
							player:pickUp(groundItem6[i].ID)
						end
		
					elseif groundItem6[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem6[i], groundItem6[i].amount)
						player:pickUp(groundItem6[i].ID)
		
					elseif groundItem6[i].cursed > 0 and groundItem6[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem6[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem6[i].cursed))
					end
				end
			end			
		end
		

		if #groundItem7 > 0 then
			for i = 1, #groundItem7 do
				if groundItem7[i].id <=12 then  --If it is coins
					if groundItem7[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC7 == 0 and #surroundingNPC7 == 0 then   --if no one is standing on it
							groundItem7[i]:delete()
							player:addGold(groundItem7[i].amount)
						end
					elseif groundItem7[i].cursed == player.ID then --if it is cursed to the player
						groundItem7[i]:delete()
				       	player:addGold(groundItem7[i].amount)
					elseif groundItem7[i].cursed > 0 and groundItem7[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem7[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem7[i].cursed))
					end
					
				elseif groundItem7[i].id > 12 then  --If it is an item
					if groundItem7[i].cursed == 0 then --if it is not cursed
						if #surroundingPC7 == 0 and #surroundingNPC7 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem7[i], groundItem7[i].amount)
							player:pickUp(groundItem7[i].ID)
						end
		
					elseif groundItem7[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem7[i], groundItem7[i].amount)
						player:pickUp(groundItem7[i].ID)
		
					elseif groundItem7[i].cursed > 0 and groundItem7[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem7[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem7[i].cursed))
					end
				end
			end			
		end

		if #groundItem8 > 0 then
			for i = 1, #groundItem8 do
				if groundItem8[i].id <=12 then  --If it is coins
					if groundItem8[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC8 == 0 and #surroundingNPC8 == 0 then   --if no one is standing on it
							groundItem8[i]:delete()
							player:addGold(groundItem8[i].amount)
						end
					elseif groundItem8[i].cursed == player.ID then --if it is cursed to the player
						groundItem8[i]:delete()
				       	player:addGold(groundItem8[i].amount)
					elseif groundItem8[i].cursed > 0 and groundItem8[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem8[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem8[i].cursed))
					end
					
				elseif groundItem8[i].id > 12 then  --If it is an item
					if groundItem8[i].cursed == 0 then --if it is not cursed
						if #surroundingPC8 == 0 and #surroundingNPC8 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem8[i], groundItem8[i].amount)
							player:pickUp(groundItem8[i].ID)
						end
		
					elseif groundItem8[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem8[i], groundItem8[i].amount)
						player:pickUp(groundItem8[i].ID)
		
					elseif groundItem8[i].cursed > 0 and groundItem8[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem8[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem8[i].cursed))
					end
				end
			end			
		end

		if #groundItem9 > 0 then
			for i = 1, #groundItem9 do
				if groundItem9[i].id <=12 then  --If it is coins
					if groundItem9[i].cursed == 0 then	--if it is not cursed
						if #surroundingPC9 == 0 and #surroundingNPC9 == 0 then   --if no one is standing on it
							groundItem9[i]:delete()
							player:addGold(groundItem9[i].amount)
						end
					elseif groundItem9[i].cursed == player.ID then --if it is cursed to the player
						groundItem9[i]:delete()
				       	player:addGold(groundItem9[i].amount)
					elseif groundItem9[i].cursed > 0 and groundItem9[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem9[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem9[i].cursed))
					end
					
				elseif groundItem9[i].id > 12 then  --If it is an item
					if groundItem9[i].cursed == 0 then --if it is not cursed
						if #surroundingPC9 == 0 and #surroundingNPC9 == 0 then   --if no one is standing on it
							--characterLog.pickUpWrite(player, groundItem9[i], groundItem9[i].amount)
							player:pickUp(groundItem9[i].ID)
						end
		
					elseif groundItem9[i].cursed == player.ID then --if it is cursed to the player
						--characterLog.pickUpWrite(player, groundItem9[i], groundItem9[i].amount)
						player:pickUp(groundItem9[i].ID)
		
					elseif groundItem9[i].cursed > 0 and groundItem9[i].cursed ~= player.ID then --if it is cursed to someone else
						curseCheck = groundItem9[i].cursed
						--player:sendMinitext("This is cursed to "..getOfflineID(groundItem9[i].cursed))
					end
				end
			end			
		end
		
	end
	if curseCheck > 0 then
		player:sendMinitext("This is cursed to "..getOfflineID(curseCheck))
	end
	--quest.pickUp(player, item)
end

-----------------------------------------------------------------------------------------------------

onLevel = function(player)

	local sp = player.registry["stat_points"]

	if (player.level >= 100) then return end
	
	player.baseHealth = player.baseHealth + 100
	player.baseMagic = player.baseMagic + 100
	player:calcStat()
	spend_sp.gain(player)

	player.level = player.level + 1
	baseStatIncrease(player)
	--player.baseAC = 0
	player.health = player.maxHealth
	player.magic = player.maxMagic
	player:sendStatus()
	player:sendAnimation(253)
	player:playSound(123)
	player:talkSelf(2, "Level up!!")

	characterLog.levelUpWrite(player, player.level)
end

-----------------------------------------------------------------------------------------------------

onDeathPlayer = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local lost = 0
	local attacker = player:getBlock(player.attacker)
	local pc = core:getUsers()
	local m, x, y = player.m, player.x, player.y
	local found = 0
	local curseTime = 900000


	if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
		if player.m ~= 15100 then
			player.state = 0 
			player.health = player.maxHealth
			player.speed = 80
			player:sendStatus()
			player:updateState()
			return
		end
	end

	player.deathFlag = 1
	player.state = 1
	player:flushDuration()
	player:updateState()
	player:sendStatus()
	if player.region == 15 or player.m == 1032 then return end
	if player.m == 51 then
		player.registry["intro_death_timer"] = os.time() + 5
	end

	if player.m ~= 1000 and player.m ~= 1 and player.m ~= 2 then --no penalties in Hon or test maps
		player:deathDuraLoss()
		player:deathDropGold()
		player:deathPileDrop()
		player:deathExpLoss()
	end

	local npc = core:getObjectsInCell(m, x, y, BL_NPC)		
	if #npc > 0 then		
		for i = 1, #npc do				
			if npc[i].owner == player.ID then				
				found = 1				
				npc[i].duration = npc[i].duration + curseTime			
			end
		end
	end

	if found == 0 then
		player:addNPC("death_pile_sweeper", m, x, y, 1000, curseTime, player.ID)
	end
	
	
	if player.m ~= 51 then
		player:talkSelf(0,""..player.name..": I died at "..player.mapTitle..", X: "..player.x..", Y: "..player.y)
	end
	for i = 1, #pc do
		if pc[i].gmLevel > 0 then
			pc[i]:msg(4, "[DEATH]: "..player.name.." was killed by "..attacker.name.. " at "..player.mapTitle, pc[i].ID)
		end
	end
end

-----------------------------------------------------------------------------------------------------

onBreak = function(player)

	player:msg(12, "[INFO]: Your "..Item(player.breakID).name.." broke!", player.ID)
	
end

-----------------------------------------------------------------------------------------------------

onSign = function(player, signType)
	
	local objFacing = getObjFacing(player)
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local moved = true
	local mob = getTargetFacing(player, BL_MOB)

	if (signType == 1) then--onLook
		
	elseif (signType == 2) then--onScriptedTile
		if mob ~= nil and mob.owner > 0 then
			mob:warp(player.m, player.x, player.y)
			mob:sendAnimation(248)
		end	
	elseif (signType == 3) then--onTurn

	end
end

-----------------------------------------------------------------------------------------------------

onCreation = function(player)
	
	player:sendAnimation(246)
	player:sendMinitext("Wrong recipes!")
	
end
	
-----------------------------------------------------------------------------------------------------
	
onCantCast = function(player)
		
	player:popUp("can't cast")
end

-----------------------------------------------------------------------------------------------------

onNoAfkMap = function(player)	-- If you  AFK in map that data for mapAFK in table is 1, this function will run.
		
end

-----------------------------------------------------------------------------------------------------

onScreenShot = function(player)
	
	if player.registry["screenshot"] < os.time() then
	return else
		anim(player)
		player:sendMinitext("Wait for "..player.registry["screenshot"]-os.time().." sec to take ScreenShot.")
	end
end

-----------------------------------------------------------------------------------------------------

onPaperSave = function(player)

	player:sendMinitext("Paper text failed to save.")
end

-----------------------------------------------------------------------------------------------------

onTimerEnd = function(player)	-- When timer is end.. 


end

-----------------------------------------------------------------------------------------------------
	
onGroupXP = function(player)	-- plan to add mentor sistem, if you mentor someone and hunting with him together, they will get +bonus exp.. and your mentor xp gained. cool

end	

-----------------------------------------------------------------------------------------------------

onViewBoard = function(player)	-- when someone is reading board.. action boring.. E
	
	player:sendAction(15, 40)

end

-----------------------------------------------------------------------------------------------------

onUpdateBoard = function(player)
	
	local pc = player:getUsers()
	
	if player.gmLevel > 0 then 
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].gmLevel > 0 then
					pc[i]:msg(4, "+++ Board Update +++", pc[i].ID)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------
