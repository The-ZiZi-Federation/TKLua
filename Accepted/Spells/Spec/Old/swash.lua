--[[

swash = {

    on_learn = function(player) player.registry["learned_swash"] = 1 end,
    on_forget = function(player) player.registry["learned_swash"] = 0 end,

cast = function(player)



	if not player:canCast(1,1,0) then player:sendAnimation(246) return end
	
	local magicCost = 600

	if player.magic < magicCost then notEnoughMP(player) return end	
	
	player:setDuration("swash", 1000)
	player.magic = player.magic - magicCost
	player:sendStatus()
	swash_warp(player)
	
--	player:setAether("swash", 14000)
	player:playSound(358)
	player:sendAnimationXY(285, player.x, player.y)
	player:playSound(357)
	
end,

uncast = function(player)

	swash_warp(player)
--	player:setDuration("swash", 333)

end
}


swash_warp = function(player)

	local s, x, m, y = player.side, player.x, player.m, player.y
	local mob

	if s == 0 then
		if getPass(m,x,y-1) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-1, 0) then
			if getPass(m,x,y-2) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-2, 0) then
				if getPass(m,x,y-3) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-3, 0) then
					if getPass(m,x,y-4) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-4, 0) then
						for i = 1, 3 do player:sendAnimationXY(257,x,y-i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end							
						end
						player:warp(m,x,y-4)
						player.side = 2
						player:sendSide()		
					else
						for i = 1, 3 do player:sendAnimationXY(257,x,y-i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end
						end
						player:warp(m,x,y-3)
						player.side = 2
						player:sendSide()
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x,y-i)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						if mob ~= nil then removeHealthswash(player, mob) end	
					end
					player:warp(m,x,y-2)
					player.side = 2
					player:sendSide()
				end
			else
				player:sendAnimationXY(257,x,y-1)
				player:warp(m,x,y-1)
				player.side = 2
				player:sendSide()
			end
		end
		player:sendAction(1, 20)
			
	elseif s == 1 then
		if getPass(m,x+1,y) == 0 then
			if getPass(m,x+2,y) == 0 then
				if getPass(m,x+3,y) == 0 then
					if getPass(m,x+4,y) == 0 then
						for i = 1, 3 do player:sendAnimationXY(257,x+i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						    if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x+4,y)
						player.side = 3
						player:sendSide()		
					else
						for i = 1, 3 do player:sendAnimationXY(257,x+i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x+3,y)
						player.side = 3
						player:sendSide()
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x+i,y)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						if mob ~= nil then removeHealthswash(player, mob) end	
					end
					player:warp(m,x+2,y)
					player.side = 3
					player:sendSide()
				end
			else
				player:sendAnimationXY(257,x+1,y)
				player:warp(m,x+1,y)
				player.side = 3
				player:sendSide()
			end
		end
		player:sendAction(1, 20)
		
	elseif s == 2 then
		if getPass(m,x,y+1) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+1,0) then
			if getPass(m,x,y+2) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+2,0) then
				if getPass(m,x,y+3) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+3,0) then
					if getPass(m,x,y+4) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+4,0) then
						for i = 1, 3 do player:sendAnimationXY(257,x,y+i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x,y+4)
						player.side = 0
						player:sendSide()
					else
						for i = 1, 3 do player:sendAnimationXY(257,x,y+i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x,y+3)
						player.side = 0
						player:sendSide()
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x,y+i)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						if mob ~= nil then removeHealthswash(player, mob) end	
					end
					player:warp(m,x,y+2)
					player.side = 0
					player:sendSide()
				end
			else
				player:sendAnimationXY(257,x,y+1)
				player:warp(m,x,y+1)
				player.side = 0
				player:sendSide()
			end
		end	
		player:sendAction(1, 20)
	elseif s == 3 then
		if getPass(m,x-1,y) == 0 then
			if getPass(m,x-2,y) == 0 then
				if getPass(m,x-3,y) == 0 then
					if getPass(m,x-4,y) == 0 then
						for i = 1, 3 do player:sendAnimationXY(257,x-i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						    if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x-4,y)
						player.side = 1
						player:sendSide()
					else
						for i = 1, 3 do player:sendAnimationXY(257,x-i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
							if mob ~= nil then removeHealthswash(player, mob) end	
						end
						player:warp(m,x-3,y)
						player.side = 1
						player:sendSide()
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x-i,y)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthswash(player, pc) end
						if mob ~= nil then removeHealthswash(player, mob) end	
					end
					player:warp(m,x-2,y)
					player.side = 1
					player:sendSide()
				end
			else
				player:sendAnimationXY(257,x-1,y)
				player:warp(m,x-1,y)
				player.side = 1
				player:sendSide()
			end
		end	
	end
	player:sendAction(1, 20)
end


removeHealthswash = function(player, block)
	local fury = player.fury
	local damage = ((player.maxHealth)+(player.grace*100))*fury
	local threat
	
	block.attacker = player.ID
	if block.blType == BL_MOB then
		threat = block:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(block.ID, threat)
		block:removeHealthExtend(damage, 1,1,1,1,0)
	elseif block.blType == BL_PC then
		if player:canPK(block) and block.state ~= 1 then
			block:removeHealthExtend(damage, 1,1,1,1,0)
			block:sendMinitext(player.name.." attacks you with swash")
		end
	end
end

]]
--
