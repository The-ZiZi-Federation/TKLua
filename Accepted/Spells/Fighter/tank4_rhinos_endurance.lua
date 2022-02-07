--level 12 Armadillo's Endurance - 35%
--level 42 Tiger's Endurance - 42%
--level 71 Bear's Endurance - 49%
--level 104 Rhino's Endurance - 56%

rhinos_endurance = {
	on_learn = function(player)
		player.registry["learned_rhinos_endurance"] = 1
		player:removeSpell("bears_endurance")
		player:removeSpell("armadillos_endurance")
		player:removeSpell("tigers_endurance")
	end,
	on_forget = function(player)
		player.registry["learned_rhinos_endurance"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.maxMagic / 15)
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
		if player:hasDuration("rhinos_endurance") then
			alreadyCast(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:setAether("rhinos_endurance", aether)
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("rhinos_endurance", duration)
		player:calcStat()
		player:sendMinitext("You cast Rhino's Endurance")
	end,
	recast = function(player)
		player.deduction = 0.44
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your endurance returns to normal")
	end,
	requirements = function(player)
		local level = 104
		local item = {0, 51, 424}
		local amounts = {200000, 4, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Invoke the spirit of the Rhino to vastly increase your endurance for a short time.\n\nReplaces Bear's Endurance.",
			txt
		}
		return level, item, amounts, desc
	end
}
