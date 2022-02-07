-------------------------------------------------------
--   Spell: Savage Instincts
--   Class: Fallen
--   Level: 125
--  Aether: 0 Second
--    Cost: player.maxMagic * 0.1
-- DmgType: N/A
--    Type: buff
-- Targets: Group
-- Effects: raise hit and dam
-------------------------------------------------------
--    Desc: Group buff
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 8/20/2017
-------------------------------------------------------

savage_instincts = {
	on_learn = function(player)
		player.registry["learned_savage_instincts"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_savage_instincts"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local duration = 600000
		local anim = 167
		local sound = 704
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
		player:sendMinitext("You cast Savage Instincts.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember.health <= 0 then
						return
					else
						if partyMember:hasDuration("savage_instincts") then
							partyMember:setDuration("savage_instincts", 0)
						end
						partyMember:sendAnimation(anim)
						partyMember:setDuration("savage_instincts", duration)
						partyMember:calcStat()
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Savage Instincts on you")
						end
					end
				end
			end
		end
	end,
	recast = function(player)
		player.hit = player.hit + 10
		player.hit = player.dam + 10
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("The Savage Instincts fades away")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Savage Instincts is a spell for your party and increases hit and dam!", txt}
		return level, item, amounts, desc
	end
}
