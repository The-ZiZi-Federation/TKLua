--[[
divine_right = {

on_learn = function(player) player.registry["learned_divine_favor"] = 1 end,
on_forget = function(player) player.registry["learned_divine_favor"] = 0 end,

cast = function(player, target)

	local magicCost = 590
	local heal = 3000+(player.will*45)
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target ~= nil then
				if target.state == 1 then invalidTarget(player) return else
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You cast Divine Right")
					player:playSound(22)
					target:sendAnimation(66)
					--target:sendAnimation(403)
					addHealth(target, heal)
					if target.blType == BL_PC and target.ID ~= player.ID then target:sendMinitext(player.name.." casts Divine Favor on you") end
				end
			end
		end
	end
end
}]]
--
