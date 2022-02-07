-- aoe para Lv1
static = {
	on_learn = function(player)
		player.registry["learned_static"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_static"] = 0
	end,
	cast = function(player)
		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)
		local aether = 10000
		local targets = {}
		local damage = 1
		local threat
		local magicCost = player.maxMagic * 0.02
		local duration = 8000
		local sound = 41

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		player:sendAction(1, 20)
		player:setAether("static", aether)
		player:playSound(sound)
		player:sendMinitext("You cast Static.")

		for i = 1, #mobBlocks do
			if (distanceSquare(player, mobBlocks[i], 1) and mobBlocks[i].ID ~= player.ID) then
				table.insert(targets, mobBlocks[i])
			end
		end

		for i = 1, #pcBlocks do
			if (distanceSquare(player, pcBlocks[i], 1) and pcBlocks[i].ID ~= player.ID) then
				table.insert(targets, pcBlocks[i])
			end
		end

		if (#targets > 0) then
			player.magic = player.magic - magicCost
			player:sendStatus()

			for i = 1, #targets do
				if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
					if checkResist(player, targets[i], "static") == 1 then
						return
					end
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
					player:addThreat(targets[i].ID, threat)
					targets[i]:removeHealthWithoutDamageNumbers(damage, 1)
					targets[i].attacker = player.ID
					targets[i].paralyzed = true
					targets[i]:sendAnimation(27)
					targets[i]:setDuration("static", duration)
				else
					targets[i]:sendAnimation(246)
					player:sendMinitext("Spell failed!")
				end
			end
		end
	end,
	while_cast = function(block)
		local anim = 27

		block:sendAnimation(anim)
		block.paralyzed = true
	end,
	uncast = function(mob)
		mob.paralyzed = false
	end,
	requirements = function(player)
		local level = 12
		local item = {0, 53}
		local amounts = {500, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Static is a spell that can paralyze surrounding enemies temporarily!", txt}
		return level, item, amounts, desc
	end
}
