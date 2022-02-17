hide_in_shadows = {
	on_learn = function(player)
		player.registry["learned_hide_in_shadows"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_hide_in_shadows"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 10) + (player.maxMagic / 30)
		local duration = 30000
		local aether = 120000
		local mob = player:getObjectsInArea(BL_MOB)

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:setDuration("hide_in_shadows", duration)
				player:setAether("hide_in_shadows", aether)
				player:sendAction(6, 20)
				player:playSound(2)
				player:sendMinitext("You cast Hide in Shadows")
				player:sendAnimation(16)
				player.state = 2
				player:updateState()
			end
		end
	end,
	on_swing_while_cast = function(player)
		player:setDuration("hide_in_shadows", 0)
		if player.state == 2 then
			player.state = 0
			player:updateState()
		end
	end,
	on_takedamage_while_cast = function(player)
		player:setDuration("hide_in_shadows", 0)
		if player.state == 2 then
			player.state = 0
			player:updateState()
		end
	end,
	uncast = function(block)
		if block.health >= 1 then
			block.state = 0
			block:updateState()
		end
		block:sendMinitext("You are no longer Hiding in Shadows")
	end,
	requirements = function(player)
		local level = 33
		local item = {0, 388, 51}
		local amounts = {5500, 50, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hide in Shadows is a spell that allows you to hide from sight unnoticed.", txt}
		return level, item, amounts, desc
	end
}
