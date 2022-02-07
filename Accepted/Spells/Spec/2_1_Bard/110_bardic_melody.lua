-------------------------------------------------------
--   Spell: Bardic Melody
--   Class: Bard
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

bardic_melody = {
	on_learn = function(player)
		player.registry["learned_bardic_melody"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_bardic_melody"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local duration = 600000
		local anim = 379
		local sound = 731
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
		player:sendMinitext("You cast Bardic Melody.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember:hasDuration("bardic_melody") then
						partyMember:setDuration("bardic_melody", 0)
					end
					if partyMember.health <= 0 then
						return
					else
						partyMember:sendAnimation(anim)
						partyMember:setDuration("bardic_melody", duration)
						partyMember:calcStat()
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Bardic Melody on you")
						end
					end
				end
			end
		end
	end,
	recast = function(player)
		player.deduction = 0.95
		player.hit = player.hit + 3
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("The Bardic Melody fades away")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Bardic Melody is a spell that protects your party and increases accuracy!", txt}
		return level, item, amounts, desc
	end
}
