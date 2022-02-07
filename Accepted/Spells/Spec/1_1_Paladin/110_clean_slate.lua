-------------------------------------------------------
--   Spell: Clean Slate
--   Class: Paladin
--   Level: 110
--  Aether: 5s
--    Cost: 500
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Removes negative effectts
-------------------------------------------------------
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
clean_slate = {
	on_learn = function(player)
		player.registry["learned_clean_slate"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_clean_slate"] = 0
	end,
	cast = function(player, target)
		local magicCost = 500
		local aether = 5000
		local anim = 62
		local sound = 10

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:setAether("clean_slate", aether)
		player:sendStatus()
		player:sendMinitext("You cast Clean Slate")

		target:sendAnimation(anim)
		target:flushDuration(607, 613)
		target:flushDuration(11501, 11524)
		target:calcStat()
		target:sendMinitext(player.name .. " has bestowed upon you a Clean Slate")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Clean Slate is a spell that will remove negative effects from another.", txt}
		return level, item, amounts, desc
	end
}
