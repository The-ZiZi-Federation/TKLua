blink = {
	cast = function(player)
		local aether = 0
		local magicCost = player.maxMagic * 0.1

		if player.blType == BL_PC then
			if not player:canCast(1, 1, 0) then
				return
			end
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			end

			player:sendAction(6, 20)

			player.magic = player.magic - magicCost
			player:calcStat()
			player:sendStatus()
			player:sendMinitext("You cast Blink")
		end

		blink.warp(player, 1)
	end,
	warp = function(player, tries)
		local m = player.m
		local x = player.x + math.random(-3, 3)
		local y = player.y + math.random(-3, 3)
		local sound = 735
		local anim = 415

		local mob = player:getObjectsInCell(m, x, y, BL_MOB)
		local pc = player:getObjectsInCell(m, x, y, BL_PC)

		local startX, startY = player.x, player.y

		tries = tries + 1
		if tries >= 10 then
			return
		end

		if x < 1 then
			x = 1
		elseif x > player.xmax then
			x = player.xmax - 1
		end

		if y < 1 then
			y = 1
		elseif y > player.ymax then
			y = player.ymax - 1
		end

		if findClearPath(player.side, player.m, x, y, player, 1) == 1 then
			if getPass(m, x, y) == 0 then
				if getObject(m, x, y) == 0 then
					if #mob == 0 then
						if #pc == 0 then
							player:playSound(sound)
							player:sendAnimationXY(anim, player.x, player.y, 1)
							player:warp(m, x, y)
							player:sendAnimation(anim)
							--player:talk(0,"Warped: "..m..", "..x..", "..y.."!")
							if player.x == startX and player.y == startY then
								return blink.warp(player, tries)
							end
						else
							return blink.warp(player, tries)
						end
					else
						return blink.warp(player, tries)
					end
				else
					return blink.warp(player, tries)
				end
			else
				return blink.warp(player, tries)
			end
		else
			return blink.warp(player, tries)
		end
	end,
	requirements = function(player)
		local level = 42
		local item = {0}
		local amounts = {5000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Blink is a spell that teleports you randomly!", txt}
		return level, item, amounts, desc
	end
}
