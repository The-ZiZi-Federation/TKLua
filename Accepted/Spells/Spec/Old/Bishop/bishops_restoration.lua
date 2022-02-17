--[[
bishops_restoration = {

on_learn = function(player) player.registry["learned_bishops_restoration"] = 1 end,
on_forget = function(player) player.registry["learned_bishops_restoration"] = 0 end,

cast = function(player, target)

	local magicCost = 2500
	local heal = player.maxMagic / 1.5
	local aether = 23000
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target ~= nil then
				if target.state == 1 then invalidTarget(player) return else
					player.magic = player.magic - magicCost
					player:sendAction(6, 20)
					player:sendStatus()
					player:sendMinitext("You cast Bishop's Restoration")
					player:playSound(22)
					player:setAether("bishops_restoration", aether)
					target:sendAnimation(166)
					--target:sendAnimation(403)
					target:sendAnimation(422)
					addHealth(target, heal)
					if target.blType == BL_PC and target.ID ~= player.ID then target:sendMinitext(player.name.." casts Bishopss Restoration on you") end
				end
			end
		end
	end
end
}]]
--
