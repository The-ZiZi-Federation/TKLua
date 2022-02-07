call_natures_ally = {
	on_learn = function(player)
		player.registry["learned_call_natures_ally"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_call_natures_ally"] = 0
	end,
	cast = function(player)
		local commonMobs = {3, 5}
		local rareMobs = {4, 6, 7}
		local map = player.m
		local xmin, xmax = player.x - 5, player.x + 5
		local ymin, ymax = player.y - 5, player.y + 5
		local number
		local magicCost = (player.magic * .3)
		local sound = 1
		local anim = 1

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
		player:setAether("call_natures_ally", 1800000)
		player:calcStat()
		player:sendMinitext("You cast Call Nature's Ally")

		for i = 1, #commonMobs do
			number = math.random(4, 7)
			dmSpawn.spawn(player, map, xmin, xmax, ymin, ymax, commonMobs[i], number)
		end

		for i = 1, #rareMobs do
			number = math.random(0, 1)
			dmSpawn.spawn(player, map, xmin, xmax, ymin, ymax, rareMobs[i], number)
		end
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
