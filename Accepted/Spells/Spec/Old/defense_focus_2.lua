--[[
--% block chance in playercombat

defense_focus_2 = {

on_learn = function(player) player.registry["defense_focus_2"] = 1 end,
on_forget = function(player) player.registry["defense_focus_2"] = 0 end,

cast = function(player)

	local magicCost = 1500
	local duration = 600000


	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("defense_focus_2") then alreadyCast(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(20)
	player:playSound(57)
	player:setDuration("defense_focus_2", duration)
	player:calcStat()
	player:sendMinitext("You cast Defense Focus Lv2")
end,

uncast = function(player)
	player:sendMinitext("Your defensive focus begins to fade")
end
}
]]
--
