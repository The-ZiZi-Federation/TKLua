sansak = {
	cast = function(player)
		local check = player:getObjectsInMap(player.m, BL_MOB)
		local mob = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		local map = {}

		if #check > 0 then
			for i = 1, #check do
				if check[i].mobID == 2000024 then
					table.insert(map, check[i].ID)
				end
			end
		end

		if #map >= 25 then
			anim(player)
			player:sendMinitext("Tidak bisa lebih dari 25 di dalam map yang sama..")
			return
		else
			player:sendAction(1, 20)
			player:spawn(2000024, player.x, player.y, 1)
		end
	end,
	on_spawn = function(mob)
		mob.side = 2
		mob:sendSide()
		mob:sendAnimation(16)
	end,
	on_healed = function(mob)
		mob_ai_basic.on_healed(mob)
	end,
	move = function(mob, target)
		if mob.health <= mob.maxHealth * .5 then
			mob.health = mob.maxHealth
			mob:sendStatus()
		end
	end,
	on_attacked = function(mob, attacker)
		if mob.health <= mob.maxHealth * .5 then
			mob.health = mob.maxHealth
			mob:sendStatus()
		end

		mob.attacker = attacker.ID
		--mob:sendAnimation(301)
		--attacker:playSound(353)

		--mob:talk(2, attacker.name.." damage: "..format_number(math.ceil(attacker.damage)))
		mob_ai_basic.on_attacked(mob, attacker)
	end
}
