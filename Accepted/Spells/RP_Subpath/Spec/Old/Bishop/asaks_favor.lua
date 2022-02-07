--[[
asaks_favor = {

on_learn = function(player) player.registry["learned_asaks_favor"] = 1 end,
on_forget = function(player) player.registry["learned_cure_critical_wounds"] = 0 end,

cast = function(player, target)

	local magicCost = 612
	local heal = 4000+(player.will*50)
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target ~= nil then
				if target.state == 1 then invalidTarget(player) return else
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You grant the favor of ASAK to "..target.name)
					player:playSound(22)
					target:sendAnimation(108)
					--target:sendAnimation(403)
					target:sendAnimation(107)
					addHealth(target, heal)
					if target.blType == BL_PC and target.ID ~= player.ID then target:sendMinitext(player.name.." grants you the favor of ASAK") end
				end
			end
		end
	end
end
}]]
--
