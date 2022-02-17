swiftness = {
	on_learn = function(player)
		player.registry["swiftness"] = 1
	end,
	on_forget = function(player)
		player.registry["swiftness"] = 0
	end,
	cast = function(player)
		local magicCost = 5000
		local anim = 116
		local sound = 20
		local aether = 60000
		local duration = 15000

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
		player:sendMinitext("You cast Swiftness")
		player:playSound(sound)
		player:setDuration("swiftness", duration)
		player:setAether("swiftness", aether)
		player:calcStat()
		player:refresh()
		player:sendAnimation(anim)
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

		local desc = {"Swiftness will increase your movement speed for a short time.", txt}
		return level, item, amounts, desc
	end
}
