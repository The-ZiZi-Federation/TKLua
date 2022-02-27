onKill = function(block, player)

	
	end_onKill(block, player)
	player.attacker = 0
	
	if (block.blType == BL_MOB) then
		if block.protection >= 2 then
			characterLog.bossKillLog(block, player)
		end
		--luckyFind(player)
		--worldDrops.drop(player, block)
	end

	if (block.blType == BL_PC) then
	--	war.onKill(player, block)
	end
end

-------------- on after killing something ----------------------------------------------------

onKillMsg = function(player, killTotal, total, questType)
	

end