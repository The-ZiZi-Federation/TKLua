-------------------------------------------------------
--   Spell: Lay on Hands Lv2
--   Class: Paladin
--   Level: 125
--  Aether: 1 Second
--    Cost: 1000 MP
-- DmgType: N/A
--    Type: Heal
-- Targets: Single Target
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc:
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
--cure wounds- single target high heal level 110
lay_on_hands_lv2 = {
	on_learn = function(player)
		player.registry["learned_lay_on_hands_lv2"] = 1
		player:removeSpell("lay_on_hands")
	end,
	on_forget = function(player)
		player.registry["learned_lay_on_hands_lv2"] = 0
	end,
	cast = function(player, target)
		local magicCost = math.floor((player.level / 2) + 1000)
		local healAmount = math.floor((player.will * 135) + (player.grace * 135) + 1000)

		local anim1 = 63
		--local anim2 = 422
		local sound = 19

		if magicCost > 1100 then
			magicCost = 1100
		end
		if healAmount > 11000 then
			healAmount = 11000
		end

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if target.health == target.maxHealth then
					player:sendMinitext("Your target is at Max Vita!")
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
						player:sendMinitext("You cast Lay on Hands Lv2 You heal your target for " .. healAmount .. " Vita.")
						player:playSound(sound)
						target:sendAnimation(anim1)
						--target:sendAnimation(anim2)
						addHealth(target, healAmount)
						if target.blType == BL_PC and target.ID ~= player.ID then
							target:sendMinitext(
								player.name .. " cast Lay on Hands Lv2 on you.  You are healed for " .. healAmount .. " Vita."
							)
						end
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

		local desc = {"Lay on Hands Lv2 is an improved version of your Lay on Hands spell.", txt}
		return level, item, amounts, desc
	end
}
