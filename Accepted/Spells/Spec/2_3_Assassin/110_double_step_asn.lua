double_step_asn = {
	on_learned = function(player)
		player.registry["learned_double_step_asn"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_double_step_asn"] = 0
	end,
	cast = function(player)
		local magicCost = 0
		local aether = 3000

		local m, x, y, s = player.m, player.x, player.y, player.side

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(30)
		player:setAether("double_step_asn", 3000)
		player:sendAnimationXY(280, player.x, player.y)

		if player.drunk == 1 then
			player.side = math.random(0, 3)
			player:sendSide()
		end
		if s == 0 then
			pc, mob, npc =
				player:getObjectsInCell(m, x, y - 3, BL_PC),
				player:getObjectsInCell(m, x, y - 3, BL_MOB),
				player:getObjectsInCell(m, x, y - 3, BL_NPC)

			if player:objectCanMoveFrom(x, y, 0) then
				if getPass(m, x, y - 1) == 0 and player:objectCanMove(x, y - 1, 0) then
					if getPass(m, x, y - 2) == 0 and player:objectCanMove(x, y - 2, 0) then
						if getPass(m, x, y - 3) == 0 and player:objectCanMove(x, y - 3, 0) then
							if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
								double_step_asn.warp(player, m, x, y - 2)
								return
							else
								double_step_asn.warp(player, m, x, y - 3)
								return
							end
							return
						else
							double_step_asn.warp(player, m, x, y - 2)
						end
						return
					else
						double_step_asn.warp(player, m, x, y - 1)
					end
				end
			end
		elseif s == 1 then
			pc = player:getObjectsInCell(m, x + 3, y, BL_PC)
			mob = player:getObjectsInCell(m, x + 3, y, BL_MOB)
			npc = player:getObjectsInCell(m, x + 3, y, BL_NPC)

			if getPass(m, x + 1, y) == 0 then
				if getPass(m, x + 2, y) == 0 then
					if getPass(m, x + 3, y) == 0 then
						if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
							double_step_asn.warp(player, m, x + 2, y)
							return
						else
							double_step_asn.warp(player, m, x + 3, y)
							return
						end
						return
					else
						double_step_asn.warp(player, m, x + 2, y)
					end
					return
				else
					double_step_asn.warp(player, m, x + 1, y)
				end
			end
		elseif s == 2 then
			pc = player:getObjectsInCell(m, x, y + 3, BL_PC)
			mob = player:getObjectsInCell(m, x, y + 3, BL_MOB)
			npc = player:getObjectsInCell(m, x, y + 3, BL_NPC)

			if getPass(m, x, y + 1) == 0 and player:objectCanMove(x, y + 1, 0) then
				if getPass(m, x, y + 2) == 0 and player:objectCanMove(x, y + 2, 0) then
					if getPass(m, x, y + 3) == 0 and player:objectCanMove(x, y + 3, 0) then
						if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
							double_step_asn.warp(player, m, x, y + 2)
							return
						else
							double_step_asn.warp(player, m, x, y + 3)
							return
						end
						return
					else
						double_step_asn.warp(player, m, x, y + 2)
					end
					return
				else
					double_step_asn.warp(player, m, x, y + 1)
				end
			end
		elseif s == 3 then
			pc = player:getObjectsInCell(m, x - 3, y, BL_PC)
			mob = player:getObjectsInCell(m, x - 3, y, BL_MOB)
			npc = player:getObjectsInCell(m, x - 3, y, BL_NPC)

			if getPass(m, x - 1, y) == 0 then
				if getPass(m, x - 2, y) == 0 then
					if getPass(m, x - 3, y) == 0 then
						if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then
							double_step_asn.warp(player, m, x - 2, y)
							return
						else
							double_step_asn.warp(player, m, x - 3, y)
							return
						end
						return
					else
						double_step_asn.warp(player, m, x - 2, y)
					end
					return
				else
					double_step_asn.warp(player, m, x - 1, y)
				end
			end
		end
	end,
	warp = function(player, m, x, y)
		local obj = 0
		local xx, yy = 0, 0

		if player.m == 30028 or player.m == 30029 then
			for i = 1, 3 do
				if player.side == 0 then
					obj = getObject(player.m, player.x, player.y - i)
				elseif player.side == 1 then
					obj = getObject(player.m, player.x + i, player.y)
				elseif player.side == 2 then
					obj = getObject(player.m, player.x, player.y + i)
				elseif player.side == 3 then
					obj = getObject(player.m, player.x - i, player.y)
				end
				if obj == 11210 or obj == 11211 then
					if i == 3 then
						frontWarp(player, 2)
						double_step_asn.act(player)
					elseif i == 2 then
						frontWarp(player, 1)
						double_step_asn.act(player)
					end
					return
				end
			end
		end

		player:warp(m, x, y)
		double_step_asn.act(player)
		sumo.walk(player)
	end,
	act = function(player)
		player:sendAction(6, 20)
		player:sendAnimation(280)
		--	player:sendAnimationXY(279, player.x, player.y)
		player:sendMinitext("You use Double Step")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Double Step allows you to quickly jump forward.", txt}
		return level, item, amounts, desc
	end
}
