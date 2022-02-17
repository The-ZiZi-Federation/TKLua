-------------------------------------------------------
--   Spell: Lesser Restoration
--   Class: Priest
--   Level: 99
--  Aether: 12 Second
--    Cost: (player.level / 2 ) + 350
-- DmgType: N/A
--    Type: Heal
-- Targets: Single Target
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: Target Heal, aethered
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 12/01/2016
-------------------------------------------------------
--cure wounds- single target heal level 99
lesser_restoration = {
	on_learn = function(player)
		player.registry["learned_lesser_restoration"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_lesser_restoration"] = 0
	end,
	cast = function(player, target)
		local magicCost = math.floor((player.magic * 0.333))
		local aether = 12000
		local healAmount = magicCost * 1.5

		local anim1 = 325
		local anim2 = 422
		local sound = 708

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if target.health == target.maxHealth then
					player:sendMinitext("Your target is at Max Vita!!")
					return
				end
				if target.health <= 0 or target.state == 1 then
					player:sendMinitext("Your target is dead!")
					return
				end

				if target ~= nil then
					if target.state == 1 or player.health <= 0 then
						return
					else
						player:sendAction(6, 20)
						player.magic = player.magic - magicCost
						player:calcStat()
						player:sendStatus()
						player:sendMinitext("You cast Lesser Restoration.  You heal your target for " .. healAmount .. " Vita.")
						player:playSound(sound)
						target:sendAnimation(anim1)
						target:sendAnimation(anim2)
						addHealth(target, healAmount)
						player:setAether("lesser_restoration", aether)
						if target.blType == BL_PC and target.ID ~= player.ID then
							target:sendMinitext(
								player.name .. " cast Lesser Restoration on you.  You are healed for " .. healAmount .. " Vita."
							)
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 99
		local item = {0, 394, 3034}
		local amounts = {100000, 1, 25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Lesser Restoration is a spell to heal a large amount of someone's health!", txt}
		return level, item, amounts, desc
	end
}
