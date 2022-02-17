-------------------------------------------------------
--   Spell: Cure Mortal Wounds
--   Class: Priest
--   Level: 200
--  Aether: 1 Second
--    Cost: (player.level * 17) + 2500
-- DmgType: N/A
--    Type: Heal
-- Targets: Single Target
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: target heal
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/08/2017
-------------------------------------------------------
cure_mortal_wounds = {
	on_learn = function(player)
		player.registry["learned_cure_mortal_wounds"] = 1
		player:removeSpell("cure_minor_wounds")
		player:removeSpell("cure_light_wounds")
		player:removeSpell("cure_moderate_wounds")
		player:removeSpell("cure_serious_wounds")
		player:removeSpell("cure_critical_wounds")
		player:removeSpell("cure_major_wounds")
		player:removeSpell("cure_severe_wounds")
		player:removeSpell("cure_vital_wounds")
		player:removeSpell("cure_terminal_wounds")
	end,
	on_forget = function(player)
		player.registry["learned_cure_mortal_wounds"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.level * 17) + 2500
		local healAmount = (player.will * 275) + 10000

		local anim1 = 325
		local anim2 = 422
		local sound = 708

		if magicCost > 6400 then
			magicCost = 6400
		end
		if healAmount > 111000 then
			healAmount = 111000
		end

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
						player:sendMinitext("You cast Cure Mortal Wounds.  You heal your target for " .. healAmount .. " Vita.")
						player:playSound(sound)
						target:sendAnimation(anim1)
						target:sendAnimation(anim2)
						addHealth(target, healAmount)
						if target.blType == BL_PC and target.ID ~= player.ID then
							target:sendMinitext(
								player.name .. " cast Cure Mortal Wounds on you.  You are healed for " .. healAmount .. " Vita."
							)
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 200
		local item = {0}
		local amounts = {400000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Cure Mortal Wounds is a spell to heal a large amount of someone's health!", txt}
		return level, item, amounts, desc
	end
}
