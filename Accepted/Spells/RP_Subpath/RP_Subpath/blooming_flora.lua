blooming_flora = {
	on_learn = function(player)
		player.registry["learned_blooming_flora"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_blooming_flora"] = 0
	end,
	cast = function(player)
		local commonFlowers = {6301, 6303, 6306, 6307, 6309, 6313}
		local uncommonFlowers = {6310, 6312, 6314, 6315}
		local rareFlowers = {6302, 6305, 6308, 6311}
		local map = player.m
		local xmin, xmax = player.x - 4, player.x + 4
		local ymin, ymax = player.y - 4, player.y + 4
		local number
		local magicCost = (player.magic * .3)
		local sound = 64
		local anim = 212
		local aether = 0

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("blooming_flora", aether)
		player:calcStat()
		player:sendMinitext("You cast Blooming Flora")

		for i = 1, #commonFlowers do
			number = math.random(1, 6)
			blooming_flora.spawn(player, map, xmin, xmax, ymin, ymax, commonFlowers[i], number)
		end

		for i = 1, #uncommonFlowers do
			number = math.random(0, 1)
			blooming_flora.spawn(player, map, xmin, xmax, ymin, ymax, uncommonFlowers[i], number)
		end

		for i = 1, #rareFlowers do
			number = math.random(0, 2)
			if number > 1 then
				number = 0
			end
			blooming_flora.spawn(player, map, xmin, xmax, ymin, ymax, rareFlowers[i], number)
		end
	end,
	spawn = function(player, map, xmin, xmax, ymin, ymax, itemID, number)
		local allMobs
		local targetMobs = {}

		--Player(4):talk(0,"RESPAWN: "..number)

		for i = 1, number do
			x = math.random(xmin, xmax)
			y = math.random(ymin, ymax)

			if x >= player.xmax then
				x = player.xmax - 1
			end

			if y >= player.ymax then
				y = player.ymax - 1
			end

			player:dropItemXY(itemID, 1, map, x, y)

			--		local mob = core:getObjectsInCell(map,x,y, BL_MOB)
			--		local pc = core:getObjectsInCell(map,x,y, BL_PC)
			--
			--		if getPass(map,x,y) == 0 then
			--			if not getWarp(map,x,y) then
			--				if getObject(map,x,y) == 0 then
			--					if #mob == 0 then
			--						if #pc == 0 then
			--							core:spawn(mobid, x, y, 1, map)
			--						end
			--					end
			--				end
			--			end
			--		end
		end

		--	allMobs = core:getObjectsInMap(map, BL_MOB)
		--
		--	if #allMobs > 0 then
		--		for i = 1, #allMobs do
		--			if allMobs[i].mobID == mobid then
		--				table.insert(targetMobs, allMobs[i].mobID)
		--
		--			end
		--		end
		--	end
		--
		--	if #targetMobs < number then
		--	--Player(4):talk(0,"RESPAWN: MIN")
		--
		--		return dmSpawn.spawn(player, map, xmin, xmax, ymin, ymax, mobid, (number - #targetMobs), number)
		--	end
	end,
	requirements = function(player)
		local level = 100
		local item = {0}
		local amounts = {10000000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Call the creatures of the woodlands to your side.", txt}
		return level, item, amounts, desc
	end
}
