eclipse_torch = {
	equip = function(player)
		player.attackSpeed = 65
	end,
	while_equipped = function(player)
		player.attackSpeed = 65
	end,
	unequip = function(player)
		player:calcStat()
	end,
	on_swing = function(player)
		local weap = player:getEquippedItem(EQ_WEAP)
		local mob = getTargetFacing(player, BL_MOB)

		if mob ~= nil then
			if mob.yname == "haunted_tree" then
				mob:talk(2, "*shriek*")
				if not mob:hasDuration("eclipse_burn") then
					mob:setDuration("eclipse_burn", 2000)
				end
				mob:removeHealthWithoutDamageNumbers(1000000000)
				mob:sendHealth(0, 0)
				mob:sendAnimation(352)
				player:dropItemXY(2404, 1, mob.m, mob.x, mob.y)
			--mob:vanish()
			end
		end

		if player.quest["angry_guard"] >= 10 then
			player:deductDura(EQ_WEAP, 999999999)
		end
	end
}
