water_sumo = {
	push = function(player)
		local waterTile = {628, 35012, 35013, 17816, 35011, 35010, 35009, 35017, 35015, 35014, 35025, 35016}
		local targetPC = getTargetFacing(player, BL_PC)
		local targetMob = getTargetFacing(player, BL_MOB)
		local m, x, y = player.m, player.x, player.y
		if targetPC ~= nil and targetPC.state ~= 1 then
			if m == 1000 then -- This ..your map id? 1000
				if x >= 30 and x <= 58 then
					if y >= 72 and y <= 94 then
						player:sendFrontAnimation(191)

						if player.side == 0 then
							x = targetPC.x
							y = targetPC.y - 1
						elseif player.side == 1 then
							x = targetPC.x + 1
							y = targetPC.y
						elseif player.side == 2 then
							x = targetPC.x
							y = targetPC.y + 1
						elseif player.side == 3 then
							x = targetPC.x - 1
							y = targetPC.y
						end

						if getPass(m, x, y) == 0 then
							targetPC:warp(targetPC.m, x, y)
						elseif getPass(m, x, y) == 1 then
							for i = 1, #waterTile do
								if getTile(m, x, y) == waterTile[i] then
									targetPC:warp(targetPC.m, x, y)
									targetPC.state = 1
									targetPC:updateState()
									targetPC:sendAnimation(142)
									targetPC:sendAnimationXY(137, targetPC.x, targetPC.y)
									player:playSound(73)
									player:talk(2, "Die!")
								--	targetPC:warp(1000, 27, 83)
								end
							end
						end
					end
				end
			end
		elseif targetMob ~= nil then
			if targetMob.mobID <= 14999 or targetMob.mobID >= 15005 then
				return
			end
			if player.m == 1000 then
				if player.quest["sumo_course"] ~= 4 then
					return
				end
			end
			if (m == 1000 and (x >= 30 and x <= 58) and (y >= 72 and y <= 94)) or player.mapTitle == "Sumo Course" then
				player:sendFrontAnimation(191)

				if player.side == 0 then
					x = targetMob.x
					y = targetMob.y - 1
				elseif player.side == 1 then
					x = targetMob.x + 1
					y = targetMob.y
				elseif player.side == 2 then
					x = targetMob.x
					y = targetMob.y + 1
				elseif player.side == 3 then
					x = targetMob.x - 1
					y = targetMob.y
				end

				if getPass(m, x, y) == 0 then
					targetMob:warp(targetMob.m, x, y)
				elseif getPass(m, x, y) == 1 then
					for i = 1, #waterTile do
						if getTile(m, x, y) == waterTile[i] then
							targetMob:warp(targetMob.m, x, y)
							targetMob:sendAnimation(142)
							targetMob:sendAnimationXY(137, targetMob.x, targetMob.y)
							player:playSound(73)
							targetMob:vanish2()
							--targetMob:removeHealth(targetMob.maxHealth)
							player:talk(2, "Die!")
							--	targetMob:warp(1000, 27, 83)
							if player.m == 1000 then
								if player.quest["sumo_course"] == 4 then
									if player:hasItem("sumo_medal", 15) == true then
										return
									else
										player:addItem("sumo_medal", 1)
										player:sendMinitext("You take a Sumo Medal from your opponent!")
									end
								end
							end
							if player.mapTitle == "Sumo Course" then
								player.registry["sumo_course_dunks"] = player.registry["sumo_course_dunks"] + 1
							end
						end
					end
				end
			end
		end
		player:sendAction(1, 20)
	end,
	ressurect = function(player)
		if player.m == 1000 then
			if player.x >= 30 and player.x <= 58 then
				if player.y >= 72 and player.y <= 94 then
					if player.state == 1 then
						player.state = 0
						player.health = player.maxHealth
						player:calcStat()
						player:updateState()
						player:sendAnimationXY(425, player.x, player.y)
						player:playSound(112)
					end
				end
			end
		end
	end,
	walk = function(player)
		local tile = {35012, 35013, 17816, 35011, 35010, 35009, 35017, 35015, 35014, 35025, 35016}
		local m, x, y = player.m, player.x, player.y

		if m == 1000 then
			if x >= 30 and x <= 58 then
				if y >= 72 and y <= 94 then
					for i = 1, #tile do
						if getTile(m, x, y) == tile[i] then
							if player.state ~= 1 then
								player:sendAnimation(142)
								player:playSound(73)
								player.health = 0
								player.state = 1
								player:calcStat()
								player:updateState()
								for i = 1, 2 do
									player:playSound(84)
								end
								player:sendAnimationXY(223, player.x, player.y)
								player:msg(4, "[WATER SUMO] Press 'o' to revive!", player.ID)
							--	player:warp(1000, 27, 83)
							end
						end
					end
				end
			end
		end
	end,
	canPush = function(player, target)
		local atas = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		local bawah = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		local kiri = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		local kanan = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		local r = math.random(1, 2)

		if target.state == 1 then
			return false
		end
		local pc = getTargetFacing(player, BL_PC)

		if pc ~= nil and pc.ID == target.ID then
			if player.side == 0 then
				if #atas == 0 then
					target:warp(target.m, target.x, target.y - 1)
				else
					if r == 1 then
						target:warp(target.m, target.x - 1, target.y)
					end
					if r == 2 then
						target:warp(target.m, target.x + 1, target.y)
					end
				end
			elseif player.side == 1 then
				if #kanan == 0 then
					target:warp(target.m, target.x + 1, target.y)
				else
					if r == 1 then
						target:warp(target.m, target.x, target.y - 1)
					end
					if r == 2 then
						target:warp(target.m, target.x, target.y + 1)
					end
				end
			elseif player.side == 2 then
				if #bawah == 0 then
					target:warp(target.m, target.x, target.y + 1)
				else
					if r == 1 then
						target:warp(target.m, target.x - 1, target.y)
					end
					if r == 2 then
						target:warp(target.m, target.x + 1, target.y)
					end
				end
			elseif player.side == 3 then
				if #kiri == 0 then
					target:warp(target.m, target.x - 1, target.y)
				else
					if r == 1 then
						target:warp(target.m, target.x, target.y - 1)
					end
					if r == 2 then
						target:warp(target.m, target.x, target.y + 1)
					end
				end
			end
			target:sendAnimation(191)
			player:playSound(10)
			tile = getTile(target.m, target.x, target.y)
			if tile >= 118 and tile <= 123 then
				player:sendAction(10, 60)
				player:playSound(73)
				target:talk(2, "Die")
				target.state = 1
				target:updateState()
				target:sendAnimationXY(137, target.x, target.y)
				target:sendAnimation(142)
				broadcast(1000, "[Water sumo]  " .. target.name .. " has defeated by " .. player.name .. " at water sumo area")
				player:giveXP(500)
			--	water_sumo.respawn(target)
			end
		end
	end,
	respawn = function(player)
		if player.m == 1000 then
			if player.y >= 117 and player.y <= 124 then
				if player.x >= 65 and player.x <= 75 then
					if player.state == 1 then
						if player:hasDuration("water_sumo") then
							return
						else
							player:setDuration("water_sumo", 5000)
						end
					end
				end
			end
		end
	end,
	while_cast = function(player)
		local sec = player:getDuration("water_sumo")
		sec = countDownSeconds(sec)

		player:talk(2, "Respawn in : " .. sec)
	end,
	uncast = function(player)
		if player.state == 1 then
			player:warp(1000, 65, 127)
			player.side = 1
			player:sendAnimation(425)
			player:playSound(112)
			player.state = 0
			player:updateState()
			player:sendSide()
		end
	end
}
