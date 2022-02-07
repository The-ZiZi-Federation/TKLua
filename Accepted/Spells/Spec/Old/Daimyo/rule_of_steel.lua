--[[
rule_of_steel = {

on_learn = function(player) 
	
	if (player:hasSpell("advanced_first_aid")) then
		player:removeSpell("advanced_first_aid")
	end
	
	player.registry["learned_rule_of_steel"] = 1 
end,

on_forget = function(player) 
	
	player.registry["learned_rule_of_steel"] = 0 
end,

cast = function(player)

	local heal = 1200
	local magicCost = 200
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendAnimation(249)
	player:playSound(3)
	addHealth(player, heal)
	player:sendMinitext("You cast Rule of Steel")

end
}]]
--
