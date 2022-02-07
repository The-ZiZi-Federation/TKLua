--[[
conjure_life_shitty = {

on_learn = function(player) 
	
	if (player:hasSpell("magus_heal")) then
		player:removeSpell("magus_heal")
	end
	
	player.registry["learned_conjure_life"] = 1 
end,

on_forget = function(player) 
	
	player.registry["learned_conjure_life"] = 0 
end,

cast = function(player)

	local heal = 1400
	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(136)
	player:playSound(3)
	addHealth(player, heal)
	player:sendMinitext("You cast Conjure Life")

end
}]]
--
