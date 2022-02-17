--[[
quickness = {

on_learn = function(player) player.registry["quickness"] = 1 end,
on_forget = function(player) player.registry["quickness"] = 0 end,

cast = function(player)

	local magicCost = 2000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(6, 20)
	player:sendMinitext("You cast Quickness")
	player:setDuration("quickness", 30000)
	player:playSound(8)
	player:sendAnimation(11)
	player:setAether("quickness", 60000)
	player.speed = 75
	--target:sendStatus()
	--target:calcStat() 
	--target:updateState()
	player:refresh()

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
