retaliation = {
	on_learn = function(player)
		player.registry["learned_retaliation"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_retaliation"] = 0
	end,
	cast = function(player)
		local magicCost = player.maxMagic * 0.1
		local aether = 120000
		local duration = 10000
		local anim = 309
		local sound = 1

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if player:hasDuration("retaliation") then
			anim(player)
			player:sendMinitext("Spell already cast!")
			return
		else
			player:sendAction(18, 80)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setDuration("retaliation", duration)
			player:setAether("retaliation", aether)
			player:sendAnimation(anim)
			player:playSound(sound)
			player:sendMinitext("You cast Retaliation")
			player.registry["retaliation"] = 0
		end
	end,
	while_cast_250 = function(player)
		--	player:talk(0, ""..player.registry["retaliation"])
	end,
	on_takedamage_while_cast = function(player, mob)
		player.registry["retaliation"] = player.registry["retaliation"] + mob.damage
	end,
	uncast = function(player)
		local pcflankTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
		}

		local mobflankTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
		}

		local damageTaken = player.registry["retaliation"]
		local damage = damageTaken * 25
		local playerAnim = 149
		local hitAnim = 353
		--player:sendMinitext("Retaliation damage taken: "..damageTaken)

		for i = 1, 8 do
			if (pcflankTargets[i] ~= nil) then
				if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
					pcflankTargets[i]:sendAnimation(hitAnim)
					if (player:canPK(pcflankTargets[i])) then
						pcflankTargets[i].attacker = player.ID
						pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					end
				end
			end
		end

		for i = 1, 8 do
			if (mobflankTargets[i] ~= nil) then
				mobflankTargets[i].attacker = player.ID
				mobflankTargets[i]:sendAnimation(hitAnim)
				mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
		player.registry["retaliation"] = 0
		player:sendAction(18, 80)
		player:sendAnimation(playerAnim)
		player:sendMinitext("Your anger explodes!")
		player:calcStat()
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Retaliation stores the damage you receive and then unleashes it on your foes!", txt}
		return level, item, amounts, desc
	end
}

--[[
setduration "anger"

anger ontakedamagewhilecast

registry "getting_angry" +#damage

uncast
surrounding targets take damage = getting_angry
registry set to 0--]]
