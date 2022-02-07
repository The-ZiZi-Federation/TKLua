raise_dead = {
	cast = function(player, target)
		local magicCost = player.maxMagic / 4
		local hp = target.maxHealth * .03
		local aether = 60000

		if magicCost > 500000 then
			magicCost = 500000
		end

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if target.blType ~= BL_PC or target.ID == player.ID then
					player:sendMinitext("Invalid Target!")
					return
				else
					if target.state == 1 then
						player.magic = player.magic - magicCost
						player:sendStatus()
						player:sendAction(6, 20)
						target.state = 0
						target.health = hp
						target:sendStatus()
						target:updateState()
						target:sendAnimation(96)
						player:playSound(112)
						player:setAether("raise_dead", aether)
						player:sendMinitext("You cast Raise Dead on " .. target.name)
						target:sendMinitext(player.name .. " Raises you from the dead!")
					else
						player:sendMinitext("Invalid Target!")
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 29
		local item = {0, 388, 51}
		local amounts = {500, 25, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Raise Dead is a spell to revive an ally from death!", txt}
		return level, item, amounts, desc
	end
}
