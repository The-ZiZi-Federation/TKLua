--[[
haste = {

on_learn = function(player) player.registry["haste"] = 1 end,
on_forget = function(player) player.registry["haste"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast haste")
		player:playSound(8)
		player:setAether("haste", 60000)
		target.speed = 75
		--target:sendStatus()
		--target:calcStat() 
		--target:updateState()
		target:refresh()
		target:sendAnimation(11)
		target:sendMinitext(player.name.." cast haste on you")
		target:setDuration("haste", 60000)
	end
end,


while_cast = function(player)

	player.speed = 20
	player.attackSpeed = 10

end,

uncast = function(player)

	player.speed = 90
	player:sendStatus()
	player:calcStat()
	player:refresh() 
end
}]]
--
