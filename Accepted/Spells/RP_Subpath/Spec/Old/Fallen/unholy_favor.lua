--[[
unholy_favor = {

on_learn = function(player) player.registry["learned_unholy_favor"] = 1 end,
on_forget = function(player) player.registry["learned_unholy_favor"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local heal = 2500+(player.will*40)
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target ~= nil then
				if target.state == 1 then invalidTarget(player) return else
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You cast Unholy Favor")
					player:playSound(22)
					target:sendAnimation(109)
					--target:sendAnimation(403)
					target:sendAnimation(422)
					addHealth(target, heal)
					if target.blType == BL_PC and target.ID ~= player.ID then target:sendMinitext(player.name.." casts Unholy Favor on you") end
				end
			end
		end
	end
end
}]]
--
