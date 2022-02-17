posiefins_net = {
	on_swing = function(player)
		local mob = getTargetFacing(player, BL_MOB)

		if not player:canAction(1, 1, 1) then
			return
		else
			if player:hasDuration("posiefins_net") then
				return
			else
				if mob ~= nil then
					if mob:hasDuration("posiefins_net") then -- if mob has duration
						anim(player)
						player:sendMinitext("That creature is busy.")
						return
					else
						if divine_holder.checkInv(player) == false then
							anim(player)
							player:sendMinitext("You have no where to store this creature.") -- if catcher don't have that diviner holder..
							return
						else
							if mob.aiType ~= 0 then
								anim(player)
								player:sendMinitext("") -- if mob is a boss, or BOT, etc..
								return
							else
								if mob.owner == 0 then
									minHealth = mob.maxHealth * .5
									--		if mob.health >= minHealth then
									--			anim(player)
									--			player:sendMinitext("You can't do that right now")
									--		return else
									player:lock()
									mob:sendAnimation(141, 7)
									player:playSound(85)
									player:sendAction(27, 20)
									player:setDuration("posiefins_net", 6000)
									mob.paralyzed = true
									mob:setDuration("posiefins_net", 6000, player.ID)
								--		end
								end
							end
						end
					end
				end
			end
		end
	end,
	while_cast = function(block, caster)
		local mob

		if block.blType == BL_MOB then
			block.paralyzed = true
		elseif block.blType == BL_PC then
			if divine_holder.checkInv(player) == false then -- divine
				block:setDuration("posiefins_net", 0)
				return
			else
				mob = getTargetFacing(block, BL_MOB)
				if mob ~= nil then
					id = mob:getCasterID("posiefins_net")
					if block.ID == id then -- don't lock player character if mob is not there.
						block:lock()
						block:sendAnimation(33)
					end
				end
			end
		end
	end,
	uncast = function(block)
		local chance = math.random(0, 10)
		local mob

		if block.blType == BL_MOB then
			block.paralyzed = false
		elseif block.blType == BL_PC then
			mob = getTargetFacing(block, BL_MOB)
			block:unlock()
			block:sendAction(28, 20)
			if divine_holder.checkInv(block) == true then
				if mob ~= nil then
					if mob.aiType == 0 and mob.owner == 0 then
						divine_holder.catch(block, mob)
					end
				end
			end
		end
		block:calcStat()
	end
}

divine_holder = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local reg = player.registry["summoned_pet"]
		local mobID = item.timeLeft

		if mobID > 0 then
			if reg > 0 then
				if Mob(reg) ~= nil then
					Mob(reg):removeHealth(Mob(reg).health)
				end
				player:sendAction(6, 20)
				player.registry["summoned_pet"] = 0
				return
			else
				core:spawn(mobID, player.x, player.y, 1, player.m)
				mob = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
				if #mob > 0 then
					for i = 1, #mob do
						if mob[i].mobID == mobID then
							if mob[i].owner == 0 then
								mob[i].owner = player.ID
								player.registry["summoned_pet"] = mob[i].ID
								return
							end
						end
					end
				end
			end
		end
	end,
	checkInv = function(player)
		local val = false

		for i = 0, player.maxInv do
			item = player:getInventoryItem(i)
			if item ~= nil then
				if item.yname == "divine_holder" then
					if item.realName == "" and item.timeLeft == 0 then
						val = true
					end
				end
			end
		end

		return val
	end,
	catch = function(player, target)
		if divine_holder.checkInv(player) == true then
			for i = 0, player.maxInv do
				item = player:getInventoryItem(i)
				if item ~= nil then
					if item.yname == "divine_holder" then
						if item.realName == "" and item.timeLeft == 0 then
							item.timeLeft = target.mobID
							item.realName = "Cage for " .. target.name
							player:updateInv()
							player:playSound(123)
							target:removeHealth(target.health)
							break
						end
					end
				end
			end
		end
	end
}
