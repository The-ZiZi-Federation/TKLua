ore = {
	on_spawn = function(mob)
		mob.side = math.random(0, 3)
		--mob:move()
	end
}

-----------------------------------------------------------------------------------------------
auto_ore = {
	on_spawn = function(mob)
		mob.attacker = 0
		mob.target = 0
	end,
	on_attacked = function(mob, attacker)
		mob.attacker = 0
		mob.target = 0
	end,
	move = function(mob, target)
		mob.side = math.random(0, 3)
		mob:sendSide()
	end
}
-----------------------------------------------------------------------------------------------

small_sheep = {
	move = function(mob, target)
		c1, c2, moved = math.random(0, 20), math.random(0, 10), true

		if c1 > 3 then
			return
		else
			mob.side = c1
		end
		mob:sendSide()
		if c1 < c2 then
			moved = mob:move()
		end
	end
}

----------------------------------------------------------------------------------------------------------
medium_sheep = {
	move = function(mob, target)
		c1, c2, moved = math.random(0, 20), math.random(0, 10), true

		if c1 > 3 then
			return
		else
			mob.side = c1
		end
		mob:sendSide()
		if c1 < c2 then
			moved = mob:move()
		end
	end
}
-----------------------------------------------------------------------------------------------
large_sheep = {
	move = function(mob, target)
		c1, c2, moved = math.random(0, 20), math.random(0, 10), true

		if c1 > 3 then
			return
		else
			mob.side = c1
		end
		mob:sendSide()
		if c1 < c2 then
			moved = mob:move()
		end
	end
}
-----------------------------------------------------------------------------------------------
auto_sheep = {
	on_spawn = function(mob)
		mob.attacker = 0
		mob.target = 0
	end,
	on_attacked = function(mob, attacker)
		mob.attacker = 0
		mob.target = 0
	end,
	move = function(mob, target)
		mob.side = math.random(0, 3)
		mob:sendSide()
	end
}

-----------------------------------------------------------------------------------------------
tree = {
	on_spawn = function(mob)
		mob.side = math.random(0, 3)
		--mob:move()
	end
}
-----------------------------------------------------------------------------------------------
auto_tree = {
	on_spawn = function(mob)
		mob.attacker = 0
		mob.target = 0
	end,
	on_attacked = function(mob, attacker)
		mob.attacker = 0
		mob.target = 0
	end,
	move = function(mob, target)
		mob.side = math.random(0, 3)
		mob:sendSide()
	end
}

-----------------------------------------------------------------------------------------------
monkey = {
	move = function(mob, target)
		c1, c2, moved = math.random(0, 20), math.random(0, 10), true

		if c1 > 3 then
			return
		else
			mob.side = c1
		end
		mob:sendSide()
		if c1 < c2 then
			moved = mob:move()
		end
	end,
	on_attacked = function(mob, attacker)
		mob.attacker = 0
	end
}

-----------------------------------------------------------------------------------------------

auto_monkey = {
	on_spawn = function(mob)
		mob.attacker = 0
		mob.target = 0
	end,
	on_attacked = function(mob, attacker)
		mob.attacker = 0
	end,
	move = function(mob, target)
		mob.side = math.random(0, 3)
		mob:sendSide()
	end
}
