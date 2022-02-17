-------------------------------------------------------
--   Spell: Song of Health Lv2
--   Class: Bard
--   Level: 125
--  Aether: 10 Second
--    Cost: player.maxMagic * 0.05
-- DmgType: N/A
--    Type: Heal
-- Targets: Group
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: Group heal
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 8/20/2017
-------------------------------------------------------

song_of_health_lv2 = {
	on_learn = function(player)
		player.registry["learned_song_of_health_lv2"] = 1
		player:removeSpell("song_of_health")
	end,
	on_forget = function(player)
		player.registry["learned_song_of_health_lv2"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.06)
		local aether = 10000
		local healAmount = 35000
		local anim1 = 631
		local sound = 115
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
		player:setAether("song_of_health_lv2", aether)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:sendMinitext("You cast Song of Health Lv2.")

		for i = 1, #player.group do
			partyMember = Player(player.group[i])
			if (partyMember.state ~= 1 and partyMember.m == player.m) then
				if distanceSquare(player, partyMember, 8) then
					if partyMember.health <= 0 then
						return
					else
						partyMember:sendAnimation(anim1)
						addHealth(partyMember, healAmount)
						if partyMember.blType == BL_PC and partyMember.ID ~= player.ID then
							partyMember:sendMinitext(player.name .. " cast Song of Health Lv2 on you")
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

		local desc = {"Song of Health Lv2 upgrades Song of Health.", txt}
		return level, item, amounts, desc
	end
}
