-------------------------------------------------------
--   Spell: Regeneration Wave
--   Class: Bishop
--   Level: 125
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

regeneration_wave = {
	on_learn = function(player)
		player.registry["learned_regeneration_wave"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_regeneration_wave"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor((player.level * 5) + 400)
		local duration = 3000
		local aether = 8000
		local anim = 288
		local sound = 725
		local healAmount = math.floor((player.will * 75) + 1000)
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
		player:sendMinitext("You cast Regeneration Wave.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember.health <= 0 then
						return
					else
						if partyMember:hasDuration("regeneration_wave") then
							partyMember:setDuration("regeneration_wave", 0)
						end
						partyMember:sendAnimation(anim)
						partyMember:setDuration("regeneration_wave", duration)
						partyMember.registry["regeneration_wave_caster"] = player.ID
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Regeneration Wave on you")
						end
					end
				end
			end
		end
	end,
	while_cast = function(player)
		local anim = 289
		local caster = Player(player.registry["regeneration_wave_caster"])
		local regenAmount = math.floor((caster.will * 25) + 200)

		player:sendAnimation(anim)
		player:addHealth(regenAmount)
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Regeneration Wave is a spell increases the effectiveness of healing spells!", txt}
		return level, item, amounts, desc
	end
}
