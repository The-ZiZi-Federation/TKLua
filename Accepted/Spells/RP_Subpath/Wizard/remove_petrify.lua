remove_petrify = {
	on_learn = function(player)
		player.registry["learned_remove_petrify"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_remove_petrify"] = 0
	end,
	cast = function(player, target)
		local magicCost = 25
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target ~= nil then
			if target.blType ~= BL_MOB then
				anim(player)
				player:sendMinitext("Invalid target!")
				return
			else
				remove_petrify.casted(player, target, magicCost)
			end
		end
	end,
	casted = function(player, target, magicCost)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Remove Petrify")
		player:sendAction(6, 20)
		player:playSound(85)
		target:sendAnimation(10)
		if target:hasDuration("petrify") and target.paralyzed == true then
			target:setDuration("petrify", 0)
			target.paralyzed = false
		elseif target:hasDuration("greater_petrify") and target.paralyzed == true then
			target:setDuration("greater_petrify", 0)
			target.paralyzed = false
		elseif target:hasDuration("mass_petrify") and target.paralyzed == true then
			target:setDuration("mass_petrify", 0)
			target.paralyzed = false
		end
	end,
	requirements = function(player)
		local level = 32
		local item = {0, 389}
		local amounts = {5000, 25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Remove Pertify can remove the petrification you or others cause with the Petrify spell.", txt}
		return level, item, amounts, desc
	end
}
