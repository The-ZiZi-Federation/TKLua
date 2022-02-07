gamagrass = {
	on_spawn = function(mob)
	end,
	on_attacked = function(mob, attacker)
		local pc1 = mob:getObjectsInCell(attacker.m, attacker.x + 1, attacker.y, BL_MOB)[1]
		local pc2 = mob:getObjectsInCell(attacker.m, attacker.x - 1, attacker.y, BL_MOB)[1]
		local pc3 = mob:getObjectsInCell(attacker.m, attacker.x, attacker.y + 1, BL_MOB)[1]
		local pc4 = mob:getObjectsInCell(attacker.m, attacker.x, attacker.y - 1, BL_MOB)[1]
		local r = math.random(1, 75)

		if attacker.quest["angry_guard"] >= 6 and attacker.quest["angry_guard"] <= 9 then
			if pc1 == nil then
				if r == 1 then
					mob:spawn(4023, attacker.x + 1, attacker.y, 1, attacker.m)
				else
					mob:spawn(4022, attacker.x + 1, attacker.y, 1, attacker.m)
				end
			elseif pc2 == nil then
				if r == 1 then
					mob:spawn(4023, attacker.x - 1, attacker.y, 1, attacker.m)
				else
					mob:spawn(4022, attacker.x - 1, attacker.y, 1, attacker.m)
				end
			elseif pc3 == nil then
				if r == 1 then
					mob:spawn(4023, attacker.x, attacker.y + 1, 1, attacker.m)
				else
					mob:spawn(4022, attacker.x, attacker.y + 1, 1, attacker.m)
				end
			elseif pc4 == nil then
				if r == 1 then
					mob:spawn(4023, attacker.x, attacker.y - 1, 1, attacker.m)
				else
					mob:spawn(4022, attacker.x, attacker.y - 1, 1, attacker.m)
				end
			end
		end
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob, attacker)
		if attacker.quest["angry_guard"] >= 6 and attacker.quest["angry_guard"] <= 9 then
			mob:dropItemXY(2407, 1, mob.m, mob.x, mob.y)
		end
	end
}

road_boar = {
	on_spawn = function(mob)
		mob:sendAnimation(248)
		mob:talk(2, "*snort*")
	end
}
