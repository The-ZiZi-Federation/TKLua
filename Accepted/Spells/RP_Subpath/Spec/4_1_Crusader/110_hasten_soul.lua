hasten_soul = {
	on_learn = function(player)
		player.registry["hasten_soul"] = 1
	end,
	on_forget = function(player)
		player.registry["hasten_soul"] = 0
	end,
	cast = function(player, target)
		local aether = 60000
		local duration = 15000
		local magicCost = 5000
		local anim = 429
		local sound = 26

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Hasten Soul")
		player:playSound(sound)
		player:setAether("hasten_soul", aether)

		target:setDuration("hasten_soul", duration)
		target:calcStat()
		--	player:refresh()
		target:sendAnimation(anim)
	end,
	recast = function(player)
		player.speed = 70
		player.dam = player.dam + 5
	end,
	uncast = function(player)
		player.speed = 80
		player:sendStatus()
		player:calcStat()
		player:refresh()
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hasten Soul will increase your target's movement speed for a short time.", txt}
		return level, item, amounts, desc
	end
}
