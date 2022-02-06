function findClearPath(side, m, x, y, target, tries, animation)

	local timesTried = tries
	local anim = animation or 0
	
--Player(4):talk(0,"tries: "..timesTried)
	if tries >= 150 then 
--Player(4):talk(0,"Too many tries!")	
		return 0 
	end

	local found = false
	local canmove = 0
	local checkmove = math.random(0,2)
	
--Player(4):talk(0,"My M: "..m)
--Player(4):talk(0,"My X: "..x)	
--Player(4):talk(0,"My Y: "..y)	

--Player(4):talk(0,"Target M: "..target.m)
--Player(4):talk(0,"Target X: "..target.x)	
--Player(4):talk(0,"Target Y: "..target.y)	

	local pcNorth = core:getObjectsInCell(m, x, y - 1, BL_PC)
	local pcSouth = core:getObjectsInCell(m, x, y + 1, BL_PC)
	local pcEast = core:getObjectsInCell(m, x + 1, y, BL_PC)
	local pcWest = core:getObjectsInCell(m, x - 1, y, BL_PC)
	
	local mobNorth = core:getObjectsInCell(m, x, y - 1, BL_MOB)
	local mobSouth = core:getObjectsInCell(m, x, y + 1, BL_MOB)
	local mobEast = core:getObjectsInCell(m, x + 1, y, BL_MOB)
	local mobWest = core:getObjectsInCell(m, x - 1, y, BL_MOB)
	
--Player(4):talk(0,"START")	
	if #pcNorth > 0 then
		for i = 1, #pcNorth do
			if pcNorth[i].ID == target.ID then
				found = true
			end
		end
	end

	if #pcSouth > 0 then
		for i = 1, #pcSouth do
			if pcSouth[i].ID == target.ID then
				found = true
			end
		end
	end

	if #pcEast > 0 then
		for i = 1, #pcEast do
			if pcEast[i].ID == target.ID then
				found = true
			end
		end
	end

	if #pcWest > 0 then
		for i = 1, #pcWest do
			if pcWest[i].ID == target.ID then
				found = true
			end
		end
	end

	if #mobNorth > 0 then
		for i = 1, #mobNorth do
			if mobNorth[i].ID == target.ID then
				found = true
			end
		end
	end

	if #mobSouth > 0 then
		for i = 1, #mobSouth do
			if mobSouth[i].ID == target.ID then
				found = true
			end
		end
	end

	if #mobEast > 0 then
		for i = 1, #mobEast do
			if mobEast[i].ID == target.ID then
				found = true
			end
		end
	end

	if #mobWest > 0 then
		for i = 1, #mobWest do
			if mobWest[i].ID == target.ID then
				found = true
			end
		end
	end


	if found == true then		
		return 1
	else

		if side == 0 or side == 2 then

			if(y < target.y) then
				if getPass(m, x, y + 1) == 0 then
					y = y + 1
					target:sendAnimationXY(anim, x, y)
					canmove = 1
					if side < 3 then
						tries = tries + 1
						return findClearPath(side + 1, m, x, y, target, tries, anim)
					else
						tries = tries + 1
						return findClearPath(0, m, x, y, target, tries, anim)
					end

				else
					if side < 3 then
						tries = tries + 1
						return findClearPath(side + 1, m, x, y, target, tries, anim)
					else
						tries = tries + 1
						return findClearPath(0, m, x, y, target, tries, anim)
					end
				end
			else
				if(y > target.y and canmove == 0) then
					if getPass(m, x, y - 1) == 0 then
						y = y - 1
						target:sendAnimationXY(anim, x, y)
						canmove = 1
						tries = tries + 1
						if side < 3 then
							tries = tries + 1
							return findClearPath(side + 1, m, x, y, target, tries, anim)
						else
							tries = tries + 1
							return findClearPath(0, m, x, y, target, tries, anim)
						end
					else
						if side < 3 then
							tries = tries + 1
							return findClearPath(side + 1, m, x, y, target, tries, anim)
						else
							tries = tries + 1
							return findClearPath(0, m, x, y, target, tries, anim)
						end
					end
				else
					if(x < target.x and canmove == 0) then
						if getPass(m, x + 1, y) == 0 then
							x = x + 1
							target:sendAnimationXY(anim, x, y)
							canmove = 1
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end
						else	
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end
						end
					else
						if(x > target.x and canmove == 0) then
							if getPass(m, x - 1, y) == 0 then
								x = x - 1
								target:sendAnimationXY(anim, x, y)
								canmove = 1
								if side < 3 then
									tries = tries + 1
									return findClearPath(side + 1, m, x, y, target, tries, anim)
								else
									tries = tries + 1
									return findClearPath(0, m, x, y, target, tries, anim)
								end
							else
								if side < 3 then
									tries = tries + 1
									return findClearPath(side + 1, m, x, y, target, tries, anim)
								else
									tries = tries + 1
									return findClearPath(0, m, x, y, target, tries, anim)
								end
							end
						else
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end
						end
					end
				end
			end

		elseif side == 1 or side == 3 then
			if(x < target.x) then
				if getPass(m, x + 1, y) == 0 then
					x = x + 1
					target:sendAnimationXY(anim, x, y)
					canmove = 1
					tries = tries + 1
					if side < 3 then
						tries = tries + 1
						return findClearPath(side + 1, m, x, y, target, tries, anim)
					else
						tries = tries + 1
						return findClearPath(0, m, x, y, target, tries, anim)
					end
				else	
					if side < 3 then
						tries = tries + 1
						return findClearPath(side + 1, m, x, y, target, tries, anim)
					else
						tries = tries + 1
						return findClearPath(0, m, x, y, target, tries, anim)
					end
				end
			else
			
				if(x > target.x and canmove == 0) then
					if getPass(m, x - 1, y) == 0 then
						x = x - 1
						target:sendAnimationXY(anim, x, y)
						canmove = 1
						if side < 3 then
							tries = tries + 1
							return findClearPath(side + 1, m, x, y, target, tries, anim)
						else
							tries = tries + 1
							return findClearPath(0, m, x, y, target, tries, anim)
						end
					else	
						if side < 3 then
							tries = tries + 1
							return findClearPath(side + 1, m, x, y, target, tries, anim)
						else
							tries = tries + 1
							return findClearPath(0, m, x, y, target, tries, anim)
						end
					end
				else
					if(y < target.y and canmove == 0) then
						if getPass(m, x, y + 1) == 0 then
							y = y + 1
							target:sendAnimationXY(anim, x, y)
							canmove = 1
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end
						else	
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end	
						end
					else
						if(y > target.y and canmove == 0) then
							if getPass(m, x, y - 1) == 0 then
								y = y - 1
								target:sendAnimationXY(anim, x, y)
								canmove = 1
								if side < 3 then
									tries = tries + 1
									return findClearPath(side + 1, m, x, y, target, tries, anim)
								else
									tries = tries + 1
									return findClearPath(0, m, x, y, target, tries, anim)
								end
							else
								if side < 3 then
									tries = tries + 1
									return findClearPath(side + 1, m, x, y, target, tries, anim)
								else
									tries = tries + 1
									return findClearPath(0, m, x, y, target, tries, anim)
								end
							end
							
						else
							if side < 3 then
								tries = tries + 1
								return findClearPath(side + 1, m, x, y, target, tries, anim)
							else
								tries = tries + 1
								return findClearPath(0, m, x, y, target, tries, anim)
							end
						end
					end
				end
			end
		end
	end
end