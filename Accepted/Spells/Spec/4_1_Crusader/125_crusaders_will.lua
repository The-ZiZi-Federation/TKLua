-------------------------------------------------------
--   Spell: Crusader's Will
--   Class: Crusader
--   Level: 110
--  Aether: 10 Second
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

crusaders_will = {
	on_learn = function(player)
		player.registry["learned_crusaders_will"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_crusaders_will"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local duration = 600000
		local anim = 18
		local sound = 370
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
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:sendMinitext("You cast Crusader's Will.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember.health <= 0 then
						return
					else
						partyMember:sendAnimation(anim)
						partyMember:setDuration("crusaders_will", duration)
						partyMember:calcStat()
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Crusader's Will on you")
						end
					end
				end
			end
		end
	end,
	recast = function(player)
		player.dam = player.dam + 5
		player.hit = player.hit + 2
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Crusader's Will fades away")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Crusader's Will is a spell reinforces the party's damage and accuracy!", txt}
		return level, item, amounts, desc
	end
}
