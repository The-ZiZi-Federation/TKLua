--[[
hurricane = {

on_learn = function(player) player.registry["learned_hurricane"] = 1 end,
on_forget = function(player) player.registry["learned_hurricane"] = 0 end,

cast = function(player, target)
	
	local damage = ((player.maxMagic*3.5) + (player.will*300))*15
	local magicCost = player.maxMagic*0.35
	
	if not player:canCast(1,1,0) then return else
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then return else target:sendMinitext(player.name.." drops a Hurricane on you") end
		end
	end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	target.attacker = player.ID
	
	player:sendAction(6, 20)
	target:sendAnimation(200)
	player:playSound(73)
	target:removeHealthExtend(damage, 1,1,1,1,0)
	player.magic = player.magic - magicCost
	player:sendMinitext("You cast Hurricane")
	player:setAether("hurricane", 37000)
	player:sendStatus()
end
}]]
--
