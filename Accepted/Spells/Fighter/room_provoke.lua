-- base level taunt
room_provoke = {
	on_learn = function(player)
		player.registry["learned_room_provoke"] = 1
		player:removeSpell("provoke")
	end,
	on_forget = function(player)
		player.registry["learned_room_provoke"] = 0
	end,
	cast = function(player)
		local mobBlocks = player:getObjectsInMap(player.m, BL_MOB)
		local map = player.m
		local targets = {}
		local threat = 1000000
		local damage = 0
		local aether = 15000
		local magicCost = 2000
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
		player:setAether("room_provoke", aether)
		player:playSound(sound)
		player:sendAnimation(anim)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You Provoked the Enemies.")

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if mobBlocks[i].ID ~= player.ID then
					table.insert(targets, mobBlocks[i])
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
		local level = 99
		local item = {0, 394}
		local amounts = {75000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Room Provoke puts the attention of an entire room directly on you.", txt}
		return level, item, amounts, desc
	end
}
