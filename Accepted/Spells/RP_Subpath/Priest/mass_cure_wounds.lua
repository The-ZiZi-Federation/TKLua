-------------------------------------------------------
--   Spell: Mass Cure Wounds
--   Class: All
--   Level: 38
--  Aether: 16 Second
--    Cost: (player.level * 25) + player.maxMagic / 10
-- DmgType: N/A
--    Type: Heal
-- Targets: Group
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: Group heal, variable amount
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
mass_cure_wounds = {
	on_learn = function(player)
		player.registry["learned_mass_cure_wounds"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_mass_cure_wounds"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 25) + (player.maxMagic / 10)
		local aether = 16000
		local healAmount = (player.level * 50) + (player.maxHealth / 10)

		local anim1 = 5
		local sound = 708
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
		player:setAether("mass_cure_wounds", aether)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:sendMinitext("You cast Mass Cure Wounds.  You heal your target for " .. healAmount .. " Vita.")
		--	player:sendMinitext("Heal Base (2200 + (5 * Level)) "..healBase)
		--	player:sendMinitext("Heal Bonus (Will based) "..healBonus)
		--	player:sendMinitext("Total Heal: "..totalHeal)
		--	player:sendMinitext("Magic Cost "..magicCost)
		--	player:sendMinitext("Aether "..aether)

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
							partyMember:sendMinitext(player.name .. " cast Mass Cure Wounds on you")
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 38
		local item = {0, 6033}
		local amounts = {650, 12}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Mass Cure Wounds is a spell that heals your entire party!", txt}
		return level, item, amounts, desc
	end
}
