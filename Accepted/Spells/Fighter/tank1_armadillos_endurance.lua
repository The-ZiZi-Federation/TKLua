--level 12 Armadillo's Endurance - 35%
--level 42 Tiger's Endurance - 42%
--level 71 Bear's Endurance - 49%
--level 104 Rhino's Endurance - 56%

armadillos_endurance = {
	on_learn = function(player)
		player.registry["learned_armadillos_endurance"] = 1
		player:removeSpell("tigers_endurance")
		player:removeSpell("bears_endurance")
		player:removeSpell("rhinos_endurance")
	end,
	on_forget = function(player)
		player.registry["learned_armadillos_endurance"] = 0
	end,
	cast = function(player, target)
		local magicCost = 250
		local duration = 10000
		local aether = 120000
		local anim = 87
		local sound = 32

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if player:hasDuration("armadillos_endurance") then
			alreadyCast(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:setAether("armadillos_endurance", aether)
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("armadillos_endurance", duration)
		player:calcStat()
		player:sendMinitext("You cast Armadillo's Endurance")
	end,
	recast = function(player)
		player.deduction = 0.65
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your endurance returns to normal")
	end,
	requirements = function(player)
		local level = 12
		local item = {0, 51}
		local amounts = {5000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Invoke the spirit of the Armadillo to increase your endurance for a short time.", txt}
		return level, item, amounts, desc
	end
}
