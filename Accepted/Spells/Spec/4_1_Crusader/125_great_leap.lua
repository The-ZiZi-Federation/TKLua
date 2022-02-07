great_leap = {
	on_learned = function(player)
		player.registry["learned_great_leap"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_great_leap"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.05)
		local aether = 60000
		local m, x, y, s = player.m, player.x, player.y, player.side
		local pc, mob, npc
		local sound = 30
		local anim = 279

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		--	player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(sound)
		player:setAether("great_leap", aether)
		player:sendAnimationXY(anim, player.x, player.y)

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
												great_leap.warp(player, m, x, y - 6)
												return
											else
												great_leap.warp(player, m, x, y - 7)
												return
											end
											return
										else
											great_leap.warp(player, m, x, y - 6)
										end
										return
									else
										great_leap.warp(player, m, x, y - 5)
									end
									return
								else
									great_leap.warp(player, m, x, y - 4)
								end
								return
							else
								great_leap.warp(player, m, x, y - 3)
							end
							return
						else
							great_leap.warp(player, m, x, y - 2)
						end
						return
					else
						great_leap.warp(player, m, x, y - 1)
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
												great_leap.warp(player, m, x + 6, y)
												return
											else
												great_leap.warp(player, m, x + 7, y)
												return
											end
											return
										else
											great_leap.warp(player, m, x + 6, y)
										end
										return
									else
										great_leap.warp(player, m, x + 5, y)
									end
									return
								else
									great_leap.warp(player, m, x + 4, y)
								end
								return
							else
								great_leap.warp(player, m, x + 3, y)
							end
							return
						else
							great_leap.warp(player, m, x + 2, y)
						end
						return
					else
						great_leap.warp(player, m, x + 1, y)
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
												great_leap.warp(player, m, x, y + 6)
												return
											else
												great_leap.warp(player, m, x, y + 7)
												return
											end
											return
										else
											great_leap.warp(player, m, x, y + 6)
										end
										return
									else
										great_leap.warp(player, m, x, y + 5)
									end
									return
								else
									great_leap.warp(player, m, x, y + 4)
								end
								return
							else
								great_leap.warp(player, m, x, y + 3)
							end
							return
						else
							great_leap.warp(player, m, x, y + 2)
						end
						return
					else
						great_leap.warp(player, m, x, y + 1)
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
												great_leap.warp(player, m, x - 6, y)
												return
											else
												great_leap.warp(player, m, x - 7, y)
												return
											end
											return
										else
											great_leap.warp(player, m, x - 6, y)
										end
										return
									else
										great_leap.warp(player, m, x - 5, y)
									end
									return
								else
									great_leap.warp(player, m, x - 4, y)
								end
								return
							else
								great_leap.warp(player, m, x - 3, y)
							end
							return
						else
							great_leap.warp(player, m, x - 2, y)
						end
						return
					else
						great_leap.warp(player, m, x - 1, y)
					end
				end
			end
		end
	end,
	warp = function(player, m, x, y)
		player:warp(m, x, y)
		great_leap.act(player)
	end,
	act = function(player)
		local anim1 = 280
		local anim2 = 279

		player:sendAction(6, 20)
		player:sendAnimation(anim1)
		player:sendAnimationXY(anim2, player.x, player.y)
		player:sendMinitext("You cast Great Leap")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Take a great leap forwards, jumping over your foes!", txt}
		return level, item, amounts, desc
	end
}
