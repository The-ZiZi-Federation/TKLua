gateway2 = {
	on_learn = function(player)
		player.registry["learned_gateway2"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_gateway2"] = 0
	end,
	cast = function(player, question)
		local q = string.lower(player.question)
		local m = player.m
		local x
		local y
		local aether = 1000
		local mob = player:getObjectsInMap(m, BL_MOB)

		if player:hasDuration("dre_locs_drain") then
			player:sendMinitext("You can't even think, Dre Loc's magic is overwhelming you.")
			return
		end

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "angry_blue_chick" then
					player:sendMinitext("Someone has angered a God. Your magic won't work now.")
					return
				end
			end
		end

		if player.health <= 0 then
			player:sendMinitext("Spirits cannot use Gateway")
			return
		end
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.warpOut > 0 then
			player:sendAnimation(246)
			player:sendMinitext("It doesn't work here")
			return
		end

		if player.region == 1 then -- Hon by the Sea
			if string.sub(q, 1, 1) == "n" then
				x = math.random(73, 75)
				y = math.random(22, 24)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(1000, x, y)
				player:sendMinitext("You arrived at the Northern Gate of Hon by the Sea")
			elseif string.sub(q, 1, 1) == "e" then
				x = math.random(133, 136)
				y = math.random(88, 90)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(1000, x, y)
				player:sendMinitext("You arrived at the Eastern Gate of Hon by the Sea")
			elseif string.sub(q, 1, 1) == "w" then
				x = math.random(7, 9)
				y = math.random(90, 92)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(1000, x, y)
				player:sendMinitext("You arrived at the Western Gate of Hon by the Sea")
			elseif string.sub(q, 1, 1) == "s" then
				x = math.random(73, 75)
				y = math.random(144, 147)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(1000, x, y)
				player:sendMinitext("You arrived at the Southern Gate of Hon by the Sea")
			end
		elseif player.region == 2 then -- Woods North of Hon
			if string.sub(q, 1, 1) == "n" then
				x = math.random(11, 17)
				y = math.random(6, 10)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(2000, x, y)
				player:sendMinitext("You arrived at the Northern Gate of the Woods North of Hon")
			elseif string.sub(q, 1, 1) == "e" then
				x = math.random(133, 137)
				y = math.random(16, 19)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(2000, x, y)
				player:sendMinitext("You arrived near the Western Grove of the Woods North of Hon")
			elseif string.sub(q, 1, 1) == "w" then
				x = math.random(3, 7)
				y = math.random(34, 37)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(2000, x, y)
				player:sendMinitext("You arrived near the Eastern Tonguspur Pass in the Woods North of Hon")
			elseif string.sub(q, 1, 1) == "s" then
				x = math.random(131, 136)
				y = math.random(141, 144)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(2000, x, y)
				player:sendMinitext("You arrived at the South Gate of the Woods North of Hon")
			end
		elseif player.region == 3 then -- Lortz Territory
			if string.sub(q, 1, 1) == "n" then
				x = math.random(29, 49)
				y = math.random(1, 6)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(3000, x, y)
				player:sendMinitext("You arrived at Northern Border of the Lortz Territory")
			elseif string.sub(q, 1, 1) == "e" then
				x = math.random(39, 46)
				y = math.random(86, 93)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(3000, x, y)
				player:sendMinitext("You arrived at the Ruined Gates of the Lortz Territory")
			elseif string.sub(q, 1, 1) == "w" then
				x = math.random(23, 30)
				y = math.random(33, 38)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(3000, x, y)
				player:sendMinitext("You arrived at Lortz Shops in the Lortz Territory")
			elseif string.sub(q, 1, 1) == "s" then
				x = math.random(32, 40)
				y = math.random(120, 144)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(3000, x, y)
				player:sendMinitext("You arrived at Southern Tip of the Lortz Territory")
			end
		elseif player.region == 4 then -- Cathay
			if string.sub(q, 1, 1) == "n" then
				x = math.random(71, 76)
				y = math.random(23, 27)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(4000, x, y)
				player:sendMinitext("You arrived at the Northern Gate of Cathay")
			elseif string.sub(q, 1, 1) == "e" then
				x = math.random(128, 135)
				y = math.random(86, 93)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(4000, x, y)
				player:sendMinitext("You arrived at the Eastern Gate of Cathay")
			elseif string.sub(q, 1, 1) == "w" then
				x = math.random(8, 14)
				y = math.random(89, 94)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(4000, x, y)
				player:sendMinitext("You arrived at the Western Gate of Cathay")
			elseif string.sub(q, 1, 1) == "s" then
				x = math.random(70, 81)
				y = math.random(137, 147)
				player:sendAnimationXY(16, player.x, player.y)
				player:warp(4000, x, y)
				player:sendMinitext("You arrived at the Southern Gate of Cathay")
			end
		else
			anim(player)
			player:sendMinitext("Cannot find any gates!")
			return
		end

		player:playSound(29)
		player:sendAnimation(16)
		player:sendAction(6, 20)
		player:setAether("gateway2", aether)
		player:sendMinitext("You cast Gateway")
	end
}
