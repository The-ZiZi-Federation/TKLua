-------------------------------------------------------
--   Spell: Confident Pose
--   Class: Mercenary
--   Level: 110
--  Aether: 0 Seconds
--    Cost: player.maxMagic * 0.1
-- DmgType: N/A
--    Type: Buff
-- Targets: Self
-------------------------------------------------------
--    Desc: Boost your accuracy and damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
confident_pose = {
	on_learn = function(player)
		player.registry["learned_confident_pose"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_confident_pose"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local duration = 600000
		local anim = 167
		local sound = 162

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if player:hasDuration("confident_pose") then
			alreadyCast(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("confident_pose", duration)
		player:calcStat()
		player:sendMinitext("You cast Confident Pose")
	end,
	recast = function(player)
		player.hit = player.hit + 5
		player.dam = player.dam + 5
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your armor bonus fades")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A spell that increases your Accuracy and Damage.", txt}
		return level, item, amounts, desc
	end
}
