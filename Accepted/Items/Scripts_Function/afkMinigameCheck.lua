afkMinigameCheck = function(player)

	local isInMinigame
	local m = player.m
	local sound = 200
	local anim = 247
	if player.m == 15000 then --On CTF Map
		if core.gameRegistry["freeze_war_started"] == 1 then -- CTF Game is running
			isInMinigame = 1
		end
		
	elseif player.m == 15020 then
		if core.gameRegistry["beach_war_started"] == 1 then
			isInMinigame = 1
		end
		
	elseif player.m == 15030 then
		if core.gameRegistry["sumo_war_playing"] == 1 then
			isInMinigame = 1
		end
		
	elseif player.m == 15040 then
		
		if core.gameRegistry["elixir_war_started"] == 1 then
			if player.y >= 6 and player.y <= 34 then
				isInMinigame = 1
			end
		end
		
	elseif player.m == 15050 then
		if core.gameRegistry["bomber_war_playing"] == 1 then
			if player.state ~=	1 then
				isInMinigame = 1
			end
		end
	end

	if isInMinigame == 1 then
	--Player(7):talkSelf(0,"afk time: "..Player(912).afkTime)


		if (player.afkTime == 7) then
			if player.registry["minigame_afk_warning"] == 0 then
				player:playSound(sound)
				player:sendAnimation(anim)
				player:sendMinitext("Please don't AFK in minigames! If you do not move, you will be moved in 20 seconds.")
				player.registry["minigame_afk_warning"] = player.registry["minigame_afk_warning"] + 1
			end
		end
		if (player.afkTime == 8) then
			if player.registry["minigame_afk_warning"] == 1 then
				player:playSound(sound)
				player:sendAnimation(anim)
				player:sendMinitext("Please don't AFK in minigames! If you do not move, you will be moved in 10 seconds.")
				player.registry["minigame_afk_warning"] = 2
			end
		end
		
		if (player.afkTime >= 9) then
			if player.registry["minigame_afk_warning"] == 2 then
				minigame_powers.resetPlayer(player)
				player.registry["minigame_afk_warning"] = 0
			end
		end


		if (player.afkTime == 0) then
			player.registry["minigame_afk_warning"] = 0
		end

	end
end