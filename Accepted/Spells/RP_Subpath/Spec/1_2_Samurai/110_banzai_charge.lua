banzai_charge = {
	on_learn = function(player)
		player.registry["learned_banzai_charge"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_banzai_charge"] = 0
	end,
	cast = function(player)
		local aether = 12000
		local magicCost = math.floor(player.maxMagic * 0.15)
		local m, x, y, s = player.m, player.x, player.y, player.side
		local pc, mob, npc
		local sound = 30

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		player:sendAction(1, 20)
		player.magic = player.magic - magicCost
		player:setAether("banzai_charge", aether)
		player:sendStatus()
		player:playSound(sound)
		--player:sendAnimationXY(279, player.x, player.y)

		if player.drunk == 1 then
			player.side = math.random(0, 3)
			player:sendSide()
		end
		if s == 0 then
			pc, mob, npc =
				player:getObjectsInCell(m, x, y - 7, BL_PC),
				player:getObjectsInCell(m, x, y - 7, BL_MOB),
				player:getObjectsInCell(m, x, y - 7, BL_NPC)
			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x, y - 1) == 0 and player:objectCanMove(x, y - 1, 0) then
					if getPass(m, x, y - 2) == 0 and player:objectCanMove(x, y - 2, 0) then
						if getPass(m, x, y - 3) == 0 and player:objectCanMove(x, y - 3, 0) then
							if getPass(m, x, y - 4) == 0 and player:objectCanMove(x, y - 4, 0) then
								if getPass(m, x, y - 5) == 0 and player:objectCanMove(x, y - 5, 0) then
									if getPass(m, x, y - 6) == 0 and player:objectCanMove(x, y - 6, 0) then
										if getPass(m, x, y - 7) == 0 and player:objectCanMove(x, y - 7, 0) then
											if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
												banzai_charge.warp(player, m, x, y - 6)
												return
											else
												banzai_charge.warp(player, m, x, y - 7)
												return
											end
											return
										else
											banzai_charge.warp(player, m, x, y - 6)
										end
										return
									else
										banzai_charge.warp(player, m, x, y - 5)
									end
									return
								else
									banzai_charge.warp(player, m, x, y - 4)
								end
								return
							else
								banzai_charge.warp(player, m, x, y - 3)
							end
							return
						else
							banzai_charge.warp(player, m, x, y - 2)
						end
						return
					else
						banzai_charge.warp(player, m, x, y - 1)
					end
				end
			end
		elseif s == 1 then
			pc = player:getObjectsInCell(m, x + 7, y, BL_PC)
			mob = player:getObjectsInCell(m, x + 7, y, BL_MOB)
			npc = player:getObjectsInCell(m, x + 7, y, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x + 1, y) == 0 and player:objectCanMove(x + 1, y, 0) then
					if getPass(m, x + 2, y) == 0 and player:objectCanMove(x + 2, y, 0) then
						if getPass(m, x + 3, y) == 0 and player:objectCanMove(x + 3, y, 0) then
							if getPass(m, x + 4, y) == 0 and player:objectCanMove(x + 4, y, 0) then
								if getPass(m, x + 5, y) == 0 and player:objectCanMove(x + 5, y, 0) then
									if getPass(m, x + 6, y) == 0 and player:objectCanMove(x + 6, y, 0) then
										if getPass(m, x + 7, y) == 0 and player:objectCanMove(x + 7, y, 0) then
											if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
												banzai_charge.warp(player, m, x + 6, y)
												return
											else
												banzai_charge.warp(player, m, x + 7, y)
												return
											end
											return
										else
											banzai_charge.warp(player, m, x + 6, y)
										end
										return
									else
										banzai_charge.warp(player, m, x + 5, y)
									end
									return
								else
									banzai_charge.warp(player, m, x + 4, y)
								end
								return
							else
								banzai_charge.warp(player, m, x + 3, y)
							end
							return
						else
							banzai_charge.warp(player, m, x + 2, y)
						end
						return
					else
						banzai_charge.warp(player, m, x + 1, y)
					end
				end
			end
		elseif s == 2 then
			pc = player:getObjectsInCell(m, x, y + 7, BL_PC)
			mob = player:getObjectsInCell(m, x, y + 7, BL_MOB)
			npc = player:getObjectsInCell(m, x, y + 7, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x, y + 1) == 0 and player:objectCanMove(x, y + 1, 0) then
					if getPass(m, x, y + 2) == 0 and player:objectCanMove(x, y + 2, 0) then
						if getPass(m, x, y + 3) == 0 and player:objectCanMove(x, y + 3, 0) then
							if getPass(m, x, y + 4) == 0 and player:objectCanMove(x, y + 4, 0) then
								if getPass(m, x, y + 5) == 0 and player:objectCanMove(x, y + 5, 0) then
									if getPass(m, x, y + 6) == 0 and player:objectCanMove(x, y + 6, 0) then
										if getPass(m, x, y + 7) == 0 and player:objectCanMove(x, y + 7, 0) then
											if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
												banzai_charge.warp(player, m, x, y + 6)
												return
											else
												banzai_charge.warp(player, m, x, y + 7)
												return
											end
											return
										else
											banzai_charge.warp(player, m, x, y + 6)
										end
										return
									else
										banzai_charge.warp(player, m, x, y + 5)
									end
									return
								else
									banzai_charge.warp(player, m, x, y + 4)
								end
								return
							else
								banzai_charge.warp(player, m, x, y + 3)
							end
							return
						else
							banzai_charge.warp(player, m, x, y + 2)
						end
						return
					else
						banzai_charge.warp(player, m, x, y + 1)
					end
				end
			end
		elseif s == 3 then
			pc = player:getObjectsInCell(m, x - 7, y, BL_PC)
			mob = player:getObjectsInCell(m, x - 7, y, BL_MOB)
			npc = player:getObjectsInCell(m, x - 7, y, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x - 1, y) == 0 and player:objectCanMove(x - 1, y, 0) then
					if getPass(m, x - 2, y) == 0 and player:objectCanMove(x - 2, y, 0) then
						if getPass(m, x - 3, y) == 0 and player:objectCanMove(x - 3, y, 0) then
							if getPass(m, x - 4, y) == 0 and player:objectCanMove(x - 4, y, 0) then
								if getPass(m, x - 5, y) == 0 and player:objectCanMove(x - 5, y, 0) then
									if getPass(m, x - 6, y) == 0 and player:objectCanMove(x - 6, y, 0) then
										if getPass(m, x - 7, y) == 0 and player:objectCanMove(x - 7, y, 0) then
											if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
												banzai_charge.warp(player, m, x - 6, y)
												return
											else
												banzai_charge.warp(player, m, x - 7, y)
												return
											end
											return
										else
											banzai_charge.warp(player, m, x - 6, y)
										end
										return
									else
										banzai_charge.warp(player, m, x - 5, y)
									end
									return
								else
									banzai_charge.warp(player, m, x - 4, y)
								end
								return
							else
								banzai_charge.warp(player, m, x - 3, y)
							end
							return
						else
							banzai_charge.warp(player, m, x - 2, y)
						end
						return
					else
						banzai_charge.warp(player, m, x - 1, y)
					end
				end
			end
		end
	end,
	warp = function(player, m, x, y)
		local beforeX = player.x
		local beforeY = player.y

		player:warp(m, x, y)
		banzai_charge.dealDamage(player, beforeX, beforeY, x, y)
		banzai_charge.act(player)
	end,
	act = function(player)
		local actAnim = 280

		player:sendAction(1, 20)
		player:sendAnimation(actAnim)
		--player:sendAnimationXY(279, player.x, player.y)
		player:sendMinitext("You cast Banzai Charge")
	end,
	dealDamage = function(player, startX, startY, endX, endY)
		local topLeftX, topLeftY, bottomRightX, bottomRightY
		local damage
		local moveAnim = 599
		local hitAnim = 6

		local mob = {}

		if player.side == 0 then
			topLeftX = endX - 1
			topLeftY = endY
			bottomRightX = startX + 1
			bottomRightY = startY

			for x = startX, endX do
				for y = endY + 1, startY do
					player:sendAnimationXY(moveAnim, x, y)
				end
			end

			for x = topLeftX, bottomRightX do
				for y = topLeftY, bottomRightY do
					mob = player:getObjectsInCell(player.m, x, y, BL_MOB)
					if mob ~= nil then
						for i = 1, #mob do
							player.critChance = 1
							mob[i].attacker = player.ID
							damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob[i], 2)) * 10
							damage = math.floor(damage)
							mob[i]:sendAnimation(hitAnim)
							mob[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						end
					end
				end
			end
		elseif player.side == 1 then
			topLeftX = startX
			topLeftY = startY - 1
			bottomRightX = endX
			bottomRightY = endY + 1

			for x = startX, endX - 1 do
				for y = startY, endY do
					player:sendAnimationXY(moveAnim, x, y)
				end
			end

			for x = topLeftX, bottomRightX do
				for y = topLeftY, bottomRightY do
					mob = player:getObjectsInCell(player.m, x, y, BL_MOB)
					if mob ~= nil then
						for i = 1, #mob do
							player.critChance = 1
							mob[i].attacker = player.ID
							damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob[i], 2)) * 10
							damage = math.floor(damage)
							mob[i]:sendAnimation(hitAnim)
							mob[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						end
					end
				end
			end
		elseif player.side == 2 then
			topLeftX = startX - 1
			topLeftY = startY
			bottomRightX = endX + 1
			bottomRightY = endY

			for x = startX, endX do
				for y = startY, endY - 1 do
					player:sendAnimationXY(moveAnim, x, y)
				end
			end

			for x = topLeftX, bottomRightX do
				for y = topLeftY, bottomRightY do
					mob = player:getObjectsInCell(player.m, x, y, BL_MOB)
					if mob ~= nil then
						for i = 1, #mob do
							player.critChance = 1
							mob[i].attacker = player.ID
							damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob[i], 2)) * 10
							damage = math.floor(damage)
							mob[i]:sendAnimation(hitAnim)
							mob[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						end
					end
				end
			end
		elseif player.side == 3 then
			topLeftX = endX
			topLeftY = endY - 1
			bottomRightX = startX
			bottomRightY = startY + 1

			for x = endX + 1, startX do
				for y = startY, endY do
					player:sendAnimationXY(moveAnim, x, y)
				end
			end

			for x = topLeftX, bottomRightX do
				for y = topLeftY, bottomRightY do
					mob = player:getObjectsInCell(player.m, x, y, BL_MOB)
					if mob ~= nil then
						for i = 1, #mob do
							player.critChance = 1
							mob[i].attacker = player.ID
							damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob[i], 2)) * 10
							damage = math.floor(damage)
							mob[i]:sendAnimation(hitAnim)
							mob[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A traditional Samurai technique: rush forward and slash many foes.", txt}
		return level, item, amounts, desc
	end
}
