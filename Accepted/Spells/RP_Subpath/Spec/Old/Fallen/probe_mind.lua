--[[
probe_mind = {

on_learn = function(player) player.registry["probe_mind"] = 1 end,
on_forget = function(player) player.registry["probe_mind"] = 0 end,

cast = function(player, target)

	local magicCost = 1000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		player.magic = player.magic - magicCost
		target.basewill = target.basewill + 50
		player.basewill = player.basewill + 15
		player:sendStatus()
		player:calcStat()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Probe Mind")
		target:sendAnimation(294)
		player:playSound(8)
		target:sendMinitext(player.name.." cast Probe Mind on you")
		player:setDuration("mind_boost", 60000)
		player:setAether("probe_mind", 60000)
		target:setDuration("probe_mind", 60000)
	end
end,


uncast = function(player)

	player.basewill = target.basewill - 50
	player:calcStat() 
end
}





mind_boost = {

uncast = function(player)

	player.basewill = target.basewill - 15
	player:calcStat() 
end
}]]
--
