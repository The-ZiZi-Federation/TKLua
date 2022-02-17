sound_test = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local m = player.m
			local map = 1038
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}
			local sound

			table.insert(options, "Play a sound")
			table.insert(options, "Browse sounds")
			table.insert(options, "No thanks")

			menu = player:menuString("It's a Sound Test Machine. Would you like to play a sound?", options)

			if menu == "Play a sound" then
				sound =
					math.abs(
					tonumber(
						math.floor(
							player:input("Please Enter a sound number\n\nValid sounds are:\n1-125, 200\n300-371, 401-412\n500-514, 700-740")
						)
					)
				)
				if
					(sound >= 1 and sound <= 125) or (sound == 200) or (sound >= 300 and sound <= 371) or
						(sound >= 401 and sound <= 412) or
						(sound >= 500 and sound <= 514) or
						(sound >= 700 and sound <= 740)
				 then
					player.registry["sound_test"] = sound
					player:playSound(sound)
				else
					player:popUp("Invalid number!")
				end
			elseif menu == "Browse sounds" then
				if player.m ~= map then
					player:sendMinitext("You can't browse if you leave the shop!")
					return
				end

				sound_test.browseSounds(player, npc)
			end
		end
	),
	browseSounds = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "Play Again")
		table.insert(opts, "<<- Previous")

		local sound = player.registry["sound_test"]
		local title = " Sound Test "
		local price

		player:playSound(sound)

		menu = player:menuString(name .. "\nSound: " .. sound, opts)
		--menu = player:menuString(name.."<b>[".. title .."]", opts)

		if menu == "Next ->>" then
			player.registry["sound_test"] = player.registry["sound_test"] + 1

			if (player.registry["sound_test"] > 125 and player.registry["sound_test"] < 200) then
				player.registry["sound_test"] = 200
			elseif (player.registry["sound_test"] > 200 and player.registry["sound_test"] < 300) then
				player.registry["sound_test"] = 300
			elseif (player.registry["sound_test"] > 371 and player.registry["sound_test"] < 401) then
				player.registry["sound_test"] = 401
			elseif (player.registry["sound_test"] > 412 and player.registry["sound_test"] < 500) then
				player.registry["sound_test"] = 500
			elseif (player.registry["sound_test"] > 514 and player.registry["sound_test"] < 700) then
				player.registry["sound_test"] = 700
			elseif (player.registry["sound_test"] > 740) then
				player.registry["sound_test"] = 740
			end

			return sound_test.browseSounds(player, npc)
		elseif menu == "Play Again" then
			return sound_test.browseSounds(player, npc)
		elseif menu == "<<- Previous" then
			player.registry["sound_test"] = player.registry["sound_test"] - 1

			if (player.registry["sound_test"] < 700 and player.registry["sound_test"] > 514) then
				player.registry["sound_test"] = 514
			elseif (player.registry["sound_test"] < 500 and player.registry["sound_test"] > 412) then
				player.registry["sound_test"] = 412
			elseif (player.registry["sound_test"] < 400 and player.registry["sound_test"] > 371) then
				player.registry["sound_test"] = 371
			elseif (player.registry["sound_test"] < 300 and player.registry["sound_test"] > 200) then
				player.registry["sound_test"] = 200
			elseif (player.registry["sound_test"] < 200 and player.registry["sound_test"] > 125) then
				player.registry["sound_test"] = 125
			elseif (player.registry["sound_test"] < 1) then
				player.registry["sound_test"] = 1
			end

			return sound_test.browseSounds(player, npc)
		else
		end
	end
}
