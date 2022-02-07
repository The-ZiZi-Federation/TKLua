--[[
weapon_focus_2 = {

on_learn = function(player) player.registry["learned_weapon_focus"] = 1 end,
on_forget = function(player) player.registry["learned_weapon_focus"] = 0 end,

cast = function(player)

	local magicCost = 1500
	local duration = 600000


	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("weapon_focus_2") then alreadyCast(player) return end

	player:sendAction(6, 20) 
	player.magic = player.magic - magicCost
    player:sendStatus()
    player:sendAnimation(326)
    player:playSound(37)
	player:setDuration("weapon_focus_2", duration)
	player:calcStat()
    player:sendMinitext("You cast Weapon Focus Lv2")

end,


recast = function(player)

	player.might = player.might + 15

end,


uncast = function(player)


	player.might = player.might - 15	
	player:calcStat()
	player:sendMinitext("Your focus begins to fade")
end
}]]
--
