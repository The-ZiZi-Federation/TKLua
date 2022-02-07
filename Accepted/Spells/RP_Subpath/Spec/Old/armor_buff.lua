--[[
armor_buff = {

on_learn = function(player) player.registry["armor_buff"] = 1 end,
on_forget = function(player) player.registry["armor_buff"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		player.magic = player.magic - magicCost
		target.armor = target.armor + 100
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast armor buff")
		target:sendAnimation(11)
		player:playSound(8)
		target:sendMinitext(player.name.." cast armor buff on you")
		player:setAether("armor_buff", 600000)
		target:setDuration("armor_buff", 600000)
	end
end,


uncast = function(player)

	player.armor = player.armor - 100
	player:calcStat() 
end
}
]]
--
