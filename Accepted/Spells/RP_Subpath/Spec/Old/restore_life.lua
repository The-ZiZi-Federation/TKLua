--[[
restore_life = {

cast = function(player, target)

	local magicCost = 2000
	local hp = target.maxHealth*.50
	local mp = target.maxMagic*.50
	
	if not player:canCast(1,1,0) then return else
		if player.state == 1 or player.health <= 0 then return end
		if player.magic < magicCost then notEnoughMP(player) return else
			if target.blType ~= BL_PC or target.ID == player.ID then
				player:sendMinitext("Invalid Target!")
			return else
				if target.state == 1 then
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendAction(6, 20)
					target.state = 0
					target.health = hp
					target.magic = mp
					target:sendStatus()
					target:updateState()
					target:sendAnimation(96)
					player:playSound(112)
					player:setAether("restore_life", 30000)
					player:sendMinitext("You cast Restore Life on "..target.name)
					target:sendMinitext(player.name.." restores life to your body!")
				else
					player:sendMinitext("Invalid Target!")
				end
			end
		end
	end
end
}]]
--
