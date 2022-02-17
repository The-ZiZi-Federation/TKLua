--[[
death_shroud = {

on_learn = function(player) player.registry["learned_death_shroud"] = 1 end,
on_forget = function(player) player.registry["learned_death_shroud"] = 0 end,

cast = function(player)


	local magicCost = (player.magic * .3)
	local duration = 11000
	local anim = 111
	local sound = 81

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("death_shroud") then alreadyCast(player) return end
	
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("death_shroud", duration)
	player:calcStat()

end,


while_cast = function(player)

	local level = player.level
	local might = player.might
	local mightBonusPct = ((might/(might+50))^1.1)
	local vita = player.health
	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local mightBase
	local mightMult
	local vitaDamageBonus

	if (player.blType == BL_PC) then
		buff = player.fury
	else
		buff = 1
	end
	
	---------------------------
--- Spell Damage Formula---
---------------------------
	if player.blType == BL_MOB then 
		mightBase = might ^ 1.2
		mightMult = might ^ 0.13
		vitaDamageBonus = 0
	end

	if player.blType == BL_PC then
		if player.level > 99 then
			mightBase = might ^ 2.1
			mightMult = might ^ 0.21
			vitaDamageBonus = math.floor((vita * (mightBonusPct / 2)))
		elseif player.level > 49 then
			mightBase = might ^ 2.05
			mightMult = might ^ 0.2
			vitaDamageBonus = 0
		else
			mightBase = might ^ 1.95
			mightMult = might ^ 0.13
			vitaDamageBonus = 0
		end
	end
		
	local damCalc = (mightBase * mightMult) + vitaDamageBonus

	local damage = (damCalc) * buff
	damage = math.floor(damage)


			
	   --  Mob is nearby ---------
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 1) then
				if (player.blType == BL_PC) then
					if player.gmLevel > 0 then
						player:sendMinitext("Death Shroud DMG: "..damage)
						player:sendMinitext("Vita Damage Bonus: "..vitaDamageBonus)
					end
				end
				if mob[i].ID ~= player.ID then death_shroud.takeDamage(player, mob[i], damage) end
			end
		end
	end
  --  PKable Human Player is around ---------
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 1) then
				if pc[i].ID ~= player.ID then
					if pc[i].state ~= 1 then
						if player.blType == BL_PC then
							if player:canPK(pc[i]) then
								death_shroud.takeDamage(player, pc[i], damage)
							end
						elseif player.blType == BL_MOB then
							death_shroud.takeDamage(player, pc[i], damage)
						end
					end
				end
			end
		end
	end
end,


takeDamage = function(player, target, damage)
	local damageType = "magical"
	local threat
	local anim = 204

	target.attacker = player.ID
	if target.blType == BL_MOB then
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
	end
	target:sendAnimation(anim, 1)
	target:removeHealthExtend(damage, 1, 1, 1, 1, 1, damageType)

end,


uncast = function(player)


end
}]]
--
