--[[
harm = {

on_learn = function(player) player.registry["learned_harm"] = 1 end,
on_forget = function(player) player.registry["learned_harm"] = 0 end,

cast = function(player, target)
	local fury = player.fury
	local damage = ((player.maxMagic*1.5)+(player.will*75))*fury
	local magicCost = 1500

	if not player:canCast(1,1,0) then return else
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then return else target:sendMinitext(player.name.." attacks you with Harm") end
		end
	end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	target.attacker = player.ID
	
	player:sendAction(6, 20)
	target:sendAnimation(287)
	player:playSound(71)
	target:removeHealthExtend(damage, 1,1,1,1,0)
	target.attacker = player.ID
	target:setDuration("stun", 4000)
	player.magic = player.magic - magicCost
	player:sendMinitext("You cast Harm")
	player:setAether("harm", 18000)
	player:sendStatus()
end
}
]]
--
