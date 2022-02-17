testspell = {
	cast = function(player)
		local aether = 19000
		local magicCost = player.maxMagic * .3

		local m, x, y = player.m, player.x, player.y

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

		player:sendAction(5, 40)
		player.magic = player.magic - magicCost
		--player:sendAnimation(5)
		--player:playSound(3)
		player:setAether("testspell", aether)
		player:sendStatus()
		player:sendMinitext("You set an Explosive Charge.")
		player:dropItemXY(Item("explosive_charge").id, 1, m, x, y)
		player:addNPC("testspell", m, x, y, 1000, 2000, player.ID)
	end,
	on_spawn = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		local explosive = npc:getObjectsInCell(m, x, y, BL_ITEM)

		for i = 1, #explosive do
			if explosive[i].id == 502 then
				explosive[i].cursed = npc.ID
				setPass(m, x, y, 0)
			end
		end

		npc:sendAnimationXY(368, x, y)

		npc.registry["explosive_timer"] = 2
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		npc.registry["explosive_timer"] = npc.registry["explosive_timer"] - 1
		if npc.registry["explosive_timer"] == 1 then
			npc:sendAnimationXY(367, x, y)
		end
	end,
	endAction = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		local explosive = npc:getObjectsInCell(m, x, y, BL_ITEM)

		if #player > 0 then
			player[1]:sendAnimationXY(13, x, y)
		end

		testspell.anim(npc)
		testspell.boom(npc)

		for i = 1, #explosive do
			if explosive[i].id == 502 then
				explosive[i]:delete()
				setPass(m, x, y, 0)
			end
		end
		npc:delete()
	end,
	anim = function(npc)
		local x, y = npc.x, npc.y

		npc:sendAnimationXY(188, x, y)

		npc:sendAnimationXY(188, x + 1, y)
		--	npc:sendAnimationXY(188, x + 2, y)
		npc:sendAnimationXY(188, x - 1, y)
		--	npc:sendAnimationXY(188, x - 2, y)
		npc:sendAnimationXY(188, x, y + 1)
		--	npc:sendAnimationXY(188, x, y + 2)
		npc:sendAnimationXY(188, x, y - 1)
		--	npc:sendAnimationXY(188, x, y - 2)

		npc:sendAnimationXY(188, x + 1, y + 1)
		npc:sendAnimationXY(188, x + 1, y - 1)
		--	npc:sendAnimationXY(188, x + 1, y + 2)
		-- 	npc:sendAnimationXY(188, x + 1, y - 2)
		--	npc:sendAnimationXY(188, x + 2, y + 1)
		--	npc:sendAnimationXY(188, x + 2, y - 1)
		--	npc:sendAnimationXY(188, x + 2, y + 2)
		--	npc:sendAnimationXY(188, x + 2, y - 2)

		npc:sendAnimationXY(188, x - 1, y + 1)
		npc:sendAnimationXY(188, x - 1, y - 1)
		--	npc:sendAnimationXY(188, x - 1, y + 2)
		--	npc:sendAnimationXY(188, x - 1, y - 2)
		--	npc:sendAnimationXY(188, x - 2, y + 1)
		--	npc:sendAnimationXY(188, x - 2, y - 1)
		--	npc:sendAnimationXY(188, x - 2, y + 2)
		--	npc:sendAnimationXY(188, x - 2, y - 2)
	end,
	boom = function(npc)
		local damage = 10000

		local player = Player(npc.owner)

		--local damageType = "magical"
		local grace = player.grace
		local buff
		local mana = player.maxMagic
		local graceBonusPct = ((grace / (grace + 50)) ^ 1.1)
		local graceBase
		local graceMult
		local manaDamageBonus

		if (player.blType == BL_PC) then
			buff = player.fury
		else
			buff = 1
		end

		local searDuration = 2000

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 414
		local sound = 29

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		if player.blType == BL_MOB then
			graceBase = grace ^ 1.0
			graceMult = grace ^ 0.14
			manaDamageBonus = 0
		end

		if player.blType == BL_PC then
			if player.level > 99 then
				graceBase = grace ^ 2.0
				graceMult = grace ^ 0.21
				manaDamageBonus = math.floor((mana * (graceBonusPct / 2)))
			elseif player.level > 49 then
				graceBase = grace ^ 1.9
				graceMult = grace ^ 0.2
				manaDamageBonus = 0
			else
				graceBase = grace ^ 1.85
				graceMult = grace ^ 0.13
				manaDamageBonus = 0
			end
		end

		local damCalc = (graceBase * graceMult) + manaDamageBonus

		local damage = (damCalc) * buff
		damage = math.floor(damage)

		--Player(4):talkSelf(0,"player: "..player.name..": "..damage)

		local areaPC = npc:getObjectsInArea(BL_PC)
		local areaMob = npc:getObjectsInArea(BL_MOB)

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if distanceSquare(npc, areaMob[i], 1) then
					areaMob[i].attacker = player.ID
					threat = areaMob[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
					player:addThreat(areaMob[i].ID, threat)
					areaMob[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
				end
			end
		end

		if #areaPC > 0 then
			for i = 1, #areaPC do
				if (player:canPK(areaPC[i])) then
					if distanceSquare(npc, areaPC[i], 1) then
						areaPC[i].attacker = player.ID
						areaPC[i]:calcStat()
						areaPC[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 65
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"This is a spell that sets an explosive on the ground with a 2 second fuse.", txt}
		return level, item, amounts, desc
	end
}
