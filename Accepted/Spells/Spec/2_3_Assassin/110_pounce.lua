pounce = {
	on_learn = function(player)
		player.registry["learned_pounce"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_pounce"] = 0
	end,
	cast = function(player)
		local mob = player:getObjectsInArea(BL_MOB)
		local pc = player:getObjectsInArea(BL_PC)
		local targets = {}
		local randomTarget
		local lowestVita = 0
		local weakest

		if (#mob > 0) then
			for i = 1, #mob do
				if (mob[i].state ~= 1) then
					if distance(player, mob[i]) <= 6 then
						table.insert(targets, mob[i])
					end
				end
			end
		elseif (#pc > 0) then
			for i = 1, #pc do
				if (pc[i].state ~= 1) and player:canPK(pc[i]) then
					if distance(player, pc[i]) <= 6 then
						table.insert(targets, pc[i])
					end
				end
			end
		end

		if (#targets) > 0 then
			--randomTarget = math.random(1, #targets)
			--pounce.hit(player, targets[randomTarget])
			for i = 1, #targets do
				if lowestVita == 0 or targets[i].health < lowestVita then
					lowestVita = targets[i].health
					weakest = targets[i]
				end
			end
			if weakest ~= nil then
				pounce.hit(player, weakest)
			end
		end
	end,
	uncast = function(player)
		--	player.paralyzed = false
	end,
	while_cast_250 = function(player)
	end,
	hit = function(player, target)
		local magicCost = math.floor(player.maxMagic * 0.05)
		local aether = 5000
		local sound1 = 73
		local sound2 = 350
		local anim1 = 292
		local anim2 = 280

		local targetAnim1 = 584
		local targetAnim2 = 120

		if target == nil then
			return
		end
		if target.ID == player.ID then
			return
		end -- if target is ourself, then return. nothing happened
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if target.state == 1 then
			player:sendMinitext("Target is already dead")
			player:sendAnimation(246)
			return
		end

		if findClearPath(player.side, player.m, player.x, player.y, target, 1) == 1 then
			if target.blType == BL_PC then
				if not player:canPK(target) then
					return
				else
					target:sendMinitext(player.name .. " cast Pounce on you.")
				end
			end

			player.magic = player.magic - magicCost
			player:sendStatus()

			-- and here, before warp.
			player:sendAnimationXY(anim1, player.x, player.y)
			player:sendAnimationXY(anim2, player.x, player.y)
			player:playSound(sound1)

			if target.side == 0 then -- if target is facing north
				pounce.checkSouth(player, target)
			elseif target.side == 1 then -- facing east
				pounce.checkWest(player, target)
			elseif target.side == 2 then -- south
				pounce.checkNorth(player, target)
			elseif target.side == 3 then -- west
				pounce.checkEast(player, target)
			end

			-- here is after warp
			target.attacker = player.ID
			player:setAether("pounce", aether)
			player:playSound(sound2)
			target:sendAnimation(targetAnim1)
			--target:sendAnimation(targetAnim2)
			player:swing()
			player:sendMinitext("You cast Pounce")
		end
	end,
	checkSouth = function(player, target)
		if getPass(target.m, target.x, target.y + 1) == 1 then -- if walkable is false dont put here.
			pounce.checkEast(player, target)
			return
		else
			player:warp(target.m, target.x, target.y + 1)
			player.side = 0
			player:sendSide()
		end
	end,
	checkWest = function(player, target)
		if getPass(target.m, target.x - 1, target.y) == 1 then -- if walkable is false
			pounce.checkNorth(player, target)
			return
		else
			player:warp(target.m, target.x - 1, target.y)
			player.side = 1
			player:sendSide()
		end
	end,
	checkNorth = function(player, target)
		if getPass(target.m, target.x, target.y - 1) == 1 then -- if walkable is false
			pounce.checkWest(player, target)
			return
		else
			player:warp(target.m, target.x, target.y - 1)
			player.side = 2
			player:sendSide()
		end
	end,
	checkEast = function(player, target)
		if getPass(target.m, target.x + 1, target.y) == 1 then -- if walkable is false
			pounce.checkSouth(player, target)
			return
		else
			player:warp(target.m, target.x + 1, target.y)
			player.side = 3
			player:sendSide()
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Pounce on the weakest foe in your vicinity", txt}
		return level, item, amounts, desc
	end
}
