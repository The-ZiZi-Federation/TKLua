-- base level taunt
provoke = {
	on_learn = function(player)
		player.registry["learned_provoke"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_provoke"] = 0
	end,
	cast = function(player)
		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local map = player.m
		local targets = {}
		local threat = 1000000
		local damage = 0
		local distance = 3
		local aether = 5000
		local magicCost = (player.maxMagic / 22.3) + (player.level * 15)
		local sound = 95
		local anim = 361
		local maps = {1000, 1001, 1002, 1003, 2000, 3000, 4000}

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		for i = 1, #maps do
			if map == maps[i] then
				player:sendMinitext("You can not use that here.")
				return
			end
		end

		player:sendAction(6, 20)
		player:setAether("provoke", aether)
		player:playSound(sound)
		player:sendAnimation(anim)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You Provoked the Enemies.")

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distanceSquare(player, mobBlocks[i], distance)) then
					if mobBlocks[i].ID ~= player.ID then
						table.insert(targets, mobBlocks[i])
					end
				end
			end
		end

		if (#targets > 0) then
			for i = 1, #targets do
				player:addThreat(targets[i].ID, threat)
				targets[i]:sendAnimation(246)
				targets[i].attacker = player.ID
				targets[i]:removeHealthWithoutDamageNumbers(damage, 0)
			end
		end
	end,
	requirements = function(player)
		local level = 35
		local item = {0, 293, 388}
		local amounts = {6000, 1, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Provoke is a spell to get the attention of nearby enemies.", txt}
		return level, item, amounts, desc
	end
}
