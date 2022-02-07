--[[
dark_curse = {

on_learn = function(player) player.registry["learned_dark_curse"] = 1 end,
on_forget = function(player) player.registry["learned_dark_curse"] = 0 end,

cast = function(player, target)
	local fury = player.fury
	local damage = ((player.maxHealth*1.75)+(player.maxMagic*0.75)+(player.will*80))*fury
	local magicCost = 5000


	if not player:canCast(1,1,0) then return else
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then return else target:sendMinitext(player.name.." attacks you with Dark Curse") end
		end
	end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost	
	target.attacker = player.ID
	
	player:sendAction(6, 20)
	player:sendAnimation(267)
	target:sendAnimation(310)
	target:sendAnimation(309)
	player:playSound(71)
--	target:setDuration("stun", 6000)
	target:removeHealthExtend(damage, 1,1,1,1,0)
	target.attacker = player.ID
	target.blind = 1

	player:sendMinitext("You cast Dark Curse")
	player:setAether("dark_curse", 25000)
	player:sendStatus()
end
}]]
--
