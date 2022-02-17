--[[
siphon_soul = {

on_learn = function(player) player.registry["learned_siphon_soul"]= 1 end,
on_forget = function(player) player.registry["learned_siphon_soul"]= 0 end,

cast = function(player, target)
	
	local duration = 16000
	local magicCost = 200 + player.level * 2
	local hitchance
	local aether = 0
	local anim = 199
	local sound = 71
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (target.state == 1 or target.blType ~= BL_MOB) then player:sendMinitext("Invalid Target") return end
	if(target.paralyzed==true) or target:hasDuration("siphon_soul") then player:sendMinitext("Spell already cast") player:sendAnimation(246) return end	

	player:sendAction(6, 20)
	player:playSound(sound)
	player:setAether("siphon_soul", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Siphon Soul")
	target:sendAnimation(anim)
	target.paralyzed = true
	target.registry["siphon_soul_caster"] = player.ID
	player:setDuration("siphon_soul", duration)
	target:setDuration("siphon_soul", duration)

end,

while_cast = function(player)
	local caster = player.registry["siphon_soul_caster"]
	
	if not Player(caster):hasDuration("siphon_soul") then
		player:setDuration("siphon_soul", 0)
	end
	
	player:removeHealth(100)
	player:sendAnimation(34)
	player.paralyzed = true
end,

while_cast_250 = function(player)

	--player.paralyzed = true
end,
	
uncast = function(player) 
	player.registry["siphon_soul_caster"] = 0
	player.paralyzed = false
	player:calcStat()


end,

cancel = function(player)
	if player:hasDuration("siphon_soul") then
		player:setDuration("siphon_soul", 0)
	end

end
}]]
--
