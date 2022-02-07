swing = function(player)
	local mobUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local mobLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local mobRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local mobDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
	local mobUpExtend = player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)
	local mobLeftExtend = player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)
	local mobRightExtend = player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)
	local mobDownExtend = player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)
	local mobUpLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)
	local mobUpRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)
	local mobDownLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)
	local mobDownRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)
	local pcUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
	local pcLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)
	local pcRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)
	local pcDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
	local pcUpExtend = player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)
	local pcLeftExtend = player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)
	local pcRightExtend = player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)
	local pcDownExtend = player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)
	local pcUpLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)
	local pcUpRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)
	local pcDownLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)
	local pcDownRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)
	local extendHit = player.extendHit

	if (player.side == 0) then
		if (extendHit) then
			if (#mobUp > 0) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (#mobLeft > 0 and player.flank) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (#mobRight > 0 and player.flank) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobDown > 0 and player.backstab) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#pcUp > 0) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (#pcLeft > 0 and player.flank) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (#pcRight > 0 and player.flank) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcDown > 0 and player.backstab) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobLeft > 0 and player.flank) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#mobRight > 0 and player.flank) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#mobDown > 0 and player.backstab) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#pcLeft > 0 and player.flank) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (#pcRight > 0 and player.flank) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (#pcDown > 0 and player.backstab) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

		if (#mobUp > 0) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#pcUp > 0) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end
	elseif (player.side == 1) then
		if (extendHit) then
			if (#mobRight > 0) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobUp > 0 and player.flank) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (#mobDown > 0 and player.flank) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobLeft > 0 and player.backstab) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (#pcRight > 0) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcUp > 0 and player.flank) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (#pcDown > 0 and player.flank) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcLeft > 0 and player.backstab) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end
		end

		if (#mobUp > 0 and player.flank) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#mobDown > 0 and player.flank) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#mobLeft > 0 and player.backstab) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#pcUp > 0 and player.flank) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (#pcDown > 0 and player.flank) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

		if (#pcLeft > 0 and player.backstab) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (#mobRight > 0) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#pcRight > 0) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end
	elseif (player.side == 2) then
		if (extendHit) then
			if (#mobDown > 0) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobLeft > 0 and player.flank) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (#mobRight > 0 and player.flank) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobUp > 0 and player.backstab) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (#pcDown > 0) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcLeft > 0 and player.flank) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (#pcRight > 0 and player.flank) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcUp > 0 and player.backstab) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobLeft > 0 and player.flank) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#mobRight > 0 and player.flank) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#mobUp > 0 and player.backstab) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#pcLeft > 0 and player.flank) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (#pcRight > 0 and player.flank) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (#pcUp > 0 and player.backstab) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (#mobDown > 0) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#pcDown > 0) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end
	elseif (player.side == 3) then
		if (extendHit) then
			if (#mobLeft > 0) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (#mobUp > 0 and player.flank) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (#mobDown > 0 and player.flank) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#mobRight > 0 and player.backstab) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (#pcLeft > 0) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (#pcUp > 0 and player.flank) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (#pcDown > 0 and player.flank) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (#pcRight > 0 and player.backstab) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobUp > 0 and player.flank) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#mobDown > 0 and player.flank) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#mobRight > 0 and player.backstab) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#pcUp > 0 and player.flank) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (#pcDown > 0 and player.flank) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

		if (#pcRight > 0 and player.backstab) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (#mobLeft > 0) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#pcLeft > 0) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end
	end
end
