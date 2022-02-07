--[[
bone_armor_old = {

on_learn = function(player) player.registry["bone_armor"] = 1 end,
on_forget = function(player) player.registry["bone_armor"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		player.magic = player.magic - magicCost
		target.basearmor = target.basearmor + 100
		player:sendStatus()
		player:calcStat()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Bone Armor")
		target:sendAnimation(408)
		target:sendAnimation(293)
		player:playSound(8)
		target:sendMinitext(player.name.." casts Bone Armor on you")
		player:setAether("bone_armor", 600000)
		target:setDuration("bone_armor", 600000)
	end
end,


uncast = function(player)

	player.basearmor = player.basearmor - 100
	player:calcStat() 
end
}
]]
--
