-------------------------------------------------------
--   Spell: Club Strike
--   Class: Priest
--   Level: 9
--  Aether: 5 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: A heavy strike against a single foe.
--          Damage based more on Might than Will
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 10/26/2016
-------------------------------------------------------

club_strike = {
	on_learn = function(player)
		player.registry["learned_club_strike"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_club_strike"] = 0
	end,
	cast = function(player)
		------------------------
		--Varable Declarations--
		------------------------
		local might = player.might
		local will = player.will
		local buff = player.fury
		local magicCost = (player.level * 10) + (player.maxMagic / 35)
		local aether = 5000
		local damage

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat

		----------------------------
		-- Check if Castable--------
		----------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		----------------------------
		-- Check if MP available----
		----------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		----------------------------
		-- Apply Damage ------------
		----------------------------
		-- Target is an enemy
		if mobTarget ~= nil then
			-- Target is a player
			player.critChance = 1
			damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 4
			mobTarget.attacker = player.ID -- Set attacker ID
			player.magic = player.magic - magicCost -- Apply Mana Cost
			-------------------
			-- Agro -----------
			-------------------

			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2) -- Derive agro from damage
			player:addThreat(mobTarget.ID, threat)
			-- Apply agro
			-------------------------------------
			-- Action, Animation, Text, Sound ---
			-------------------------------------
			player:sendAction(1, 20) -- Swing action, 20 seconds long
			player:talk(2, "Smash!") -- Player says out loud on screen "SMASH!!"
			player:sendMinitext("You cast Club Strike.") -- Update message box
			player:playSound(14) -- Play sound
			----------------------------------------------------
			player:setAether("club_strike", aether) -- Set spell aethers (5 seconds)
			player:sendStatus()
			----------------------------------------------------
			mobTarget:sendAnimation(331, 0) -- Play animation on Enemy
			-- Damage application ------------------------------
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1) -- Apply Damage
		elseif pcTarget ~= nil then
			-- player has PK turned on.
			if (player:canPK(pcTarget)) then
				damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 4
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:talk(2, "Smash!")
				player.magic = player.magic - magicCost
				player:setAether("club_strike", aether)
				player:sendStatus()
				player:sendMinitext("You cast Club Strike.")
				pcTarget:sendAnimation(331, 0)
				player:playSound(14)
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end,
	------------------------------------
	-- Requirements to learn the spell--
	------------------------------------
	requirements = function(player)
		local level = 9
		local item = {0, 212, 3003}
		local amounts = {500, 10, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Club Strike is essential if you are to survive outside city walls!", txt}
		return level, item, amounts, desc
	end
}

-----------------------------------
