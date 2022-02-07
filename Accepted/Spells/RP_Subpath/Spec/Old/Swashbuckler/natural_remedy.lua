--[[
natural_remedy = {

on_learn = function(player) 
	
	if (player:hasSpell("herbal_stimulant")) then
		player:removeSpell("herbal_stimulant")
	end
	
	player.registry["learned_natural_remedy"] = 1 
end,

on_forget = function(player) 
	
	player.registry["learned_natural_remedy"] = 0 
end,

cast = function(player)

	local heal = 1500
	local magicCost = 230
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(7, 20)
	player.magic = player.magic - magicCost
	player:sendAnimation(259)
	player:playSound(3)
	addHealth(player, heal)
	player:sendMinitext("You use Natural Remedy")

end
}]]
--
