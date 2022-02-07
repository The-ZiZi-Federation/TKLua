--level 12 Armadillo's Endurance - 35%
--level 42 Tiger's Endurance - 42%
--level 71 Bear's Endurance - 49%
--level 104 Rhino's Endurance - 56%

tigers_endurance = {
	on_learn = function(player)
		player.registry["learned_tigers_endurance"] = 1
		player:removeSpell("armadillos_endurance")
		player:removeSpell("bears_endurance")
		player:removeSpell("rhinos_endurance")
	end,
	on_forget = function(player)
		player.registry["learned_tigers_endurance"] = 0
	end,
	cast = function(player, target)
		local magicCost = player.maxMagic / 10
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
		if player:hasDuration("tigers_endurance") then
			alreadyCast(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:setAether("tigers_endurance", aether)
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("tigers_endurance", duration)
		player:calcStat()
		player:sendMinitext("You cast Tiger's Endurance")
	end,
	recast = function(player)
		player.deduction = 0.58
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your endurance returns to normal")
	end,
	requirements = function(player)
		local level = 42
		local item = {0, 51}
		local amounts = {20000, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Invoke the spirit of the Tiger to greatly increase your endurance for a short time.\n\nReplaces Armadillo's Endurance.",
			txt
		}
		return level, item, amounts, desc
	end
}
