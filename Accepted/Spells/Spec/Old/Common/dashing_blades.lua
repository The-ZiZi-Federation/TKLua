--[[

dashing_blades = {

    on_learn = function(player) player.registry["learned_dashing_blades"] = 1 end,
    on_forget = function(player) player.registry["learned_dashing_blades"] = 0 end,

cast = function(player)



	if not player:canCast(1,1,0) then player:sendAnimation(246) return end
	
	local magicCost = 500

	if player.magic < magicCost then notEnoughMP(player) return end	
	

	dashing_blades_warp(player)

	player:playSound(358)
	player:sendAnimationXY(285, player.x, player.y)
	player:playSound(357)
	
end
}


dashing_blades_warp = function(player)

	
	local mob1, mob2, mob3, mob4 = getTargetFacing(player, BL_MOB), getTargetFacing(player, BL_MOB, 0, 2), getTargetFacing(player, BL_MOB, 0, 3), getTargetFacing(player, BL_MOB, 0, 4)
	local pc1, pc2, pc3, pc4 = getTargetFacing(player, BL_PC), getTargetFacing(player, BL_PC, 0, 2), getTargetFacing(player, BL_PC, 0, 3), getTargetFacing(player, BL_PC, 0, 4)
	local magicCost = 600


	local s, x, m, y = player.side, player.x, player.m, player.y
	local mob

	if s == 0 then
		if getPass(m,x,y-2) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-2, 0) then
			if mob2 == nil and pc2 == nil then
				for i = 1, 1 do player:sendAnimationXY(394,x,y-i)
					mob = getTargetFacing(player, BL_MOB, 0, i)
					pc = getTargetFacing(player, BL_PC, 0, i)
					if pc ~= nil and player:canPK(pc) then db_hit(player, pc) end
					if mob ~= nil then db_hit(player, mob) end	
				end

				player.magic = player.magic - magicCost
			--	player:setAether("dashing_blades", 1000)
				player:sendStatus()
				player:warp(m,x,y-2)
				player:sendAction(1, 20)
			end
		end
	elseif s == 1 then
		if getPass(m,x+2,y) == 0 and not getWarp(m,x+1,y) and player:objectCanMove(x+2,y, 0) then
			if mob2 == nil and pc2 == nil then
				for i = 1, 1 do player:sendAnimationXY(394,x+i,y)
					mob = getTargetFacing(player, BL_MOB, 0, i)
					pc = getTargetFacing(player, BL_PC, 0, i)
					if pc ~= nil and player:canPK(pc) then db_hit(player, pc) end
					if mob ~= nil then db_hit(player, mob) end	
				end

				player.magic = player.magic - magicCost
			--	player:setAether("dashing_blades", 1000)
				player:sendStatus()
				player:warp(m,x+2,y)
				player:sendAction(1, 20)
			end
		end		
	elseif s == 2 then
		if getPass(m,x,y+2) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+2, 0) then
			if mob2 == nil and pc2 == nil then
				for i = 1, 1 do player:sendAnimationXY(394,x,y+i)
					mob = getTargetFacing(player, BL_MOB, 0, i)
					pc = getTargetFacing(player, BL_PC, 0, i)
					if pc ~= nil and player:canPK(pc) then db_hit(player, pc) end
					if mob ~= nil then db_hit(player, mob) end	
				end

				player.magic = player.magic - magicCost
			--	player:setAether("dashing_blades", 1000)
				player:sendStatus()
				player:warp(m,x,y+2)
				player:sendAction(1, 20)
			end
		end
	elseif s == 3 then
		if getPass(m,x-2,y) == 0 and not getWarp(m,x-1,y) and player:objectCanMove(x-2,y, 0) then
			if mob2 == nil and pc2 == nil then
				for i = 1, 1 do player:sendAnimationXY(394,x-i,y)
					mob = getTargetFacing(player, BL_MOB, 0, i)
					pc = getTargetFacing(player, BL_PC, 0, i)
					if pc ~= nil and player:canPK(pc) then db_hit(player, pc) end
					if mob ~= nil then db_hit(player, mob) end	
				end

				player.magic = player.magic - magicCost
			--	player:setAether("dashing_blades", 1000)
				player:sendStatus()
				player:warp(m,x-2,y)
				player:sendAction(1, 20)
			end
		end
	end		
end

db_hit = function(player, block)
	local fury = player.fury
	local damage = ((player.maxHealth*0.25)+(player.grace*25))*fury
	local threat
	local m = block.m
	local x = block.x
	local y = block.y
	
	block.attacker = player.ID
	if block.blType == BL_MOB then
		threat = block:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(block.ID, threat)
		block:sendAnimation(89, x, y)
		block:removeHealthExtend(damage, 1,1,1,1,0)
	elseif block.blType == BL_PC then
		if player:canPK(block) and block.state ~= 1 then
			block:sendAnimationXY(89, x, y)
			block:removeHealthExtend(damage, 1,1,1,1,0)
			block:sendMinitext(player.name.." dodges and strikes")
		end
	end
end
]]
--
