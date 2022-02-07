--[[
elemental_weapon = {

on_learn = function(player) player.registry["elemental_weapon"] = 1 end,
on_forget = function(player) player.registry["elemental_weapon"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		if target:hasDuration("elemental_weapon") then return else
			player.magic = player.magic - magicCost
			target.might = target.might + 3
			player:sendStatus()
			player:sendAction(6, 20)
			player:sendMinitext("You cast elemental Weapon")
			target:sendAnimation(11)
			player:playSound(8)
			target:sendMinitext(player.name.." cast elemental Weapon on you")
			target:setDuration("elemental_weapon", 600000)
		end
	end
end,


on_swing_while_cast = function(player, target)

	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)

	
	if mobTarget ~= nil then
		if not mobTarget:hasDuration("elemental_burst") then
			mobTarget.registry["elemental_burst"] = player.ID
			mobTarget:setDuration("elemental_burst", 5000)

		end
	
	elseif pcTarget ~= nil then
		if (player:canPK(pcTarget)) then
			if not pcTarget:hasDuration("elemental_burst") then
				pcTarget.registry["elemental_burst"] = player.ID 
				pcTarget:setDuration("elemental_burst", 5000)

			end
		end
	end
	
end,


uncast = function(player)

	player:calcStat() 
end
}]]
--
