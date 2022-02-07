gift_of_life = {
	cast = function(player, target)
		local magicCost = 10000
		local hp = target.maxHealth * .25
		local aether = 600000
		local anim = 251
		local sound = 70

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
						target:sendAnimation(anim)
						player:playSound(sound)
						player:setAether("gift_of_life", aether)
						player:sendMinitext("You cast Gift of Life on " .. target.name)
						target:sendMinitext(player.name .. " Raises you from the dead!")
					else
						player:sendMinitext("Invalid Target!")
					end
				end
			end
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

		local desc = {"Gift of Life is a spell to revive an ally from death!", txt}
		return level, item, amounts, desc
	end
}
