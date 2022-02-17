--[[
dre_locs_strength = {

cast = function(player, target)

	
	local magicCost = 1250
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target:hasDuration("dre_locs_strength") then player:sendMinitext("Already cast!") return end
	

	if target.blType == BL_PC then
		player:sendStatus()
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:setAether("dre_locs_strength", 45000)
		player:setDuration("dre_locs_strength", 90000)
		player:sendMinitext("You cast Dre Loc's Strength")
		target:sendAnimation(298)
		player:playSound(106)
		target.fury = target.fury + 3
		target:updateState()
		target:sendMinitext(player.name.." casts Dre Loc's Strength on you")
	end
end,

while_cast = function(player)

end,

uncast = function(player)

	if player.fury >= 5 then
		player.fury = player.fury - 3
	else
		player.fury = 1
	end

end
}]]
--
