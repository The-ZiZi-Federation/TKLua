dimension_door = {
	cast = function(player, target)
		local npc = core
		local minMagic = 10000

		if target ~= nil then
			if not player:canCast(1, 1, 0) then
				return
			else
				if player.magic < minMagic then
					notEnoughMP(player)
					return
				else
					if player:hasDuration("dimension_door") then
						player:sendAnimation(246)
						player:sendMinitext("You already cast this spell")
						return
					else
						player:sendAction(6, 250)
						player:playSound(64)
						player:sendAnimationXY(364, target.x, target.y)
						player:freeAsync()
						dimension_door.menu(player, npc, target)
						player:sendMinitext("You cast Dimension Door")
					end
				end
			end
		end
	end,
	menu = async(
		function(player, npc, target)
			local minMagic = 10000
			local m, x, y = 0, 0, 0
			local spellName = "<b>[Dimension Door]\n\n"
			local opts, location = {}, {}

			if player.gfxClone == 0 then
				clone.equip(player, npc)
			else
				clone.gfx(player, npc)
			end
			player.lastClick = npc.ID
			player.dialogType = 2

			location = dimension_door.checkLocation(player)

			if #location < 2 then
				table.insert(opts, "Save Location")
			end
			if #location > 0 then
				table.insert(opts, "Summon Dimension Door")
				table.insert(opts, "Delete Saved Location")
			end
			table.insert(opts, "Exit")

			menu = player:menuString(spellName .. "Location saved : " .. #location .. "/2", opts)

			if menu == "Save Location" then
				if player.saveDimensionDoor == 1 then
					dimension_door.save(player, target)
				else
					player:msg(0, "Dimension door save disabled on this map.", player.ID)
				end
			elseif menu == "Summon Dimension Door" then
				list = player:menuString(spellName .. "Where do you wish to go?", location)

				if list ~= nil then
					if
						list ==
							"'" ..
								player.f1Name ..
									"' [X: " .. player.registry["dimension_x_1"] .. ", Y: " .. player.registry["dimension_x_1"] .. "]"
					 then
						m, x, y, text =
							player.registry["dimension_m_1"],
							player.registry["dimension_x_1"],
							player.registry["dimension_y_1"],
							player.f1Name
					elseif
						list ==
							"'" ..
								player.afkMessage ..
									"' [X: " .. player.registry["dimension_x_2"] .. ", Y: " .. player.registry["dimension_x_2"] .. "]"
					 then
						m, x, y, text =
							player.registry["dimension_m_2"],
							player.registry["dimension_x_2"],
							player.registry["dimension_y_2"],
							player.afkMessage
					end
					if m > 0 and text ~= nil then
						player:sendAction(6, 20)
						player:addNPC("dimension_door", target.m, target.x, target.y, 1000, 30000, player.ID)
						spot = player:getObjectsInCell(target.m, target.x, target.y, BL_NPC)
						if #spot > 0 then
							for i = 1, #spot do
								if spot[i].yname == "dimension_door" then
									if spot[i].registry["m"] == 0 and spot[i].registry["x"] == 0 and spot[i].registry["y"] == 0 then
										if player.magic < minMagic then
											notEnoughMP(player)
											return
										else
											player.magic = 0
											player:sendStatus()
											spot[i].registry["m"] = m
											spot[i].registry["x"] = x
											spot[i].registry["y"] = y
											player:sendAnimationXY(364, target.x, target.y)
											player:sendAnimationXY(254, target.x, target.y)
											player:setDuration("dimension_door", 30000)
											player:playSound(729)
											player:sendMinitext("You cast Dimension Door")
											break
										end
									end
								end
							end
						end
					end
				end
			elseif menu == "Delete Saved Location" then
				dimension_door.delete(player, npc, target, location)
			end
		end
	),
	delete = function(player, npc, target, location)
		local spellName = "<b>[Dimension Door]\n\n"
		if player.gfxClone == 0 then
			clone.equip(player, npc)
		else
			clone.gfx(player, npc)
		end
		player.lastClick = npc.ID
		player.dialogType = 2

		delete = player:menuString(spellName .. "Which location would you delete?", location)

		if delete ~= nil then
			if
				delete ==
					"'" ..
						player.f1Name ..
							"' [X: " .. player.registry["dimension_x_1"] .. ", Y: " .. player.registry["dimension_x_1"] .. "]"
			 then
				dimension_door.flushLocation(player, 1)
			elseif
				delete ==
					"'" ..
						player.afkMessage ..
							"' [X: " .. player.registry["dimension_x_2"] .. ", Y: " .. player.registry["dimension_x_2"] .. "]"
			 then
				dimension_door.flushLocation(player, 2)
			end
			player:sendMinitext("Deleted")
			player:freeAsync()
			dimension_door.menu(player, npc, target)
		end
	end,
	checkLocation = function(player)
		local m, x, y, location = {}, {}, {}, {}

		if player.registry["dimension_m_1"] > 0 and player.f1Name ~= nil then
			table.insert(
				location,
				"'" ..
					player.f1Name .. "' [X: " .. player.registry["dimension_x_1"] .. ", Y: " .. player.registry["dimension_x_1"] .. "]"
			)
		end
		if player.registry["dimension_m_2"] > 0 and player.afkMessage ~= nil then
			table.insert(
				location,
				"'" ..
					player.afkMessage ..
						"' [X: " .. player.registry["dimension_x_2"] .. ", Y: " .. player.registry["dimension_x_2"] .. "]"
			)
		end
		return location
	end,
	save = function(player, target)
		if player.f1Name == "" then
			player.f1Name = target.mapTitle
			player.registry["dimension_m_1"] = target.m
			player.registry["dimension_x_1"] = target.x
			player.registry["dimension_y_1"] = target.y
			player:sendMinitext("Location saved!")
			player:playSound(111)
			player:playSound(505)
			player:sendAnimation(251)
			target:sendAnimationXY(349, target.x, target.y)
			return
		else
			if player.afkMessage == "" then
				player.afkMessage = target.mapTitle
				player.registry["dimension_m_2"] = target.m
				player.registry["dimension_x_2"] = target.x
				player.registry["dimension_y_2"] = target.y
				player:sendMinitext("Location saved!")
				player:playSound(111)
				player:playSound(505)
				player:sendAnimation(251)
				target:sendAnimationXY(349, target.x, target.y)
				return
			end
		end
	end,
	walk = function(player)
		local npc = player:getObjectsInCell(player.m, player.x, player.y, BL_NPC)

		if #npc > 0 then
			for i = 1, #npc do
				if npc[i].registry["m"] > 0 then
					if player.x == npc[i].x and player.y == npc[i].y then
						player:sendAnimationXY(266, player.x, player.y)
						player:playSound(511)
						player:warp(npc[i].registry["m"], npc[i].registry["x"], npc[i].registry["y"])
						player:sendAnimationXY(121, player.x, player.y)
						player:sendAnimationXY(251, player.x, player.y)
						player:playSound(80)
						player:sendMinitext("Warped to " .. player.mapTitle)
					end
				end
			end
		end
	end,
	action = function(block, caster)
		local pc = block:getObjectsInCell(block.m, block.x, block.y, BL_PC)
		local m, x, y = block.registry["m"], block.registry["x"], block.registry["y"]

		if caster == nil then
			block:delete()
			return
		else
			block:sendAnimationXY(253, block.x, block.y)
			block:sendAnimationXY(116, block.x, block.y)
		end
	end,
	endAction = function(block)
		block.registry["m"] = 0
		block.registry["x"] = 0
		block.registry["y"] = 0
		block:sendAnimationXY(16, block.x, block.y)
		block:delete()
	end,
	flushLocation = function(player, num)
		if tonumber(num) > 0 then
			if tonumber(num) == 1 then
				player.f1Name = ""
			elseif tonumber(num) == 2 then
				player.afkMessage = ""
			end
			player.registry["dimension_m_" .. tonumber(num)] = 0
			player.registry["dimension_x_" .. tonumber(num)] = 0
			player.registry["dimension_y_" .. tonumber(num)] = 0
		end
	end
}
