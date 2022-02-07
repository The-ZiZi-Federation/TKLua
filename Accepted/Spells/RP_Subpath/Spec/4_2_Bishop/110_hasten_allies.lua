-------------------------------------------------------
--   Spell: Hasten Allies
--   Class: Bishop
--   Level: 110
--  Aether: 5 min
--    Cost: player.maxMagic * 0.1
-- DmgType: N/A
--    Type: buff
-- Targets: Group
-- Effects: raise armor and hit
-------------------------------------------------------
--    Desc: Group buff
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 8/20/2017
-------------------------------------------------------

hasten_allies = {
	on_learn = function(player)
		player.registry["learned_hasten_allies"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_hasten_allies"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local duration = 20000
		local aether = 60000
		local anim = 476
		local sound = 37
		local partyMember

		if (not player:canCast(1, 1, 0)) then
			return
		end
		---------------------------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		---------------------------------------------------
		player.magic = player.magic - magicCost
		player:setAether("hasten_allies", aether)
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:sendMinitext("You cast Hasten Allies.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember.health <= 0 then
						return
					else
						partyMember:sendAnimation(anim)
						partyMember:setDuration("hasten_allies", duration)
						partyMember:calcStat()
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Hasten Allies on you")
						end
					end
				end
			end
		end
	end,
	recast = function(player)
		player.speed = 65
		player.dam = player.dam + 5
	end,
	uncast = function(player)
		player:calcStat()
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hasten Allies is a spell that boosts party move speed and damage.", txt}
		return level, item, amounts, desc
	end
}
