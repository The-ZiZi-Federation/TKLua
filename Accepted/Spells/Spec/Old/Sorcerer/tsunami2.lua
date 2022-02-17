--[[
tsunami2 = {

on_learn = function(player) player.registry["learned_tsunami2"] = 1 end,
on_forget = function(player) player.registry["learned_tsunami2"] = 0 end,

cast = function(player, target)
	
	local damage = ((player.maxMagic*3) + (player.will*300))*20
	local magicCost = player.maxMagic*0.35
	
	if not player:canCast(1,1,0) then return else
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then return else target:sendMinitext(player.name.." drops a Tsunami on you") end
		end
	end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	target.attacker = player.ID
	
	player:sendAction(6, 20)
	target:sendAnimation(406)
	player:playSound(73)
	target:removeHealthExtend(damage, 1,1,1,1,0)
	player.magic = player.magic - magicCost
	player:sendMinitext("You cast Tsunami Lv 2")
	player:setAether("tsunami2", 37000)
	player:sendStatus()
end
}]]
--
