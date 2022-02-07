--[[

cutlass_blitz = {

    on_learn = function(player) player.registry["learned_cutlass_blitz"] = 1 end,
    on_forget = function(player) player.registry["learned_cutlass_blitz"] = 0 end,

cast = function(player)


	if not player:canCast(1,1,0) then player:sendAnimation(246) return end
	
	local magicCost = 600

	if player.magic < magicCost then notEnoughMP(player) return end	
	
	player:setDuration("cutlass_blitz", 2000)
	player.magic = player.magic - magicCost
	player:sendStatus()
	cutlass_blitz_warp(player)
	player.paralyzed = true
	player:setAether("cutlass_blitz", 14000)
	player:playSound(358)
	player:sendAnimationXY(285, player.x, player.y)
	player:playSound(357)
	
end,

while_cast = function(player)
	player.paralyzed = true
	cutlass_blitz_warp(player)
--	player:setDuration("cutlass_blitz", 333)

end,

uncast = function(player)

	player.paralyzed = false

end
}


cutlass_blitz_warp = function(player)

	local mob1, mob2, mob3, mob4 = getTargetFacing(player, BL_MOB), getTargetFacing(player, BL_MOB, 0, 2), getTargetFacing(player, BL_MOB, 0, 3), getTargetFacing(player, BL_MOB, 0, 4)
	local pc1, pc2, pc3, pc4 = getTargetFacing(player, BL_PC), getTargetFacing(player, BL_PC, 0, 2), getTargetFacing(player, BL_PC, 0, 3), getTargetFacing(player, BL_PC, 0, 4)
	local magicCost = 600


	local s, x, m, y = player.side, player.x, player.m, player.y
	local mob

	if s == 0 then
		if getPass(m,x,y-1) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-1, 0) then
			if getPass(m,x,y-2) == 0 and not getWarp(m,x,y-2) and player:objectCanMove(x,y-2, 0) then
				if getPass(m,x,y-3) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-3, 0) then
					if getPass(m,x,y-4) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-4, 0) then
						if mob4 == nil and pc4 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x,y-i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end							
							end
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x,y-4)
						end				
					else
						if mob3 == nil and pc3 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x,y-i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end
							end
	
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x,y-3)
						end
					end
				else
					if mob2 == nil and pc2 == nil then
						for i = 1, 2 do player:sendAnimationXY(32,x,y-i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
							if mob ~= nil then cb_hit(player, mob) end	
						end
	
						player.magic = player.magic - magicCost
						player:setAether("cutlass_blitz", 13000)
						player:sendStatus()
						player:warp(m,x,y-2)
					end
				end
			else
				if mob == nil and pc == nil then
					player:sendAnimationXY(32,x,y-1)
					player.magic = player.magic - magicCost
					player:setAether("cutlass_blitz", 13000)
					player:sendStatus()
					player:warp(m,x,y-1)
				end
			end
			player:sendAction(1, 20)
		else
			player:sendMinitext("Nowhere to jump!")
		end
			
	elseif s == 1 then
		if getPass(m,x+1,y) == 0 and not getWarp(m,x+1,y) and player:objectCanMove(x+1,y, 0) then
			if getPass(m,x+2,y) == 0 and not getWarp(m,x+2,y) and player:objectCanMove(x+2,y, 0) then
				if getPass(m,x+3,y) == 0 and not getWarp(m,x+3,y) and player:objectCanMove(x+3,y, 0) then
					if getPass(m,x+4,y) == 0 and not getWarp(m,x+4,y) and player:objectCanMove(x+4,y, 0) then
						if mob4 == nil and pc4 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x+i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end							
							end
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x+4,y)
						end				
					else
						if mob3 == nil and pc3 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x+i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end
							end
	
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x+3,y)
						end
					end
				else
					if mob2 == nil and pc2 == nil then
						for i = 1, 2 do player:sendAnimationXY(32,x+i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
							if mob ~= nil then cb_hit(player, mob) end	
						end
	
						player.magic = player.magic - magicCost
						player:setAether("cutlass_blitz", 13000)
						player:sendStatus()
						player:warp(m,x+2,y)
					end
				end
			else
				if mob == nil and pc == nil then
					player:sendAnimationXY(32,x+1,y)
					player.magic = player.magic - magicCost
					player:setAether("cutlass_blitz", 13000)
					player:sendStatus()
					player:warp(m,x+1,y)
				end
			end
			player:sendAction(1, 20)
		else
			player:sendMinitext("Nowhere to jump!")
		end
	elseif s == 2 then
		if getPass(m,x,y+1) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+1, 0) then
			if getPass(m,x,y+2) == 0 and not getWarp(m,x,y+2) and player:objectCanMove(x,y+2, 0) then
				if getPass(m,x,y+3) == 0 and not getWarp(m,x,y+3) and player:objectCanMove(x,y+3, 0) then
					if getPass(m,x,y+4) == 0 and not getWarp(m,x,y+4) and player:objectCanMove(x,y+4, 0) then
						if mob4 == nil and pc4 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x,y+i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end							
							end
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x,y+4)
						end				
					else
						if mob3 == nil and pc3 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x,y+i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end
							end
	
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x,y+3)
						end
					end
				else
					if mob2 == nil and pc2 == nil then
						for i = 1, 2 do player:sendAnimationXY(32,x,y+i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
							if mob ~= nil then cb_hit(player, mob) end	
						end
	
						player.magic = player.magic - magicCost
						player:setAether("cutlass_blitz", 13000)
						player:sendStatus()
						player:warp(m,x,y+2)
					end
				end
			else
				if mob == nil and pc == nil then
					player:sendAnimationXY(32,x,y+1)
					player.magic = player.magic - magicCost
					player:setAether("cutlass_blitz", 13000)
					player:sendStatus()
					player:warp(m,x,y+1)
				end
			end
			player:sendAction(1, 20)
		else
			player:sendMinitext("Nowhere to jump!")
		end
	elseif s == 3 then
		if getPass(m,x-1,y) == 0 and not getWarp(m,x-1,y) and player:objectCanMove(x-1,y, 0) then
			if getPass(m,x-2,y) == 0 and not getWarp(m,x-2,y) and player:objectCanMove(x-2,y, 0) then
				if getPass(m,x-3,y) == 0 and not getWarp(m,x-3,y) and player:objectCanMove(x-3,y, 0) then
					if getPass(m,x-4,y) == 0 and not getWarp(m,x-4,y) and player:objectCanMove(x-4,y, 0) then
						if mob4 == nil and pc4 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x-i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end							
							end
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x-4,y)
						end				
					else
						if mob3 == nil and pc3 == nil then
							for i = 1, 3 do player:sendAnimationXY(32,x-i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
								if mob ~= nil then cb_hit(player, mob) end
							end
	
							player.magic = player.magic - magicCost
							player:setAether("cutlass_blitz", 13000)
							player:sendStatus()
							player:warp(m,x-3,y)
						end
					end
				else
					if mob2 == nil and pc2 == nil then
						for i = 1, 2 do player:sendAnimationXY(32,x-i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then cb_hit(player, pc) end
							if mob ~= nil then cb_hit(player, mob) end	
						end
	
						player.magic = player.magic - magicCost
						player:setAether("cutlass_blitz", 13000)
						player:sendStatus()
						player:warp(m,x-2,y)
					end
				end
			else
				if mob == nil and pc == nil then
					player:sendAnimationXY(32,x-1,y)
					player.magic = player.magic - magicCost
					player:setAether("cutlass_blitz", 13000)
					player:sendStatus()
					player:warp(m,x-1,y)
				end
			end
			player:sendAction(1, 20)
		else
			player:sendMinitext("Nowhere to jump!")
		end
	end
		
end


cb_hit = function(player, block)
	local fury = player.fury
	local damage = ((player.maxHealth)+(player.might*100))*fury
	local threat
	
	block.attacker = player.ID
	if block.blType == BL_MOB then
		threat = block:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(block.ID, threat)
		block:removeHealthExtend(damage, 1,1,1,1,0)
	elseif block.blType == BL_PC then
		if player:canPK(block) and block.state ~= 1 then
			block:removeHealthExtend(damage, 1,1,1,1,0)
			block:sendMinitext(player.name.." attacks you with Cutlass Blitz")
		end
	end
end
]]
--
