back_track = {
	on_learned = function(player)
		player.registry["learned_back_track"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_back_track"] = 0
	end,
	cast = function(player)
		local magicCost = 1000
		local aether = 3000
		local sound = 30
		local anim = 20
		local m, x, y, s = player.m, player.x, player.y, player.side

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player.magic = player.magic - magicCost
		player:setAether("back_track", aether)
		player:sendStatus()
		player:playSound(sound)
		player:sendAnimationXY(anim, player.x, player.y)

		if s == 0 then
			pc, mob, npc =
				player:getObjectsInCell(m, x, y + 3, BL_PC),
				player:getObjectsInCell(m, x, y + 3, BL_MOB),
				player:getObjectsInCell(m, x, y + 3, BL_NPC)
			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x, y + 1) == 0 and player:objectCanMove(x, y + 1, 0) and not getWarp(m, x, y + 1) then
					if getPass(m, x, y + 2) == 0 and player:objectCanMove(x, y + 2, 0) and not getWarp(m, x, y + 2) then
						if getPass(m, x, y + 3) == 0 and player:objectCanMove(x, y + 3, 0) and not getWarp(m, x, y + 3) then
							if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
								back_track.warp(player, m, x, y + 2)
								return
							else
								back_track.warp(player, m, x, y + 3)
								return
							end
							return
						else
							back_track.warp(player, m, x, y + 2)
						end
						return
					else
						back_track.warp(player, m, x, y + 1)
					end
				end
			end
		elseif s == 1 then
			pc, mob, npc =
				player:getObjectsInCell(m, x - 3, y, BL_PC),
				player:getObjectsInCell(m, x - 3, y, BL_MOB),
				player:getObjectsInCell(m, x - 3, y, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x - 1, y) == 0 and player:objectCanMove(x - 1, y, 0) and not getWarp(m, x - 1, y) then
					if getPass(m, x - 2, y) == 0 and player:objectCanMove(x - 2, y, 0) and not getWarp(m, x - 2, y) then
						if getPass(m, x - 3, y) == 0 and player:objectCanMove(x - 3, y, 0) and not getWarp(m, x - 3, y) then
							if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
								back_track.warp(player, m, x - 2, y)
								return
							else
								back_track.warp(player, m, x - 3, y)
								return
							end
							return
						else
							back_track.warp(player, m, x - 2, y)
						end
						return
					else
						back_track.warp(player, m, x - 1, y)
					end
				end
			end
		elseif s == 2 then
			pc, mob, npc =
				player:getObjectsInCell(m, x, y - 3, BL_PC),
				player:getObjectsInCell(m, x, y - 3, BL_MOB),
				player:getObjectsInCell(m, x, y - 3, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x, y - 1) == 0 and player:objectCanMove(x, y - 1, 0) and not getWarp(m, x, y - 1) then
					if getPass(m, x, y - 2) == 0 and player:objectCanMove(x, y - 2, 0) and not getWarp(m, x, y - 2) then
						if getPass(m, x, y - 3) == 0 and player:objectCanMove(x, y - 3, 0) and not getWarp(m, x, y - 3) then
							if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
								back_track.warp(player, m, x, y - 2)
								return
							else
								back_track.warp(player, m, x, y - 3)
								return
							end
							return
						else
							back_track.warp(player, m, x, y - 2)
						end
						return
					else
						back_track.warp(player, m, x, y - 1)
					end
				end
			end
		elseif s == 3 then
			pc, mob, npc =
				player:getObjectsInCell(m, x + 3, y, BL_PC),
				player:getObjectsInCell(m, x + 3, y, BL_MOB),
				player:getObjectsInCell(m, x + 3, y, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x + 1, y) == 0 and player:objectCanMove(x + 1, y, 0) and not getWarp(m, x + 1, y) then
					if getPass(m, x + 2, y) == 0 and player:objectCanMove(x + 2, y, 0) and not getWarp(m, x + 2, y) then
						if getPass(m, x + 3, y) == 0 and player:objectCanMove(x + 3, y, 0) and not getWarp(m, x + 3, y) then
							if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
								back_track.warp(player, m, x + 2, y)
								return
							else
								back_track.warp(player, m, x + 3, y)
								return
							end
							return
						else
							back_track.warp(player, m, x + 2, y)
						end
						return
					else
						back_track.warp(player, m, x + 1, y)
					end
				end
			end
		end
	end,
	warp = function(player, m, x, y)
		player:warp(m, x, y)
		back_track.act(player)
	end,
	act = function(player)
		local anim = 21

		player:sendAnimation(anim)
		player:sendAction(6, 20)
		player:sendMinitext("You cast Backtrack")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Use this to quickly dodge backwards!", txt}
		return level, item, amounts, desc
	end
}
