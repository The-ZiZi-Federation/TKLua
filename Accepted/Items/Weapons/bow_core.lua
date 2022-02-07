bow_core = {
	checkEquip = function(player)
		local bow, quiver = player:getEquippedItem(EQ_WEAP), player:getEquippedItem(EQ_SHIELD)
		local bowCheck, quiverCheck = bow.thrown, quiver.thrown

		if bow == nil then
			return false
		else
			if not (bowCheck) then
				return false
			else
				if quiver == nil then
					return false
				else
					if not (quiverCheck) then
						return false
					else
						return true
					end
				end
			end
		end
	end,
	getDamage = function(player)
		local weap, quiver = player:getEquippedItem(EQ_WEAP), player:getEquippedItem(EQ_SHIELD)
		local damage = 0

		if weap ~= nil and weap.thrown then
			if quiver == nil and not quiver.thrown then
				anim(player)
				player:sendMinitext("Require a quiver to use this.")
				return
			else
				damage = weapon.maxDmg + quiver.maxDmg + player.might + player.grace
			end
		end
		return damage
	end,
	thrown = function(player, icon)
		local pc, mob, damage = getTargetFacing(player, BL_PC), getTargetFacing(player, BL_MOB), bow_core.getDamage(player)
		local m, x, y, side = player.m, player.x, player.y, player.side
		local pc, mob, pass
		local arrow = 6

		if icon == nil then
			icon = arrow + side
		end

		player:playSound(716)

		if not player:canAction(1, 1, 1) then
			return
		else
			if bow_core.checkEquip(player) == true then
				for i = 1, 8 do
					pc, mob = getTargetFacing(player, BL_PC, 0, i), getTargetFacing(player, BL_MOB, 0, i)

					if getFacingPass(player, i) == 1 then
						return
					else
						if pc ~= nil then
							if player:canPK(pc) and pc.state ~= 1 then
								pc:sendMinitext(player.name .. " is attacking you with a bow")
								bow_core.shooted(player, pc, damage)
							end
							return
						end
						if mob ~= nil then
							player:addThreat(mob.ID, damage)
							bow_core.shooted(player, mob, damage)
							return
						end
						player:bowShoot(i)
					end
				end
			end
		end
	end,
	shooted = function(player, target, damage)
		target.attacker = player.ID
		target:sendAnimation(300)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	end,
	uncast = function(block)
		block:removeHealth(block.health)
	end,
	on_spawn = function(mob)
		mob:sendAnimation(16)
	end,
	on_healed = function(mob)
		mob_ai_basic.on_healed(mob)
	end,
	while_cast = function(mob)
	end,
	on_attacked = function(mob, attacker)
		if attacker ~= nil then
			if attacker.blType == BL_PC then
				mob:sendAnimation(300)
				attacker:playSound(353)
				mob.attacker = attacker.ID
				mob:talk(2, "Damage : " .. format_number(math.floor(attacker.damage)))
				attacker:msg(12, "[Sansak] Damaged " .. format_number(math.floor(attacker.damage)) .. "", attacker.ID)
			end
		end
	end,
	getTargetFacingCell = function(player, cell, type)
		local target

		if player.side == 0 then
			target = player:getObjectsInCell(player.m, player.x, player.y - cell, type)
		elseif player.side == 1 then
			target = player:getObjectsInCell(player.m, player.x + cell, player.y, type)
		elseif player.side == 2 then
			target = player:getObjectsInCell(player.m, player.x, player.y + cell, type)
		elseif player.side == 3 then
			target = player:getObjectsInCell(player.m, player.x - cell, player.y, type)
		end
		if #target > 0 then
			for i = 1, #target do
				return target[i]
			end
		end
	end
}
