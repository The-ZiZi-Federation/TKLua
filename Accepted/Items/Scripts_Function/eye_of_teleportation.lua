--[[   This is for speech.lua
	if (player.m == 1099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 3099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 1098) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 4099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
]]-- Below is all eyes maps and coordinates.


eye_of_teleportation = {


talk = function(player)

	local say = string.lower(player.speech)
	
	if (player.m == 1099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		if say == "hon" then
			if player.registry["hon_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(1099, 17, 18)
				player.side = 2
				player:sendSide()
				player:sendAction(6, 250)
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
	
		elseif say == "lortz" then
			if player.registry["lortz_village_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(3099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end

		elseif say == "blackstrike" then
			if player.registry["blackstrike_tower_eye"] == 1 then
				if player.level >= 99 then
					player:sendAnimation(134)
					player:warp(1098, 25, 18)
					player.side = 2
					player:sendSide()
					player:playSound(64)
					player:sendAnimation(364)
					player:sendAnimation(254)
				else
					player:sendMinitext("Your body is too weak to withstand that journey.")
				end
			end
		
		elseif say == "cathay" then
			if player.registry["cathay_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(4099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		end
	elseif (player.m == 3099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		if say == "hon" then
			if player.registry["hon_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(1099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "lortz" then
			if player.registry["lortz_village_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(3099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "blackstrike" then
			if player.registry["blackstrike_tower_eye"] == 1 then
				if player.level >= 99 then
					player:sendAnimation(134)
					player:warp(1098, 25, 18)
					player.side = 2
					player:sendSide()
					player:playSound(64)
					player:sendAnimation(364)
					player:sendAnimation(254)
				else
					player:sendMinitext("Your body is too weak to withstand that journey.")
				end
			end
		
		elseif say == "cathay" then
			if player.registry["cathay_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(4099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		end
	elseif (player.m == 1098) and (player.x > 22 and player.x < 28) and (player.y > 16 and player.y < 21) then
		if say == "hon" then
			if player.registry["hon_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(1099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "lortz" then
			if player.registry["lortz_village_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(3099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "blackstrike" then
			if player.registry["blackstrike_tower_eye"] == 1 then
				if player.level >= 99 then
					player:sendAnimation(134)
					player:warp(1098, 25, 18)
					player.side = 2
					player:sendSide()
					player:playSound(64)
					player:sendAnimation(364)
					player:sendAnimation(254)
				else
					player:sendMinitext("Your body is too weak to withstand that journey.")
				end
			end
		
		elseif say == "cathay" then
			if player.registry["cathay_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(4099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		end
	elseif (player.m == 4099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		if say == "hon" then
			if player.registry["hon_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(1099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "lortz" then
			if player.registry["lortz_village_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(3099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		
		elseif say == "blackstrike" then
			if player.registry["blackstrike_tower_eye"] == 1 then
				if player.level >= 99 then
					player:sendAnimation(134)
					player:warp(1098, 25, 18)
					player.side = 2
					player:sendSide()
					player:playSound(64)
					player:sendAnimation(364)
					player:sendAnimation(254)
				else
					player:sendMinitext("Your body is too weak to withstand that journey.")
				end
			end
		
		elseif say == "cathay" then
			if player.registry["cathay_city_eye"] == 1 then
				player:sendAnimation(134)
				player:warp(4099, 17, 18)
				player.side = 2
				player:sendSide()
				player:playSound(64)
				player:sendAnimation(364)
				player:sendAnimation(254)
			end
		end
	end
end
}