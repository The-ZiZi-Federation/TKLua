-------------------------------------------------------
--   Spell: Lunging Club Strike
--   Class: Priest
--   Level: 74
--  Aether: 11 Second
--    Stun: 2-4 Seconds
-- Targets: 1
--   Desc.: A heavy strike against a single foe.
--          Damage based more on Might than Will
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 07/07/2017
-------------------------------------------------------
lunging_club_strike = {
	on_learn = function(player)
		player.registry["learned_lunging_club_strike"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_lunging_club_strike"] = 0
	end,
	cast = function(player)
		------------------------
		--Varable Declarations--
		------------------------
		local magicCost = (player.level * 20) + (player.maxMagic / 20)
		local m, x, y, s = player.m, player.x, player.y, player.side

		local mob1, mob2, mob3 =
			getTargetFacing(player, BL_MOB),
			getTargetFacing(player, BL_MOB, 0, 2),
			getTargetFacing(player, BL_MOB, 0, 3)
		local pc1, pc2, pc3 =
			getTargetFacing(player, BL_PC),
			getTargetFacing(player, BL_PC, 0, 2),
			getTargetFacing(player, BL_PC, 0, 3)

		local aethers = 11000

		player.critChance = 1

		if player.gmLevel > 0 then
			aethers = 0
		end

		----------------------------
		-- Check if Castable--------
		----------------------------
		if not player:canCast(1, 1, 0) then
			anim(player)
			return
		else
			----------------------------
			-- Check if MP available----
			----------------------------
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:setAether("lunging_club_strike", aethers)
				player:sendMinitext("You lunge while swinging your club.")

				if s == 0 then
					if getPass(m, x, y - 1) == 0 and pc1 == nil and mob1 == nil and not getWarp(m, x, y - 1) then
						if getPass(m, x, y - 2) == 0 and pc2 == nil and mob2 == nil and not getWarp(m, x, y - 2) then
							if getPass(m, x, y - 3) == 0 and pc3 == nil and mob3 and not getWarp(m, x, y - 3) == nil then
								player:warp(m, x, y - 3)
								lunging_club_strike.act(player)
							else
								player:warp(m, x, y - 2)
								if mob3 ~= nil then
									lunging_club_strike.damaged(player, mob3)
								end
								if pc3 ~= nil then
									lunging_club_strike.damaged(player, pc3)
								end
								lunging_club_strike.act(player)
							end
						else
							player:warp(m, x, y - 1)
							if mob2 ~= nil then
								lunging_club_strike.damaged(player, mob2)
							end
							if pc2 ~= nil then
								lunging_club_strike.damaged(player, pc2)
							end
							lunging_club_strike.act(player)
						end
					else
						if mob1 ~= nil then
							lunging_club_strike.damaged(player, mob1)
						end
						if pc1 ~= nil then
							lunging_club_strike.damaged(player, pc1)
						end
						lunging_club_strike.act(player)
					end
				elseif s == 1 then
					if getPass(m, x + 1, y) == 0 and pc1 == nil and mob1 == nil and not getWarp(m, x + 1, y) then
						if getPass(m, x + 2, y) == 0 and pc2 == nil and mob2 == nil and not getWarp(m, x + 2, y) then
							if getPass(m, x + 3, y) == 0 and pc3 == nil and mob3 == nil and not getWarp(m, x + 3, y) then
								player:warp(m, x + 3, y)
								lunging_club_strike.act(player)
							else
								player:warp(m, x + 2, y)
								if mob3 ~= nil then
									lunging_club_strike.damaged(player, mob3)
								end
								if pc3 ~= nil then
									lunging_club_strike.damaged(player, pc3)
								end
								lunging_club_strike.act(player)
							end
						else
							player:warp(m, x + 1, y)
							if mob2 ~= nil then
								lunging_club_strike.damaged(player, mob2)
							end
							if pc2 ~= nil then
								lunging_club_strike.damaged(player, pc2)
							end
							lunging_club_strike.act(player)
						end
					else
						if mob1 ~= nil then
							lunging_club_strike.damaged(player, mob1)
						end
						if pc1 ~= nil then
							lunging_club_strike.damaged(player, pc1)
						end
						lunging_club_strike.act(player)
					end
				elseif s == 2 then
					if getPass(m, x, y + 1) == 0 and pc1 == nil and mob1 == nil and not getWarp(m, x, y + 1) then
						if getPass(m, x, y + 2) == 0 and pc2 == nil and mob2 == nil and not getWarp(m, x, y + 2) then
							if getPass(m, x, y + 3) == 0 and pc3 == nil and mob3 == nil and not getWarp(m, x, y + 3) then
								player:warp(m, x, y + 3)
								lunging_club_strike.act(player)
							else
								player:warp(m, x, y + 2)
								if mob3 ~= nil then
									lunging_club_strike.damaged(player, mob3)
								end
								if pc3 ~= nil then
									lunging_club_strike.damaged(player, pc3)
								end
								lunging_club_strike.act(player)
							end
						else
							player:warp(m, x, y + 1)
							if mob2 ~= nil then
								lunging_club_strike.damaged(player, mob2)
							end
							if pc2 ~= nil then
								lunging_club_strike.damaged(player, pc2)
							end
							lunging_club_strike.act(player)
						end
					else
						if mob1 ~= nil then
							lunging_club_strike.damaged(player, mob1)
						end
						if pc1 ~= nil then
							lunging_club_strike.damaged(player, pc1)
						end
						lunging_club_strike.act(player)
					end
				elseif s == 3 then
					if getPass(m, x - 1, y) == 0 and pc1 == nil and mob1 == nil and not getWarp(m, x - 1, y) then
						if getPass(m, x - 2, y) == 0 and pc2 == nil and mob2 == nil and not getWarp(m, x - 2, y) then
							if getPass(m, x - 3, y) == 0 and pc3 == nil and mob3 == nil and not getWarp(m, x - 3, y) then
								player:warp(m, x - 3, y)
								lunging_club_strike.act(player)
							else
								player:warp(m, x - 2, y)
								if mob3 ~= nil then
									lunging_club_strike.damaged(player, mob3)
								end
								if pc3 ~= nil then
									lunging_club_strike.damaged(player, pc3)
								end
								lunging_club_strike.act(player)
							end
						else
							player:warp(m, x - 1, y)
							if mob2 ~= nil then
								lunging_club_strike.damaged(player, mob2)
							end
							if pc2 ~= nil then
								lunging_club_strike.damaged(player, pc2)
							end
							lunging_club_strike.act(player)
						end
					else
						if mob1 ~= nil then
							lunging_club_strike.damaged(player, mob1)
						end
						if pc1 ~= nil then
							lunging_club_strike.damaged(player, pc1)
						end
						lunging_club_strike.act(player)
					end
				end
			end
		end
	end,
	damaged = function(player, mob)
		local damage = ((0.03 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob, 2)) * 6

		local m, x, y = mob.m, mob.x, mob.y
		local nodes = {
			3007,
			50101,
			50102,
			50103,
			50104,
			50106,
			50107,
			50108,
			50109,
			50511,
			50512,
			50513,
			50514,
			50516,
			50517,
			50518,
			50519,
			50520,
			50521,
			50522
		}
		local times = {2000, 3000, 4000}
		local stunDuration = times[math.random(1, 3)]
		local threat
		--------------------------------------
		-- Prevent Nodes from being targeted--
		--------------------------------------
		for i = 1, #nodes do
			if mob.mobID == nodes[i] then
				player:sendMinitext("Nope!")
				return
			end
		end

		------------------------------------
		-- Player is target ----------------
		------------------------------------
		if mob.blType == BL_PC then
			return
		else
			-- Prevent Damage to an allied mob.

			if mob.owner == player.ID then
				return
			end
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mob.ID, threat)
		end

		mob:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		mob:sendAnimation(423)

		if player.side == 0 then
			x, y = x, y - 1
		end
		if player.side == 1 then
			x, y = x + 1, y
		end
		if player.side == 2 then
			x, y = x, y + 1
		end
		if player.side == 3 then
			x, y = x - 1, y
		end
		if getPass(m, x, y) == 1 then
			return
		else
			mob:warp(m, x, y)
		end

		if not mob:hasDuration("stun") then
			if checkResist(player, mob, "stun") == 1 then
				return
			end
			mob:setDuration("stun", stunDuration)
		end
	end,
	act = function(player)
		player:sendAction(1, 20)
		player:talk(2, "In the name of ASAK!!!")
		player:playSound(101)

		if player.side == 0 then
			player:sendAnimationXY(153, player.x, player.y - 1)
		elseif player.side == 1 then
			player:sendAnimationXY(153, player.x + 1, player.y)
		elseif player.side == 2 then
			player:sendAnimationXY(153, player.x, player.y + 1)
		elseif player.side == 3 then
			player:sendAnimationXY(153, player.x - 1, player.y)
		end
	end,
	requirements = function(player)
		local level = 74
		local item = {0, 402, 3032}
		local amounts = {3500, 15, 15}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Lunging Strike is a spell that jumps the priest forward, knocking back an enemy!", txt}
		return level, item, amounts, desc
	end
}
