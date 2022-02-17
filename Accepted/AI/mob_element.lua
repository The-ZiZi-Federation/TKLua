fire = {
	move = function(mob)
		--	mob:talk(2, ""..mob.name)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

water = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

wood = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

metal = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

earth = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}
 --

--[[
light = { 

move = function(mob)
	
	if mob.side ~= 2 then
		mob.side = 2
		mob:sendSide()
	end
	
	mob:talk(2, ""..element.name(mob.element))
end,

on_attacked = function(mob, attacker)

	mob_ai_basic.on_attacked(mob, attacker)
end
}
]] dark = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

neutral = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

physical = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}

magical = {
	move = function(mob)
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end

		mob:talk(2, "" .. element.name(mob.element))
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end
}
