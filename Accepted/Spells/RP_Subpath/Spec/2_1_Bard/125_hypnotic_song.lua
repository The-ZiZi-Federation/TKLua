hypnotic_song = {
	cast = function(player)
		local aether = 27000
		local magicCost = math.floor((player.level * 10) + (player.maxMagic / 25))

		local m, x, y = player.m, player.x, player.y
		local sound = 300

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.state == 1 or player.health <= 0 then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(11, 80)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:setAether("hypnotic_song", aether)
		player:sendStatus()
		player:sendMinitext("You cast Hypnotic Song.")
		player:addNPC("hypnotic_song", m, x, y, 1000, 3000, player.ID)
	end,
	on_spawn = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)
		local anim = 365

		npc:sendAnimationXY(anim, x, y)
		npc.registry["trap_timer"] = 3
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)
		local anim = 364

		npc.registry["trap_timer"] = npc.registry["trap_timer"] - 1
		if npc.registry["trap_timer"] > 0 then
			npc:sendAnimationXY(anim, x, y)
		end
	end,
	endAction = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)
		local animation = 604
		local trap = npc:getObjectsInCell(m, x, y, BL_ITEM)

		if #player > 0 then
			player[1]:sendAnimationXY(animation, x, y)
		end

		--hypnotic_song.anim(npc)
		hypnotic_song.trigger(npc)
		npc:delete()
	end,
	anim = function(npc)
		local x, y = npc.x, npc.y
		local animation = 599
		local dist = 2

		for x = npc.x - dist, npc.x + dist do
			for y = npc.y - dist, npc.y + dist do
				if distanceXY(npc, x, y) <= dist then
					npc:sendAnimationXY(animation, x, y)
				end
			end
		end
	end,
	trigger = function(npc)
		local player = Player(npc.owner)
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local sound = 311
		local duration = 8000
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		local areaPC = npc:getObjectsInArea(BL_PC)
		local areaMob = npc:getObjectsInArea(BL_MOB)
		local targets = {}

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if distance(npc, areaMob[i]) <= 2 then
					table.insert(targets, areaMob[i])
				end
			end
		end

		if #areaPC > 0 then
			for i = 1, #areaPC do
				if (player:canPK(areaPC[i])) then
					if distance(npc, areaPC[i]) <= 2 then
						table.insert(targets, areaPC[i])
					end
				end
			end
		end
		player:playSound(sound)
		if #targets > 0 then
			for i = 1, #targets do
				player.critChance = 1
				if targets[i].blType == BL_MOB then
					targets[i].attacker = player.ID
					if checkResist(player, targets[i], "asleep") == 1 then
						return
					end
					targets[i]:setDuration("asleep", duration)
					targets[i].sleep = 2.0
				elseif targets[i].blType == BL_PC then
					targets[i].attacker = player.ID
					if checkResist(player, targets[i], "asleep") == 1 then
						return
					end
					targets[i]:setDuration("asleep", duration)
					targets[i].sleep = 2.0
				end
			end
		end
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"This spell magically suspends a lullaby for 3 seconds before unleashing it.", txt}
		return level, item, amounts, desc
	end
}
