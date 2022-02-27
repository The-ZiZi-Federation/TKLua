oKeyPickupsServer0 = {


take = function(player)

	local obj, x, y = getObjFacingXY(player, player.side)
	--local m, x, y = player.m, player.x, player.y
	local m = player.m
	
	if m == 1000 then
		if obj == 7181 then --rock
			setObject(1000, x, y, 0)
			player:addItem("sharp_rock", 1)
			player:talkSelf(0,""..player.name..": I found a rock.")
			player:sendMinitext("You picked up a rock")
			for i = 1, 10 do
				if player.mapRegistry["rock_pickup_"..i] == 0 then
					player.mapRegistry["rock_pickup_"..i] = 1
					player.mapRegistry["rock_pickup_"..i.."_x"] = x
					player.mapRegistry["rock_pickup_"..i.."_y"] = y
					player.mapRegistry["rock_pickup_"..i.."_timer"] = os.time() + 30
					return
				end
			end
		elseif obj == 14150 then --stick
			setObject(1000, x, y, 0)
			player:addItem("sturdy_stick", 1)
			player:talkSelf(0,""..player.name..": I found a stick.")
			player:sendMinitext("You picked up a stick")
			for i = 1, 10 do
				if player.mapRegistry["stick_pickup_"..i] == 0 then
					player.mapRegistry["stick_pickup_"..i] = 1
					player.mapRegistry["stick_pickup_"..i.."_x"] = x
					player.mapRegistry["stick_pickup_"..i.."_y"] = y
					player.mapRegistry["stick_pickup_"..i.."_timer"] = os.time() + 30
					return
				end
			end
		elseif obj == 7814 then --flower
			setObject(1000, x, y, 0)
			player:addItem("pink_flower", 1)
			player:talkSelf(0,""..player.name..": I found a pink flower.")
			player:sendMinitext("You picked up a pink flower")
			for i = 1, 10 do
				if player.mapRegistry["pink_flower_pickup_"..i] == 0 then
					player.mapRegistry["pink_flower_pickup_"..i] = 1
					player.mapRegistry["pink_flower_pickup_"..i.."_x"] = x
					player.mapRegistry["pink_flower_pickup_"..i.."_y"] = y
					player.mapRegistry["pink_flower_pickup_"..i.."_timer"] = os.time() + 30
					return
				end
			end
		elseif obj == 5778 then --drunk's mug
			setObject(1000, x, y, 0)
			player:addItem("drunk_mug", 1)
			player.registry["found_drunk_mug"] = 1
			player:talkSelf(0,""..player.name..": I found a mug. It's still half full, too!")
			player:sendMinitext("You picked up a mug")
			for i = 1, 10 do
				if player.mapRegistry["drunk_mug_pickup_"..i] == 0 then
					player.mapRegistry["drunk_mug_pickup_"..i] = 1
					player.mapRegistry["drunk_mug_pickup_"..i.."_x"] = x
					player.mapRegistry["drunk_mug_pickup_"..i.."_y"] = y
					player.mapRegistry["drunk_mug_pickup_"..i.."_timer"] = os.time() + 30
					return
				end
			end
		end
	elseif (m == 1015) or (m >= 1101 and m <= 1104) then
		if player.side == 0 then
			if obj == 12503 then --candle
				setObject(m, x, y, 12498)
				player:addItem("candle", 1)
				player:talkSelf(0,""..player.name..": This candle might be useful.")
				player:sendMinitext("You took a candle")
				for i = 1, 10 do
					if player.mapRegistry["candle_pickup_"..i] == 0 then
						player.mapRegistry["candle_pickup_"..i] = 1
						player.mapRegistry["candle_pickup_"..i.."_x"] = x
						player.mapRegistry["candle_pickup_"..i.."_y"] = y
						player.mapRegistry["candle_pickup_"..i.."_timer"] = os.time() + 600
						return
					end
				end
		
		
			end
		end
	elseif (m >= 1161 and m <= 1175) then
		if obj == 15798 then --militia rations
			if player.quest["supply_lines"] == 1 then
				setObject(m, x, y, 0)
				player:addItem("militia_rations", 1)
				player:talkSelf(0,""..player.name..": These are the rations I needed!")
				player:sendMinitext("You found Militia Rations")
				for i = 1, 10 do
					if player.mapRegistry["militia_rations_pickup_"..i] == 0 then
						player.mapRegistry["militia_rations_pickup_"..i] = 1
						player.mapRegistry["militia_rations_pickup_"..i.."_x"] = x
						player.mapRegistry["militia_rations_pickup_"..i.."_y"] = y
						player.mapRegistry["militia_rations_pickup_"..i.."_timer"] = os.time() + 300
						return
					end
				end
			end		
		end
	elseif (m >= 3201 and m <= 3209) then
		local randomPick = math.random(1, 100)
		if obj == 16941 then --pickaxe 1
			setObject(m, x, y, 0)
			
			if randomPick <= 50 then 
				player:addItem("old_pickaxe", 1)
			elseif randomPick >= 51 and randomPick <= 75 then
				player:addItem("old_rusty_pickaxe", 1)
			elseif randomPick >= 76 then
				player:addItem("busted_pickaxe", 1)
			end
			
			player:talkSelf(0,""..player.name..": This pickaxe still looks usable.")
			player:sendMinitext("You found a pickaxe")
			for i = 1, 3 do
				if player.mapRegistry["pickaxe1_pickup_"..i] == 0 then
					player.mapRegistry["pickaxe1_pickup_"..i] = 1
					player.mapRegistry["pickaxe1_pickup_"..i.."_x"] = x
					player.mapRegistry["pickaxe1_pickup_"..i.."_y"] = y
					player.mapRegistry["pickaxe1_pickup_"..i.."_timer"] = os.time() + 600
					return
				end
			end
			
		elseif obj == 16942 then --pickaxe 2
			setObject(m, x, y, 0)
			
			if randomPick <= 50 then 
				player:addItem("old_pickaxe", 1)
			elseif randomPick >= 51 and randomPick <= 75 then
				player:addItem("old_rusty_pickaxe", 1)
			elseif randomPick >= 76 then
				player:addItem("busted_pickaxe", 1)
			end
			
			player:talkSelf(0,""..player.name..": This pickaxe still looks usable.")
			player:sendMinitext("You found a pickaxe")
			for i = 1, 3 do
				if player.mapRegistry["pickaxe2_pickup_"..i] == 0 then
					player.mapRegistry["pickaxe2_pickup_"..i] = 1
					player.mapRegistry["pickaxe2_pickup_"..i.."_x"] = x
					player.mapRegistry["pickaxe2_pickup_"..i.."_y"] = y
					player.mapRegistry["pickaxe2_pickup_"..i.."_timer"] = os.time() + 600
					return
				end
			end
			
		elseif obj == 16943 then --pickaxe 3
			setObject(m, x, y, 0)
			
			if randomPick <= 50 then 
				player:addItem("old_pickaxe", 1)
			elseif randomPick >= 51 and randomPick <= 75 then
				player:addItem("old_rusty_pickaxe", 1)
			elseif randomPick >= 76 then
				player:addItem("busted_pickaxe", 1)
			end
			
			player:talkSelf(0,""..player.name..": This pickaxe still looks usable.")
			player:sendMinitext("You found a pickaxe")
			for i = 1, 3 do
				if player.mapRegistry["pickaxe3_pickup_"..i] == 0 then
					player.mapRegistry["pickaxe3_pickup_"..i] = 1
					player.mapRegistry["pickaxe3_pickup_"..i.."_x"] = x
					player.mapRegistry["pickaxe3_pickup_"..i.."_y"] = y
					player.mapRegistry["pickaxe3_pickup_"..i.."_timer"] = os.time() + 600
					return
				end
			end
		end
	end
end,

regen = function()

	oKeyPickupsServer0.rockRegen()
	oKeyPickupsServer0.stickRegen()
	oKeyPickupsServer0.flowerRegen()
	oKeyPickupsServer0.drunkMugRegen()
	oKeyPickupsServer0.candleRegen()
	oKeyPickupsServer0.militiaRationsRegen()
	oKeyPickupsServer0.pickaxeRegen()
end,
pickaxeRegen = function()

	local NPCs = 
		{NPC("Pickaxe Helper 1"),
		NPC("Pickaxe Helper 2"),
		NPC("Pickaxe Helper 3"),
		NPC("Pickaxe Helper 4")}

	for i = 1, 3 do
		for j = 1, #NPCs do
			if NPCs[j].mapRegistry["pickaxe1_pickup_"..i] == 1 then
				if NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_timer"] > 0 and NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_timer"] < os.time() then
				
					x = NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_x"]
					y = NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_y"]
				
					setObject(NPCs[j].m, x, y, 16941)
				
					NPCs[j].mapRegistry["pickaxe1_pickup_"..i] = 0
					NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_x"] = 0
					NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_y"] = 0
					NPCs[j].mapRegistry["pickaxe1_pickup_"..i.."_timer"] = 0
					return
				end
			end
			if NPCs[j].mapRegistry["pickaxe2_pickup_"..i] == 1 then
				if NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_timer"] > 0 and NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_timer"] < os.time() then
				
					x = NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_x"]
					y = NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_y"]
				
					setObject(NPCs[j].m, x, y, 16942)
				
					NPCs[j].mapRegistry["pickaxe2_pickup_"..i] = 0
					NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_x"] = 0
					NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_y"] = 0
					NPCs[j].mapRegistry["pickaxe2_pickup_"..i.."_timer"] = 0
					return
				end
			end
			
			if NPCs[j].mapRegistry["pickaxe3_pickup_"..i] == 1 then
				if NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_timer"] > 0 and NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_timer"] < os.time() then
				
					x = NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_x"]
					y = NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_y"]
				
					setObject(NPCs[j].m, x, y, 16943)
				
					NPCs[j].mapRegistry["pickaxe3_pickup_"..i] = 0
					NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_x"] = 0
					NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_y"] = 0
					NPCs[j].mapRegistry["pickaxe3_pickup_"..i.."_timer"] = 0
					return
				end
			end
		end
	end
