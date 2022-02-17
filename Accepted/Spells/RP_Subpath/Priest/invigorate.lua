invigorate = {
	on_learn = function(player)
		player.registry["learned_invigorate"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_invigorate"] = 0
	end,
	cast = function(player, target)
		local magicDiff = target.maxMagic - target.magic
		local magicCost = 0
		local magicRestore = 0
		local aether = 12000

		if magicDiff > player.magic then
			magicCost = player.magic
		else
			magicCost = magicDiff
		end

		magicRestore = magicCost

		if target.ID == player.ID then
			player:sendMinitext("You can't invigorate yourself!")
			return
		end

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if target ~= nil then
					if target.state == 1 then
						invalidTarget(player)
						return
					else
						player:sendAction(6, 20)
						player.magic = player.magic - magicCost
						player:calcStat()
						player:sendStatus()
						player:sendMinitext("You cast Invigorate")
						player:playSound(22)
						player:setAether("invigorate", aether)
						target:sendAnimation(322)
						--target:sendAnimation(403)
						--target:sendAnimation(422)
						target.magic = target.magic + magicRestore
						target:calcStat()
						target:sendStatus()
						if target.blType == BL_PC and target.ID ~= player.ID then
							target:sendMinitext(player.name .. " cast Invigorate on you")
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 24
		local item = {0, 50, 6001}
		local amounts = {500, 30, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Invigorate is a spell to restore someone's mana at the cost of your own!", txt}
		return level, item, amounts, desc
	end
}
