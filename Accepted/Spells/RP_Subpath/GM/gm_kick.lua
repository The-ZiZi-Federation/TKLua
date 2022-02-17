gm_kick = {
	cast = function(player)
		local pc, mob, npc = getTargetFacing(player, BL_PC), getTargetFacing(player, BL_MOB), getTargetFacing(player, BL_NPC)

		player:sendAction(3, 20)
		player:sendFrontAnimation(170, player.side, 1)

		if pc ~= nil then
			if pc.registry["can_be_push"] > 0 then
				anim(player)
				pushBack(player)
				return
			else
				gm_kick.push(player, pc)
			end
		elseif mob ~= nil then
			gm_kick.push(player, mob)
		elseif npc ~= nil then
			gm_kick.push(player, npc)
		end
	end,
	push = function(player, target)
		local dura = {"warp_atas", "warp_kanan", "warp_bawah", "warp_kiri"}

		for i = 1, #dura do
			if target:hasDuration(dura[i]) then
				return false
			end
		end
		if player.side == 0 then
			target:setDuration("warp_atas", 30000)
		elseif player.side == 1 then
			target:setDuration("warp_kanan", 30000)
		elseif player.side == 2 then
			target:setDuration("warp_bawah", 30000)
		elseif player.side == 3 then
			target:setDuration("warp_kiri", 30000)
		end
	end
}

warp_atas = {
	while_cast_125 = function(player)
		if getPass(player.m, player.x, player.y - 1) == 1 then
			player:setDuration("warp_atas", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x, player.y - 1)
		end
	end,
	while_cast_250 = function(player)
		if getPass(player.m, player.x, player.y - 1) == 1 then
			player:setDuration("warp_atas", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x, player.y - 1)
		end
	end
}

warp_bawah = {
	while_cast_125 = function(player)
		if getPass(player.m, player.x, player.y + 1) == 1 then
			player:setDuration("warp_bawah", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x, player.y + 1)
		end
	end,
	while_cast_250 = function(player)
		if getPass(player.m, player.x, player.y + 1) == 1 then
			player:setDuration("warp_bawah", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x, player.y + 1)
		end
	end
}
warp_kanan = {
	while_cast_125 = function(player)
		if getPass(player.m, player.x + 1, player.y) == 1 then
			player:setDuration("warp_kanan", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x + 1, player.y)
		end
	end,
	while_cast_250 = function(player)
		if getPass(player.m, player.x + 1, player.y) == 1 then
			player:setDuration("warp_kanan", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x + 1, player.y)
		end
	end
}
warp_kiri = {
	while_cast_125 = function(player)
		if getPass(player.m, player.x - 1, player.y) == 1 then
			player:setDuration("warp_kiri", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x - 1, player.y)
		end
	end,
	while_cast_250 = function(player)
		if getPass(player.m, player.x - 1, player.y) == 1 then
			player:setDuration("warp_kiri", 0)
		else
			player:sendAnimationXY(190, player.x, player.y)
			player:warp(player.m, player.x - 1, player.y)
		end
	end
}
