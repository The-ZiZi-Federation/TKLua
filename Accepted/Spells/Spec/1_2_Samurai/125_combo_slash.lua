combo_slash = {
	on_learn = function(player)
		player.registry["learned_combo_slash"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_combo_slash"] = 0
	end,
	cast = function(player)
		local aether = 17000
		local duration = 3000
		local soune = 501
		local magicCost = (player.level * 50) + (player.maxMagic / 25)
		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)
		local targets = {}

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (player.state == 1) then
			player:sendMinitext("That is no longer useful.")
			return
		end

		--	player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("combo_slash", aether)
		player:playSound(sound)
		player:sendMinitext("You cast Combo Slash.")
		player:setDuration("combo_slash", duration)
	end,
	while_cast = function(player)
		local damage
		local mob_around = player:getObjectsInArea(BL_MOB)
		local pc_around = player:getObjectsInArea(BL_PC)

		player:sendAction(1, 20)

		if #mob_around > 0 then
			for i = 1, #mob_around do
				if mob_around[i] ~= nil then
					if distanceSquare(player, mob_around[i], 1) then
						player.critChance = 1
						damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob_around[i], 2)) * 20
						combo_slash.takeDamage(player, mob_around[i], damage)
					end
				end
			end
		end

		if #pc_around > 0 then
			for i = 1, #pc_around do
				if distanceSquare(player, pc_around[i], 1) then
					if pc_around[i].ID ~= player.ID then
						if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
							player.critChance = 1
							damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pc_around[i], 2)) * 20
							combo_slash.takeDamage(player, pc_around[i], damage)
						end
					end
				end
			end
		end
	end,
	takeDamage = function(player, target, damage)
		local anim1 = 31
		local anim2 = 60
		local sound = 501
		local threat

		target.attacker = player.ID
		if target.blType == BL_MOB then
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
		end
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		target:playSound(sound)
		target:sendAnimation(anim1)
		target:sendAnimation(anim2)
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Combo Slash is a continous attack on those around you.", txt}
		return level, item, amounts, desc
	end
}
