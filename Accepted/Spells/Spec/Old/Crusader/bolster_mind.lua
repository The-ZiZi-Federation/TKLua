--[[
bolster_mind = {

on_learn = function(player) player.registry["bolster_mind"] = 1 end,
on_forget = function(player) player.registry["bolster_mind"] = 0 end,

cast = function(player, target)

	local magicCost = 1000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		player.magic = player.magic - magicCost
		target.basewill = target.basewill + 30
		player:sendStatus()
		player:calcStat()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Bolster Mind")
		target:sendAnimation(130)
		player:playSound(8)
		target:sendMinitext(player.name.." cast Bolster Mind on you")
		target:setDuration("bolster_mind", 600000)
	end
end,


uncast = function(player)

	player.basewill = player.basewill - 30
	player:calcStat() 
end
}]]
--
