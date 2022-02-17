-------------------------------------------------------
--   Spell: Resist Ailment
--   Class: Assassin
--   Level: 125
--  Aether: 60s
--    Cost: 15000
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Removes negative effectts
-------------------------------------------------------
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
resist_ailment = {
	on_learn = function(player)
		player.registry["learned_resist_ailment"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_resist_ailment"] = 0
	end,
	cast = function(player)
		local magicCost = 500
		local aether = 5000
		local anim = 136
		local sound = 37

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAnimation(anim)
		player:flushDuration(607, 613)
		player:flushDuration(11501, 11524)
		player:calcStat()
		player:sendMinitext("You cast Resist Ailment")

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:setAether("resist_ailment", aether)
		player:sendStatus()
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Resist Ailment is a spell that will remove negative effects from yourself.", txt}
		return level, item, amounts, desc
	end
}
