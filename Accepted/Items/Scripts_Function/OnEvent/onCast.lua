onCast = function(player)
	
	local target = player:getBlock(player.target)
	
--	if player.m == 1 then
--		player:talk(0,""..target.name)
--	end	
	
	if target.owner > 0 then player:sendMinitext("You can't hurt a summoned creature!") player.target = nil return end
	
	if target ~= nil then
		hitCritChance(player, target)
	end
--	if player.state == 2 then
--		if player:hasDuration("hide_in_shadows") then player:setDuration("hide_in_shadows", 0) end
--	end
	
end