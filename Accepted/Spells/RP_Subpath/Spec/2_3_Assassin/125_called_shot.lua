called_shot = {
	on_learn = function(player)
		player.registry["learned_called_shot"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_called_shot"] = 0
	end,
	cast = function(player, target)
		local aether = 30000
		local duration = 10000
		local threat
		local magicCost = math.floor(player.maxMagic * 0.25)
		local anim = 177
		local sound = 58

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.state == 1) then
			player:sendMinitext("That is no longer useful.")
			return
		end

		if (target.blType == BL_MOB) then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setAether("called_shot", aether)
			player:playSound(sound)
			target:sendAnimation(anim)
			player:sendMinitext("You cast Called Shot")
			target:setDuration("called_shot", duration)
			target.attacker = player.ID
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setAether("called_shot", aether)
			player:playSound(sound)
			target:sendAnimation(anim)
			player:sendMinitext("You cast Called Shot")
			target:setDuration("called_shot", duration)
			target.attacker = player.ID
			target:sendMinitext(player.name .. " calls a shot on you!")
		end
	end,
	on_takedamage_while_cast = function(player)
		if player:hasDuration("called_shot") then
			player:setDuration("called_shot", 0)
		end
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Call out a target to double the next damage they take!", txt}
		return level, item, amounts, desc
	end
}