end,

rockRegen = function()
	for i = 1, 10 do
		if NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i] == 1 then
			if NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_timer"] > 0 and NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_timer"] < os.time() then
			
				x = NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_x"]
				y = NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_y"]
			
				setObject(1000, x, y, 7181)
			
				NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i] = 0
				NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_x"] = 0
				NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_y"] = 0
				NPC("Hon Guard Eiste").mapRegistry["rock_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end,

stickRegen = function()
	for i = 1, 10 do
		if NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i] == 1 then
			if NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_timer"] > 0 and NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_timer"] < os.time() then
			
				x = NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_x"]
				y = NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_y"]
			
				setObject(1000, x, y, 14150)
			
				NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i] = 0
				NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_x"] = 0
				NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_y"] = 0
				NPC("Hon Guard Eiste").mapRegistry["stick_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end,

flowerRegen = function()
	for i = 1, 10 do
		if NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i] == 1 then
			if NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_timer"] > 0 and NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_timer"] < os.time() then
			
				x = NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_x"]
				y = NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_y"]
			
				setObject(1000, x, y, 7814)
			
				NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i] = 0
				NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_x"] = 0
				NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_y"] = 0
				NPC("Hon Guard Eiste").mapRegistry["pink_flower_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end,

drunkMugRegen = function()
	for i = 1, 10 do
		if NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i] == 1 then
			if NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_timer"] > 0 and NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_timer"] < os.time() then
			
				x = NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_x"]
				y = NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_y"]
			
				setObject(1000, x, y, 5778)
			
				NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i] = 0
				NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_x"] = 0
				NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_y"] = 0
				NPC("Hon Guard Eiste").mapRegistry["drunk_mug_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end,

candleRegen = function()
	for i = 1, 10 do
		if NPC("Underground Helper").mapRegistry["candle_pickup_"..i] == 1 then
			if NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_timer"] > 0 and NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Underground Helper").m
				x = NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_x"]
				y = NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_y"]

			
				setObject(m, x, y, 12503)
			
				NPC("Underground Helper").mapRegistry["candle_pickup_"..i] = 0
				NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_x"] = 0
				NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_y"] = 0
				NPC("Underground Helper").mapRegistry["candle_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Sewer Helper").mapRegistry["candle_pickup_"..i] == 1 then
			if NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] > 0 and NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Sewer Helper").m
				x = NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_x"]
				y = NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_y"]
				m = NPC("Sewer Helper").m
			
				setObject(m, x, y, 12503)
			
				NPC("Sewer Helper").mapRegistry["candle_pickup_"..i] = 0
				NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_x"] = 0
				NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_y"] = 0
				NPC("Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i] == 1 then
			if NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_timer"] > 0 and NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Aqueduct Helper").m
				x = NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_x"]
				y = NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_y"]
				m = NPC("Aqueduct Helper").m
			
				setObject(m, x, y, 12503)
			
				NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i] = 0
				NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_x"] = 0
				NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_y"] = 0
				NPC("Aqueduct Helper").mapRegistry["candle_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i] == 1 then
			if NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] > 0 and NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Secret Sewer Helper").m
				x = NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_x"]
				y = NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_y"]
				m = NPC("Secret Sewer Helper").m
			
				setObject(m, x, y, 12503)
			
				NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i] = 0
				NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_x"] = 0
				NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_y"] = 0
				NPC("Secret Sewer Helper").mapRegistry["candle_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end,


militiaRationsRegen = function()
	for i = 1, 10 do
		if NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i] == 1 then
			if NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_timer"] > 0 and NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Savage Helper 1").m
				x = NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_x"]
				y = NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_y"]
				m = NPC("Savage Helper 1").m
			
				setObject(m, x, y, 15798)
			
				NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i] = 0
				NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_x"] = 0
				NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_y"] = 0
				NPC("Savage Helper 1").mapRegistry["militia_rations_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i] == 1 then
			if NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_timer"] > 0 and NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Savage Helper 2").m
				x = NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_x"]
				y = NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_y"]
				m = NPC("Savage Helper 2").m
			
				setObject(m, x, y, 15798)
			
				NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i] = 0
				NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_x"] = 0
				NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_y"] = 0
				NPC("Savage Helper 2").mapRegistry["militia_rations_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i] == 1 then
			if NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_timer"] > 0 and NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Savage Helper 3").m
				x = NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_x"]
				y = NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_y"]
				m = NPC("Savage Helper 3").m
			
				setObject(m, x, y, 15798)
			
				NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i] = 0
				NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_x"] = 0
				NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_y"] = 0
				NPC("Savage Helper 3").mapRegistry["militia_rations_pickup_"..i.."_timer"] = 0
				return
			end
		end
		if NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i] == 1 then
			if NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_timer"] > 0 and NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_timer"] < os.time() then
			
				m = NPC("Savage Helper 4").m
				x = NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_x"]
				y = NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_y"]
				m = NPC("Savage Helper 4").m
			
				setObject(m, x, y, 15798)
			
				NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i] = 0
				NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_x"] = 0
				NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_y"] = 0
				NPC("Savage Helper 4").mapRegistry["militia_rations_pickup_"..i.."_timer"] = 0
				return
			end
		end
	end
end
}