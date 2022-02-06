onSay = function(player)

	local printf = 1
	local caps = 0
	local speech = player.speech
	local p = player
	
	if (speech == "") then return end
	local lspeech = string.lower(player.speech)
	local length = string.len(lspeech)
	local online = {}
	local talkType = player.talkType
	online = player:getUsers()

	if player:hasDuration("frog") == true then
		printf = 0
		local r = math.random(1,3)
		if r == 1 then
			player:talk(0, player.name..": I'm a frog person! Crrroak!")
		elseif r == 2 then
			player:talk(0, player.name..": Rriibbit!")
		elseif r == 3 then
			player:talk(0, player.name..": I swear I'm a prince! Kiss me!")
		end
	end

	if player:hasDuration("being_frank") == true then
		printf = 0
		player:talk(0,"Frank: "..speech)
	end

	if (player.m == 1099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 3099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 1098) and (player.x > 22 and player.x < 28) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end
	
	if (player.m == 4099) and (player.x > 14 and player.x < 20) and (player.y > 16 and player.y < 21) then
		eye_of_teleportation.talk(player)
	end

	if string.sub(lspeech, 1, 5) == "/roll" then
		player:sendMinitext("You have nothing to roll! Try buying some dice.")
		printf = 0
		return
	end		
	
	if player.gmLevel > 0 then
		local reload = {"/reloadlua", "/rl", "/reloadmaps", "/rm", "/reloadnpc", "/rnpc", "/reloadmob", "/rmob", "/reloadspawn", "rspawn", "/reloaditem", "/ritem", "/reloadmagic", "/rspell", "/reloadboard", "/rboard", "/reloadcreate", "/rcreate", "/reloadwarps", "/rw", "reloadclass", "/rclass"}
		local text = {"LUA Scripts", "LUA Scripts", "Maps DB", "Maps DB", "NPCs DB", "NPCs DB", "Mobs DB", "Mobs DB", "Spawns DB", "Spawns DB", "Items Data", "Items Data", "Spells & Magics", "Spells & Magics", "Boards DB", "Boards DB", "Creation Items Table", "Creation Items Table", "Warps Data", "Warps Data", "Class DB", "Class DB"}
		for i = 1, #reload do
			if lspeech == reload[i] then
				for x = 1, #online do
					if online[x].gmLevel > 0 then
						online[x]:msg(11, "[System] "..text[i].." Reloaded   By: "..player.name.."", online[x].ID)
					end
				end
			end
		end
	end

----------------------------------------------------------------------------------------------------------------------	
	
	
	
	if player.state == 0 then if lspeech == "lol" then player:sendAction(11,80) end end
	






-- TEMPORARY COMMANDS FOR JROC/TENT TO HELP US

-- Icon viewer
	--[[if player.ID == 1723 then
	
		local say = {"nweap", "pweap", "weap", "narmor", "parmor", "armor", "nshield", "pshield", "shield", "nhelm", "phelm", "helm", "ncape", "pcape", "cape", "ncrown", "pcrown", "crown", "nface", "pface", "face", "nboots", "pboots", "boots", "nneck", "pneck", "neck", "nfacea", "pfacea", "facea", "nfaceat", "pfaceat", "faceat", "nhair", "phair", "hair","nsdye","psdye"}
		local name = {"Weapon", "Weapon", "Weapon", "Armor", "Armor", "Armor", "Shield", "Shield", "Shield", "Helmet", "Helmet", "Helmet", "Cape", "Cape", "Cape", "Crown", "Crown", "Crown", "Face", "Face", "Face", "Boots", "Boots", "Boots", "Necklace", "Necklace", "Necklace", "Face Accessory", "Face Accessory", "Face Accessory", "Face AccessoryT", "Face AccessoryT", "Face AccessoryT", "Hair", "Hair", "Hair"}
		local var = {p.gfxWeap, p.gfxWeap, p.gfxWeap, p.gfxArmor, p.gfxArmor, p.gfxArmor, p.gfxShield, p.gfxShield, p.gfxShield, p.gfxHelm, p.gfxHelm, p.gfxHelm, p.gfxCape, p.gfxCape, p.gfxCape, p.gfxCrown, p.gfxCrown, p.gfxCrown, p.gfxFace, p.gfxFace, p.gfxFace, p.gfxBoots, p.gfxBoots, p.gfxBoots, p.gfxNeck, p.gfxNeck, p.gfxNeck, p.gfxFaceA, p.gfxFaceA, p.gfxFaceA, p.gfxFaceAT, p.gfxFaceAT, p.gfxFaceAT, p.gfxHair, p.gfxHair, p.gfxHair}
		local x

        if (string.match(lspeech, "/icon (%d+)") ~= nil and string.match(lspeech, "/icon %d+ (%d+)") == nil) then
            local x = tonumber(string.match(lspeech, "/icon (%d+)"))
            player.registry["gfx_icons"] = x
            player.registry["gfx_icons_color"] = 0
            async(iconViewer(player, "n"))
            printf = 0

        elseif (string.match(lspeech, "/icon %d+ (%d+)") ~= nil) then
            local x = tonumber(string.match(lspeech, "/icon (%d+)"))
            local y = tonumber(string.match(lspeech, "/icon %d+ (%d+)"))
            player.registry["gfx_icons"] = x
            player.registry["gfx_icons_color"] = y
            async(iconViewer(player, "nc"))
            printf = 0
        elseif (lspeech == "nicon") then
                async(iconViewer(player, "n"))
                printf = 0
        elseif (lspeech == "picon") then
                async(iconViewer(player, "p"))
                printf = 0
        elseif (lspeech == "niconc") then
                async(iconViewer(player, "nc"))
                printf = 0
        elseif (lspeech == "piconc") then
                async(iconViewer(player, "pc"))
                printf = 0

		


		-- gfx Toggle switch on/off --
        elseif (lspeech == "/gfx") then                                                                                                           
			gfx_switch.cast(player)
			if player.gfxClone == 0 then
					player:sendMinitext("GFX toogle: OFF")
			elseif player.gfxClone == 1 then
					player:sendMinitext("GFX toogle: ON")
			end
			
			
			
		-- GFX Color
		elseif lspeech == "hairc" then
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
		elseif lspeech == "nhairc" then
			p.gfxHairC = p.gfxHairC +1
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
		elseif lspeech == "phairc" then
			if p.gfxHairC <= 0 then player:sendMinitext("Hair color: "..p.gfxHairC) return else
				p.gfxHairC = p.gfxHairC - 1
			end
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
			
		elseif lspeech == "nhelmc" then
			p.gfxHelmC = p.gfxHelmC + 1
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			player:updateState()
		elseif lspeech == "phelmc" then
			if p.gfxHelmC <= 0 then player:sendMinitext("Helm Color: "..p.gfxHelmC) return else
				p.gfxHelmC = p.gfxHelmC - 1
			end
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			player:updateState()
		elseif lspeech == "helmc" then
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			
		elseif lspeech == "nweapc" then
			p.gfxWeapC = p.gfxWeapC +1
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		elseif lspeech == "pweapc" then
			if p.gfxWeapC <= 0 then player:sendMinitext("Weappn Color: "..player.gfxWeapC) return else
				p.gfxWeapC = p.gfxWeapC - 1
			end
			player:sendMinitext("Weappn Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		elseif lspeech == "nshieldc" then
			p.gfxShieldC = p.gfxShieldC +1
			player:sendMinitext("Shield Color: "..p.gfxShieldC)
			printf = 0
			player:updateState()

		elseif lspeech == "pshieldc" then
			if p.gfxShieldC <= 0 then p:sendMinitext("Shield Color: "..p.gfxShieldC) return else
				p.gfxShieldC = p.gfxShieldC - 1
			end
			p:sendMinitext("Shield Color: "..p.gfxShieldC)
			printf = 0
			player:updateState()
		elseif lspeech == "narmorc" then
			p.gfxArmorC = p.gfxArmorC + 1
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
		elseif lspeech == "parmorc" then
			if p.gfxArmorC <= 0 then player:sendMinitext("Armor Color: "..player.gfxArmorC) return else
				p.gfxArmorC = p.gfxArmorC - 1
			end
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
			
		elseif lspeech == "nweap" then
			if p.gfxWeap == 400 then p.gfxWeap = 10000	
				elseif p.gfxWeap == 10124 then p.gfxWeap = 20000	
				elseif p.gfxWeap == 20131 then p.gfxWeap = 30000	
			else	
				p.gfxWeap = p.gfxWeap + 1	
			end	
			player:sendMinitext("Weapon: "..player.gfxWeap)
			printf = 0
			player:updateState()
		elseif lspeech == "pweap" then
			if p.gfxWeap == 10000 then p.gfxWeap = 400
				elseif p.gfxWeap == 20000 then p.gfxWeap = 10124	
				elseif p.gfxWeap == 30000 then p.gfxWeap = 20131	
			else	
				p.gfxWeap = p.gfxWeap - 1	
			end			
			player:sendMinitext("Weapon: "..player.gfxWeap)
			printf = 0
			player:updateState()
		elseif lspeech == "weap" then
			player:sendMinitext("Weapon: "..player.gfxWeap)
			printf = 0
			player:updateState()
		elseif lspeech == "nshield" then
			if p.gfxShield == 56 then 
				p.gfxShield = 55 
			else 
				p.gfxShield = p.gfxShield + 1 
			end	
			player:sendMinitext("Shield: "..player.gfxShield)
			printf = 0
			player:updateState()
		elseif lspeech == "pshield" then
			if p.gfxShield > 0 then	
				p.gfxShield = 0	
			else	
				p.gfxShield = p.gfxShield - 1	
			end	
			player:sendMinitext("Shield: "..player.gfxShield)
			printf = 0
			player:updateState()
		elseif lspeech == "shield" then	
		
			player:sendMinitext("Shield: "..player.gfxShield)
			printf = 0
			player:updateState()
		elseif lspeech == "narmor" then
			if p.gfxArmor == 448 then 
				p.gfxArmor = 10000
			else
				p.gfxArmor = p.gfxArmor + 1
			end
			player:sendMinitext("Armor: "..player.gfxArmor)
			printf = 0
			player:updateState()
		elseif lspeech == "parmor" then
			if p.gfxArmor <= 0 then 
				player:sendMinitext("Armor : "..player.gfxArmor) return 
			else
				if p.gfxArmor == 10000 then 
					p.gfxArmor = 448
				else
					p.gfxArmor = p.gfxArmor - 1
				end
			end
			player:sendMinitext("Armor: "..player.gfxArmor)
			printf = 0
			player:updateState()	
		elseif lspeech == "nhelm" then
			p.gfxHelm = p.gfxHelm + 1
			player:sendMinitext("Helm: "..player.gfxHelm)
			printf = 0
			player:updateState()
		elseif lspeech == "phelm" then
			if p.gfxHelm < -1 then 
				player:sendMinitext("Helm : "..player.gfxHelm) return 
			else
				p.gfxHelm = p.gfxHelm - 1
			end
			player:sendMinitext("Helm: "..player.gfxHelm)
			printf = 0
			player:updateState()		

		elseif lspeech == "ncrown" then
			p.gfxCrown = p.gfxCrown + 1
			player:sendMinitext("Crown: "..player.gfxCrown)
			printf = 0
			player:updateState()
		elseif lspeech == "pcrown" then
			if p.gfxCrown < -1 then 
				player:sendMinitext("Crown : "..player.gfxCrown) return 
			else
				p.gfxCrown = p.gfxCrown - 1
			end
			player:sendMinitext("Crown: "..player.gfxCrown)
			printf = 0
			player:updateState()	
		
		
		elseif lspeech == "nboots" then
			p.gfxBoots = p.gfxBoots + 1
			player:sendMinitext("Boots: "..player.gfxBoots)
			printf = 0
			player:updateState()
		elseif lspeech == "pboots" then
			if p.gfxBoots < -1 then 
				player:sendMinitext("Boots : "..player.gfxBoots) return 
			else
				p.gfxBoots = p.gfxBoots - 1
			end
			player:sendMinitext("Boots: "..player.gfxBoots)
			printf = 0
			player:updateState()
		elseif lspeech == "ncape" then
			p.gfxCape = p.gfxCape + 1
			player:sendMinitext("Cape: "..player.gfxCape)
			printf = 0
			player:updateState()
		elseif lspeech == "pcape" then
			if p.gfxCape < -1 then 
				player:sendMinitext("Cape: "..player.gfxCape) return 
			else
				p.gfxCape = p.gfxCape - 1
			end
			player:sendMinitext("Cape: "..player.gfxCape)
			printf = 0
			player:updateState()


		elseif lspeech == "ncapec" then
			p.gfxCapeC = p.gfxCapeC + 1
			player:sendMinitext("CapeC: "..player.gfxCapeC)
			printf = 0
			player:updateState()
		elseif lspeech == "pcapec" then
			if p.gfxCapeC < -1 then 
				player:sendMinitext("Cape: "..player.gfxCapeC) return 
			else
				p.gfxCapeC = p.gfxCapeC - 1
			end
			player:sendMinitext("CapeC: "..player.gfxCapeC)
			printf = 0
			player:updateState()





				
		elseif lspeech == "nfacea" then
			p.gfxFaceA = p.gfxFaceA + 1
			player:sendMinitext("Face ACC 1: "..player.gfxFaceA)
			printf = 0
			player:updateState()
		elseif lspeech == "pfacea" then
			if p.gfxFaceA < -1 then 
				player:sendMinitext("Face ACC 1: "..player.gfxFaceA) return 
			else
				p.gfxFaceA = p.gfxFaceA - 1
			end
			player:sendMinitext("Face Acc 1: "..player.gfxFaceA)
			printf = 0
			player:updateState()
				
		elseif lspeech == "nfaceac" then
			p.gfxFaceAC = p.gfxFaceAC + 1
			player:sendMinitext("Face ACC 1 Color: "..player.gfxFaceAC)
			printf = 0
			player:updateState()
		elseif lspeech == "pfaceac" then
			if p.gfxFaceAC < -1 then 
				player:sendMinitext("Face ACC 1 Color: "..player.gfxFaceAC) return 
			else
				p.gfxFaceAC = p.gfxFaceAC - 1
			end
			player:sendMinitext("Face Acc 1 Color: "..player.gfxFaceAC)
			printf = 0
			player:updateState()		
		elseif lspeech == "nfaceat" then
			p.gfxFaceAT = p.gfxFaceAT + 1
			player:sendMinitext("Face ACC 2: "..player.gfxFaceAT)
			printf = 0
			player:updateState()
		elseif lspeech == "pfaceat" then
			if p.gfxFaceAT < -1 then 
				player:sendMinitext("Face ACC 2: "..player.gfxFaceAT) return 
			else
				p.gfxFaceAT = p.gfxFaceAT - 1
			end
			player:sendMinitext("Face Acc 2: "..player.gfxFaceAT)
			printf = 0
			player:updateState()
		elseif lspeech == "nfaceatc" then
			p.gfxFaceATC = p.gfxFaceATC + 1
			player:sendMinitext("Face ACC 2 Color: "..player.gfxFaceATC)
			printf = 0
			player:updateState()
		elseif lspeech == "pfaceatc" then
			if p.gfxFaceATC < -1 then 
				player:sendMinitext("Face ACC 2 Color: "..player.gfxFaceATC) return 
			else
				p.gfxFaceATC = p.gfxFaceATC - 1
			end
			player:sendMinitext("Face Acc 2 Color: "..player.gfxFaceATC)
			printf = 0
			player:updateState()

		elseif lspeech == "ncrownc" then
			p.gfxCrownC = p.gfxCrownC +1
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		elseif lspeech == "pcrownc" then
			if p.gfxCrownC <= 0 then player:sendMinitext("Crown Color: "..player.gfxCrownC) return else
				p.gfxCrownC = p.gfxCrownC - 1
			end
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		elseif lspeech == "nbootsc" then
			p.gfxBootsC = p.gfxBootsC +1
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
			player:updateState()
		elseif lspeech == "pbootsc" then
			if p.gfxBootsC <= 0 then player:sendMinitext("Boots Color: "..player.gfxBootsC) return else
				p.gfxBootsC = p.gfxBootsC - 1
			end
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
			player:updateState()
	
		elseif lspeech == "crownc" then
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
		elseif lspeech == "armorc" then
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
		elseif lspeech == "weapc" then
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
		elseif lspeech == "shieldc" then
			player:sendMinitext("Shield Color: "..player.gfxShieldC)
			printf = 0
		elseif lspeech == "bootsc" then
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
		end
	end





]]--







































----------------------------------------------------------------------------------------------------------------------	
-- ===============================================================================================================	
-- ================================= GM COMMANDs =================================================================	
	
	if player.gmLevel >= 98 then --[[ GM Command ]]---------------------------------------------------------------												

		if lspeech == "/test" then
			onLuaTest(player)
			printf = 0
		end
		


		if (string.match(lspeech, "/shutdown (%d+)") ~= nil and string.match(lspeech, "/shutdown %d+ (%d+)") == nil) then
			local time = tonumber(string.match(lspeech, "/shutdown (%d+)"))/1000
			core.gameRegistry["server_reset_timer"] = os.time() + time
			local allPlayers = player:getUsers()
			for i = 1, #allPlayers do
				allPlayers[i]:setTimer(2, time)
			end
			--printf = 0
		end

		
		if string.match(lspeech, "/warp (%d+)") ~= nil then
			id = string.match(lspeech, "/warp (%d+)")
			if string.len(id) > 5 then
				anim(player)
				player:sendMinitext("MapId not found #"..id)
				return
			end
		end
	
		if lspeech == "/cspells" then cspells(player) printf = 0 end	

		if lspeech == "/gmclick" then
			if player.registry["gm_click"] == 0 then
				player.registry["gm_click"] = 1
				s = "Disabled"
			elseif player.registry["gm_click"] == 1 then
				player.registry["gm_click"] = 0
				s = "Enabled"
			end
			player:sendMinitext("GM Click: "..s)
			printf = 0
		end
		
		if lspeech == "/lockmap" then		-- this is cool.. we can lock a map for access. so just the one who lock the map can enter .
			if player.ID == 2 then
				if player.mapRegistry[player.m.."access"] == 0 then player.mapRegistry[player.m.."access"] = 1
					mark = "lock"
					if player.ID ~= 2 then
						if Player(2) ~= nil then Player(2):msg(4, "                         ["..string.upper(mark).."]    "..player.name.." just "..mark.." '"..player.mapTitle.."' (Id: "..player.m..")    ["..string.upper(mark).."]", Player(2).ID) end
					end
				else player.mapRegistry[player.m.."access"] = 0
					mark = "unlock"
					if player.ID ~= 2 then
						if Player(2) ~= nil then Player(2):msg(4, "                         ["..string.upper(mark).."]    "..player.name.." just "..mark.." '"..player.mapTitle.."' (Id: "..player.m..")    ["..string.upper(mark).."]", Player(2).ID) end
					end					
				end
				player:msg(4, "                         ["..string.upper(mark).."]    '"..player.mapTitle.."' (Id: "..player.m..") is "..mark.."ed!    ["..string.upper(mark).."]", player.ID)
				printf = 0
			end
		end
	
		if lspeech == "/kill" then
			mob, pc = getTargetFacing(player, BL_MOB), getTargetFacing(player, BL_PC)
			if mob ~= nil then
				if mob.state ~= 1 then mob.attacker = 0
					mob:removeHealth(mob.health)
				end
			end
			if pc ~= nil then
				if pc.state ~= 1 and pc.ID ~= 2 and pc.ID ~= 18 then pc.attacker = 0
					pc:removeHealth(pc.health)
				end
			end
			printf = 0
		end
		
		if lspeech == "/kill mob" then
			target = player:getObjectsInMap(player.m, BL_MOB)
			if #target > 0 then
				for i = 1, #target do
					if target[i].owner == 0 then
						target[i].attacker = 0
						target[i]:sendAnimation(420)
						target[i]:sendAnimation(143)
						target[i]:removeHealth(target[i].health)
						player:playSound(59)
					end
				end
			end
			printf = 0
		elseif lspeech == "/kill pc" then
			target = player:getObjectsInMap(player.m, BL_PC)
			if #target > 0 then
				for i = 1, #target do				
					if target[i].ID == 2 or target[i].ID == 4 then return else
						target[i].attacker = 0
						target[i]:sendAnimation(420)
						target[i]:sendAnimation(143)
						target[i]:removeHealth(target[i].health)
						target[i]:sendMinitext("@#$%$#@!@#$%^%$#@")
						player:playSound(59)
					end
				end
			end
			printf = 0
		elseif lspeech == "/mapfile test" then
			print("Test: Map File is "..player.mapfile)
			printf = 0

		end


		-- Forget spell
		if string.match(lspeech, "/del (.+)") ~= nil then
			spell = string.match(lspeech, "/del (.+)")
			if player:hasSpell(spell) then
				player:removeSpell(spell)
				player:sendMinitext("Done!!")
			end
			printf = 0
		end
		
		if (string.match(lspeech, "/mon (%d+)") ~= nil and string.match(lspeech, "/mon %d+ (%d+)") == nil) then
			local id = tonumber(string.match(lspeech, "/mon (%d+)"))
			player:spawn(id, player.x, player.y, 1)
			printf = 0
		elseif (string.match(lspeech, "/mon %d+ (%d+)") ~= nil) then
			local id = tonumber(string.match(lspeech, "/mon (%d+)"))
			local amount = tonumber(string.match(lspeech, "/mon %d+ (%d+)"))
			if amount > 50 then
				anim(player)
				player:sendMinitext("Too many!! (Max:50)")
			else
				player:spawn(id, player.x, player.y, amount)
			end
			printf = 0
		end
		
-- gfx Toggle switch on/off --		
		if lspeech == "/gfxtoogle" or lspeech == "/gfx" then															
			gfx_switch.cast(player)
			if player.gfxClone == 0 then
				player:sendMinitext("GFX toogle: OFF")
			elseif player.gfxClone == 1 then
				player:sendMinitext("GFX toogle: ON")
			end
			printf = 0
		end
	




-- Get spells --
		if string.match(lspeech, "/s (.+)") ~= nil and string.match(lspeech, "/s (.+) %a+") == nil then s = string.match(lspeech, "/s (.+)")
			if not player:hasSpell(s) then
				player:addSpell(s)
				player:sendMinitext("Done!!")
			else anim(player)
				player:sendMinitext("You already has it! / the spell not found!")
			end
			printf = 0
		elseif string.match(lspeech, "/s .+ (%a+)") ~= nil then
			s, t = string.match(lspeech, "/s (.+) %a+"), string.match(lspeech, "/s .+ (%a+)")
			if Player(t) ~= nil then
				if not Player(t):hasSpell(s) then
					Player(t):addSpell(s)
					Player(t):msg(4, "[Operator] Added a new spell!", Player(t).ID)
					player:sendMinitext("Done!!")
				else anim(player)
					player:sendMinitext("Target is already has it! / the spell not found!")
				end
			else anim(player)
				player:sendMinitext("User not found!")
			end
			printf = 0
		end		
	
		if lspeech == "udis" then
			npc, pc, mob = getTargetFacing(player, BL_NPC), getTargetFacing(player, BL_PC), getTargetFacing(player, BL_MOB)
			if npc ~= nil then npc:talk(2, "Dis : "..npc.look..", Color: "..npc.lookColor) end
			if pc ~= nil then pc:talk(2, "Dis : "..pc.disguise..", Color: "..pc.disguiseColor) end
			if mob ~= nil then mob:talk(2, "Dis : "..mob.look..", Color: "..mob.lookColor) end
			printf = 0
		end
		
		if string.match(lspeech, "/setdis (%d+)") ~= nil then
			mob = getTargetFacing(player, BL_MOB)
			id = string.match(lspeech, "/setdis (%d+)")
			if mob ~= nil then
				mob.look = id
				mob:updateState()
			end
			printf = 0
		elseif string.match(lspeech, "/setside (%d+)") ~= nil then
			mob = getTargetFacing(player, BL_MOB)
			id = string.match(lspeech, "/setside (%d+)")
			if mob ~= nil then
				mob.side = id
				mob:sendSide()
			end
			printf = 0
		end
		
		if string.match(lspeech, "/pk (%d+)") ~= nil then
			value = string.match(lspeech, "/pk (%d+)")
			war.set(player.m, value)
			printf = 0
		end
	
		local face2 = {"nface2", "pface2", "face2", "nface2c", "pface2c", "face2c"}
		for i = 1, #face2 do
			if lspeech == face2[i] then
				faceacc.browse(player, face2[i])
				printf = 0
			end
		end
				
		if string.match(lspeech, "face2 (%d+)") ~= nil then
			num = string.match(lspeech, "face2 (%d+)")
			player.faceAccessoryTwo = num
			player:updateState()
			printf = 0
		elseif string.match(lspeech, "face2c (%d+)") ~= nil then
			num = string.match(lspeech, "face2c (%d+)")
			player.faceAccessoryTwoColor = num
			player:updateState()
			printf = 0
		end

		if tonumber(string.match(lspeech, "/flush (.+)")) ~= nil then
			f = tonumber(string.match(lspeech, "/flush (.+)"))
			if f == 1 then
				player:flushAether()
				player:sendMinitext("Done!!")
			elseif f == 2 then
				player:flushDuration()
				player:sendMinitext("Done!!")
			else
				player:msg(0, "[INFO] /flush 1 : Aethers, 2 : Duration", player.ID)
			end
			printf = 0
		end		
		
		if string.match(lspeech, "/jail (.+)") ~=nil then
			target = Player(tostring(string.match(lspeech, "/jail (.+)")))			
			if target ~= nil then
				if target.ID == 2 then
					anim(player)
					god:msg(4, "[INFO] "..player.name.." is trying to jail you via GM command", god.ID)
				return else
					target:warp(1, 9, 6)
					target:sendAnimation(16)
					target:playSound(29)
					player:sendMinitext(target.name.." has been jailed!")
					broadcast(-1, "[INFO] "..target.name.." has been jailed !!")
				end
			else
				anim(player)
				player:sendMinitext("user not found!")
			end
			printf = 0
		end
		
-- Ability to walk through the walls switch on/off for GM
		if lspeech == "/ww" then
			player.optFlags = 128
			player:refresh()
			player:updateState()
			player:sendStatus()
			player:sendMinitext("You use ww!")
			printf = 0
		end		
	
-- Flush Aethers --	


-- Change Totem --  Totem:  (0)JuJak, (1)Baekho, (2)Hyun Moo, (3)Chung Ryong, (4)Nothing
		for i = 0, 3 do																		
			if string.match(string.lower(player.speech), "/totem "..i) then
				player.totem = i
				player:sendMinitext("Totem: "..i)
				player:sendStatus()
				player:status()
				player:calcStat()
				player:updateState()
				printf = 0
			end
		end

-- Switch to on/off GM chat channel
		if lspeech == "/gmc" then
			if player.registry["gm_talk2"] == 0 then
				player.registry["gm_talk2"] = 1
				stats = "On"
			else
				player.registry["gm_talk2"] = 0
				stats = "Off"
			end
			player:sendMinitext("GM Chanel: "..stats)
			return
		end

-- test action 1,2,3,4,5,etc...		
		for i = 1, 32 do
			if string.match(string.lower(player.speech), "/act "..i) then
				player:sendAction(i, 60)
				printf = 0
			end
		end

-- Clean floor -- remove all items around on ground
		if player.speech == "/cfloor" then
			item = player:getObjectsInArea(BL_ITEM)
			if #item > 0 then
				for i = 1, #item do
					if distanceSquare(player, item[i], 5) then
						item[i]:delete()
						player:sendAction(6, 20)
					end
				end
			end
			player:talk(1, "Sweeping time!!")
		end
		
		if string.match(lspeech, "/port (%d+, %d+, %d+)") ~= nil or string.match(lspeech, "/port (%d+ %d+ %d+)") ~= nil then
			m = string.match(lspeech, "/port (%d+), %d+, %d+") or string.match(lspeech, "/port (%d+) %d+ %d+")
			x = string.match(lspeech, "/port %d+, (%d+), %d+") or string.match(lspeech, "/port %d+ (%d+) %d+")
			y = string.match(lspeech, "/port %d+, (%d+), (%d+)") or string.match(lspeech, "/port %d+ %d+ (%d+)")
			--player:sendFrontAnimation(228, player.side, 1)
			player:freeAsync()
			insert_warps.confirm(player, player.m, player.x, player.y, m, x, y)
			printf = 0
		
		elseif string.match(lspeech, "/port start") ~= nil then 
			player:freeAsync()
			insert_warps.startline(player)
			printf = 0
		elseif string.match(lspeech, "/port end") ~= nil then 
			player:freeAsync()
			insert_warps.endline(player)
			printf = 0	
		end
		
-- Add Gold 		
		if tonumber(string.match(lspeech, "/gold (%d+)")) ~= nil then
			if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
				if tonumber(string.match(lspeech, "/gold (%d+)")) < 0 
				or player.money + tonumber(string.match(lspeech, "(%d+)")) > 3000000000 then
					anim(player)
					player:sendMinitext("Over limit!")
					return
				end
				player:addGold(tonumber(string.match(lspeech, "/gold (%d+)")))
				player:sendMinitext("Added "..format_number(tonumber(string.match(lspeech, "/gold (%d+)"))).." coins")
				printf = 0
			else
				player:popUp("NO!")
			end
		end
	end
	
	if player.gmLevel > 0 or player.registry["morna"] == 1 then
	
		local say = {"nweap", "pweap", "weap", "narmor", "parmor", "armor", "nshield", "pshield", "shield", "nhelm", "phelm", "helm", "ncape", "pcape", "cape", "ncrown", "pcrown", "crown", "nface", "pface", "face", "nboots", "pboots", "boots", "nneck", "pneck", "neck", "nfacea", "pfacea", "facea", "nfaceat", "pfaceat", "faceat", "nhair", "phair", "hair","nsdye","psdye"}
		local name = {"Weapon", "Weapon", "Weapon", "Armor", "Armor", "Armor", "Shield", "Shield", "Shield", "Helmet", "Helmet", "Helmet", "Cape", "Cape", "Cape", "Crown", "Crown", "Crown", "Face", "Face", "Face", "Boots", "Boots", "Boots", "Necklace", "Necklace", "Necklace", "Face Accessory", "Face Accessory", "Face Accessory", "Face AccessoryT", "Face AccessoryT", "Face AccessoryT", "Hair", "Hair", "Hair"}
		local var = {p.gfxWeap, p.gfxWeap, p.gfxWeap, p.gfxArmor, p.gfxArmor, p.gfxArmor, p.gfxShield, p.gfxShield, p.gfxShield, p.gfxHelm, p.gfxHelm, p.gfxHelm, p.gfxCape, p.gfxCape, p.gfxCape, p.gfxCrown, p.gfxCrown, p.gfxCrown, p.gfxFace, p.gfxFace, p.gfxFace, p.gfxBoots, p.gfxBoots, p.gfxBoots, p.gfxNeck, p.gfxNeck, p.gfxNeck, p.gfxFaceA, p.gfxFaceA, p.gfxFaceA, p.gfxFaceAT, p.gfxFaceAT, p.gfxFaceAT, p.gfxHair, p.gfxHair, p.gfxHair}
		local x
		
		if (speech=="nside")then
			if (player.side == -2) then
				player:sendMinitext("Skipping -1.")
				player.side = 0
				return
			end
			player.side = player.side + 1
			player:sendSide()
			printf = 0
		elseif (speech=="pside")then
			if (player.side == 0) then
				player:sendMinitext("Can't have negative side.")
				return
			end
			player.side = player.side - 1
			player:sendSide()
			printf = 0			
		elseif (speech=="side")then
			player:sendMinitext("Side: "..player.side)
			printf = 0			
		elseif lspeech == "ncapec" then
			p.gfxCapeC = p.gfxCapeC + 1
			player:sendMinitext("CapeC: "..player.gfxCapeC)
			printf = 0
			player:updateState()
		elseif lspeech == "pcapec" then
			if p.gfxCapeC < -1 then 
				player:sendMinitext("CapeC: "..player.gfxCapeC) return 
			else
				p.gfxCapeC = p.gfxCapeC - 1
			end
			player:sendMinitext("CapeC: "..player.gfxCapeC)
			printf = 0
			player:updateState()



		end

	




		
		if tonumber(string.match(lspeech, "obj (%d+)")) ~= nil then
			obj = tonumber(string.match(lspeech, "obj (%d+)"))
			object.setFacingObject(player, "set", obj)
			printf = 0
		elseif tonumber(string.match(lspeech, "tile (%d+)")) ~= nil then
			tile = tonumber(string.match(lspeech, "tile (%d+)"))
			setTile(player.m, player.x, player.y, tile)
			printf = 0			
		elseif (speech == "nobj") then
			object.next_prev(player, "next")
			printf = 0
		elseif (speech == "pobj") then
			object.next_prev(player, "prev")
			printf = 0
		elseif lspeech == "cobj" then
			object.setFacingObject(player, "del", 0)
			printf = 0
		elseif (lspeech == "obj") then
			player:talk(0, "Obj: "..getObject(player.m, player.x, player.y))
			object.getObject(player)
			printf = 0
		elseif lspeech == "tile" then
			player:talk(0, "Tile: "..getTile(player.m, player.x, player.y))
			printf = 0
		elseif (speech == "ntile") then
			if (getTile(p.m, p.x, p.y) == 38108) then
				player:sendMinitext("You are at the last tile: 38108")
			else
				setTile(p.m, p.x, p.y, getTile(p.m, p.x, p.y) + 1)
				player:sendMinitext("Tile : "..getTile(p.m, p.x, p.y))
			end
			printf = 0
		elseif (speech == "ptile") then
			if (getTile(p.m, p.x, p.y) == 0) then
				player:sendMinitext("You are at the first tile: 0")
			else
				setTile(p.m, p.x, p.y, getTile(p.m, p.x, p.y) - 1)
				player:sendMinitext("Tile : "..getTile(p.m, p.x, p.y))
			end
			printf = 0			
		end	
		
-- Summon		
		if string.match(lspeech, "/sum (.+)") ~= nil then
			sum = tostring(string.match(lspeech, "/sum (.+)")) target = Player(sum)
			if target ~= nil then
				if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
					target:warp(player.m, player.x, player.y)
				else
					if target.registry["being_summon"] == 0 then
						target:warp(player.m, player.x, player.y)
					else
						player:sendMinitext("Sorry, I'm busy right now!")
						player:msg(4, "[Summon] "..player.name.." is try to Summon you", target.ID)
					end
				end
			else
				anim(player)
				player:sendMinitext("User not found!")
			end
			printf = 0
		end
		
-- Approach 		
		if string.match(lspeech, "/app (.+)") ~=nil then
			app = tostring(string.match(lspeech, "/app (.+)")) target = Player(app)				
			if target ~= nil then
				if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
					player:warp(target.m, target.x, target.y)
				else
					if target.registry["being_approach"] == 0 then
						player:warp(target.m, target.x, target.y)
					else
						player:sendMinitext("Sorry, I'm busy right now!")
						player:msg(4, "[Approach] "..player.name.." is try to approach on you", target.ID)
					end
				end
			else
				anim(player)
				player:sendMinitext("user not found!")
			end
			printf = 0
		end
		
		if lspeech == "nthrow" then
			if player.registry["throw_icon"] > 5450 then
				player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			return else
				player.registry["throw_icon"] = player.registry["throw_icon"] + 1
				player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			end
			printf = 0
		elseif lspeech == "pthrow" then
			if player.registry["throw_icon"] <= 0 then
				player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			return else
				player.registry["throw_icon"] = player.registry["throw_icon"] - 1
				player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			end
			printf = 0
		elseif lspeech == "throw" then
			player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			printf = 0
		elseif string.match(lspeech, "throw (%d+)") ~=nil then
			icon = tonumber(string.match(lspeech, "throw (%d+)"))
			player.registry["throw_icon"] = icon
			player:sendMinitext("Throw Icon : "..player.registry["throw_icon"])
			printf = 0
		end
		
		if lspeech == "/totalmob" then
			mob = player:getObjectsInMap(player.m, BL_MOB)
			player:talk(2, "#Mobs : "..#mob)
			player:sendMinitext("#Mobs : "..#mob)
			printf = 0
		elseif lspeech == "/totalitem" then
			item = player:getObjectsInMap(player.m, BL_ITEM)
			player:talk(2, "#Items : "..#item)
			player:sendMinitext("#items : "..#item)
			printf = 0
		end
		
	
		if (lspeech == "pass") then
			local pass = getPass(player.m, player.x, player.y)
			local string2
			if pass == 0 then
				string2 = "True"
			elseif pass == 1 then
				string2 = "False"
			end
			player:talk(2, "Pass: "..string2)
			printf = 0
		end		

-- Increase Speed
	
		for i = 0, 100 do
			if string.lower(player.speech) == "/ms "..i then
				player.speed = i
				player:sendMinitext("Move Speed : "..i)
				player:updateState()
				printf = 0
			end
		end
		
-- GFX Color
		if lspeech == "hairc" then
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
		elseif lspeech == "nhairc" then
			p.gfxHairC = p.gfxHairC +1
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
		elseif lspeech == "phairc" then
			if p.gfxHairC <= 0 then player:sendMinitext("Hair color: "..p.gfxHairC) return else
				p.gfxHairC = p.gfxHairC - 1
			end
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
			
		elseif lspeech == "nhelmc" then
			p.gfxHelmC = p.gfxHelmC + 1
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			player:updateState()
		elseif lspeech == "phelmc" then
			if p.gfxHelmC <= 0 then player:sendMinitext("Helm Color: "..p.gfxHelmC) return else
				p.gfxHelmC = p.gfxHelmC - 1
			end
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			player:updateState()
		elseif lspeech == "helmc" then
			player:sendMinitext("Helm Color: "..p.gfxHelmC)
			printf = 0
			
		elseif lspeech == "nweapc" then
			p.gfxWeapC = p.gfxWeapC +1
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		elseif lspeech == "pweapc" then
			if p.gfxWeapC <= 0 then player:sendMinitext("Weappn Color: "..player.gfxWeapC) return else
				p.gfxWeapC = p.gfxWeapC - 1
			end
			player:sendMinitext("Weappn Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		elseif lspeech == "nshieldc" then
			p.gfxShieldC = p.gfxShieldC +1
			player:sendMinitext("Shield Color: "..p.gfxShieldC)
			printf = 0
			player:updateState()

		elseif lspeech == "pshieldc" then
			if p.gfxShieldC <= 0 then p:sendMinitext("Shield Color: "..p.gfxShieldC) return else
				p.gfxShieldC = p.gfxShieldC - 1
			end
			p:sendMinitext("Shield Color: "..p.gfxShieldC)
			printf = 0
			player:updateState()
		elseif lspeech == "narmorc" then
			p.gfxArmorC = p.gfxArmorC + 1
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
		elseif lspeech == "parmorc" then
			if p.gfxArmorC <= 0 then player:sendMinitext("Armor Color: "..player.gfxArmorC) return else
				p.gfxArmorC = p.gfxArmorC - 1
			end
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
		elseif lspeech == "ncrownc" then
			p.gfxCrownC = p.gfxCrownC +1
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		elseif lspeech == "pcrownc" then
			if p.gfxCrownC <= 0 then player:sendMinitext("Crown Color: "..player.gfxCrownC) return else
				p.gfxCrownC = p.gfxCrownC - 1
			end
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		elseif lspeech == "nbootsc" then
			p.gfxBootsC = p.gfxBootsC +1
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
			player:updateState()
		elseif lspeech == "pbootsc" then
			if p.gfxBootsC <= 0 then player:sendMinitext("Boots Color: "..player.gfxBootsC) return else
				p.gfxBootsC = p.gfxBootsC - 1
			end
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
			player:updateState()
			
		elseif lspeech == "crownc" then
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
		elseif lspeech == "armorc" then
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
		elseif lspeech == "weapc" then
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
		elseif lspeech == "shieldc" then
			player:sendMinitext("Shield Color: "..player.gfxShieldC)
			printf = 0
		elseif lspeech == "bootsc" then
			player:sendMinitext("Boots Color: "..player.gfxBootsC)
			printf = 0
		end
		
--  but looks like now, us.. no "show off GMs" between us. so let active it.
		
		local ok = true
		
		if ok == true then
			for x = 1, #say do
				if (lspeech==""..say[x] or string.match(lspeech, ""..say[x].." (%d+)") ~= nil or string.match(lspeech, ""..say[x].." %d+ (%d+)") ~= nil) and string.sub(lspeech, 0, string.len(say[x])) == say[x] then
					local nn = 0
					local x2 = x - 2
					
					if x%3 == 0 then
	-- GFX Look
						if string.match(lspeech, ""..say[x].." (%d+)") ~= nil then
							vn = tonumber(string.match(lspeech, ""..say[x].." (%d+)"))
							if x == 3 		then p.gfxWeap = vn
								elseif x == 6 then p.gfxArmor = vn
								elseif x == 9 then p.gfxShield = vn
								elseif x == 12 then p.gfxHelm = vn
								elseif x == 15 then p.gfxCape = vn
								elseif x == 18 then p.gfxCrown = vn
								elseif x == 21 then p.gfxFace = vn
								elseif x == 24 then p.gfxBoots = vn
								elseif x == 27 then p.gfxNeck = vn
								elseif x == 30 then p.gfxFaceA = vn
								elseif x == 33 then p.gfxFaceAT = vn
								elseif x == 36 then p.gfxHair = vn
							end
	-- GFX Look Color						
							if string.match(lspeech, ""..say[x].." %d+ (%d+)") ~= nil then
								vnc = tonumber(string.match(lspeech, ""..say[x].." %d+ (%d+)"))
								if x == 3 then p.gfxWeapC = vnc
									elseif x == 6 then p.gfxArmorC = vnc
									elseif x == 9 then p.gfxShieldC = vnc
									elseif x == 12 then p.gfxHelmC = vnc
									elseif x == 15 then p.gfxCapeC = vnc
									elseif x == 18 then p.gfxCrownC = vnc
									elseif x == 21 then p.gfxFaceC = vnc
									elseif x == 24 then p.gfxBootsC = vnc
									elseif x == 27 then p.gfxNeckC = vnc
									elseif x == 30 then p.gfxFaceAC = vnc
									elseif x == 33 then p.gfxFaceATC = vnc
									elseif x == 36 then p.gfxHairC = vnc
								end
							end

							player:updateState()
							player:sendMinitext(""..name[x].." Number: "..vn.." Color: "..vnc.."")
						elseif lspeech == say[x] then
							player:sendMinitext(""..name[x].." GFX: "..var[x])
						end
						nn = 1
					end			
				if nn == 0 then	
					if x2 % 3 == 0 then	
						if var[x] == 65535 then	
							player:sendMinitext("You have reached the minimum of  "..name[x].." GFX; -1.")	
						else	
							if x <= 3 then	
								if var[x] == 10000 then p.gfxWeap = 400
									elseif var[x] == 20000 then p.gfxWeap = 10124	
									elseif var[x] == 30000 then p.gfxWeap = 20131	
								else	
									p.gfxWeap = var[x] - 1	
								end	
							elseif x <= 6 then	
								if var[x] == 10000 then	
									p.gfxArmor = 349	
								else	
									p.gfxArmor = var[x] - 1	
								end	
							elseif x <= 9 then	
								if var[x] == 10000 then	
									p.gfxShield = 50	
								else	
									p.gfxShield = var[x] - 1	
								end	
							elseif x <= 12 then p.gfxHelm = var[x] - 1	
							elseif x <= 15 then p.gfxCape = var[x] - 1	
							elseif x <= 18 then p.gfxCrown = var[x] - 1	
							elseif x <= 21 then p.gfxFace = var[x] - 1	
							elseif x <= 24 then p.gfxBoots = var[x] - 1	
							elseif x <= 27 then p.gfxNeck = var[x] - 1	
							elseif x <= 30 then p.gfxFaceA = var[x] - 1	
							elseif x <= 33 then p.gfxFaceAT = var[x] - 1	
							elseif x <= 36 then	
								p.gfxHair = var[x] - 1	
							end	
							player:updateState()	
							player:sendMinitext(""..name[x].." Number: "..(var[x] - 1).."")	
						end						
					else	
						if x <= 3 then	
							if var[x] == 400 then p.gfxWeap = 10000	
								elseif var[x] == 10124 then p.gfxWeap = 20000	
								elseif var[x] == 20131 then p.gfxWeap = 30000	
							else	
								p.gfxWeap = var[x] + 1	
							end	
						elseif x <= 6 then	
							if var[x] == 349 then p.gfxArmor = 10000 else p.gfxArmor = var[x] + 1 end	
						elseif x <= 9 then	
							if var[x] == 50 then p.gfxShield = 10000 else p.gfxShield = var[x] + 1 end	
						elseif x <= 12 then p.gfxHelm = var[x] + 1	
						elseif x <= 15 then p.gfxCape = var[x] + 1	
						elseif x <= 18 then p.gfxCrown = var[x] + 1	
						elseif x <= 21 then p.gfxFace = var[x] + 1	
						elseif x <= 24 then p.gfxBoots = var[x] + 1	
						elseif x <= 27 then p.gfxNeck = var[x] + 1	
						elseif x <= 30 then p.gfxFaceA = var[x] + 1	
						elseif x <= 33 then p.gfxFaceAT = var[x] + 1	
						elseif x <= 36 then p.gfxHair = var[x] + 1	
						end	
						player:updateState()	
						player:sendMinitext(""..name[x].." Number: "..(var[x] + 1).."")	
					end	
				end
				printf = 0
				break
				end
			end
		end
		
-- Icon viewer
		if (string.match(lspeech, "/icon (%d+)") ~= nil and string.match(lspeech, "/icon %d+ (%d+)") == nil) then
			local x = tonumber(string.match(lspeech, "/icon (%d+)"))
			player.registry["gfx_icons"] = x
			player.registry["gfx_icons_color"] = 0
			async(iconViewer(player, "n"))
			printf = 0
			
		elseif (string.match(lspeech, "/icon %d+ (%d+)") ~= nil) then
			local x = tonumber(string.match(lspeech, "/icon (%d+)"))
			local y = tonumber(string.match(lspeech, "/icon %d+ (%d+)"))
			player.registry["gfx_icons"] = x
			player.registry["gfx_icons_color"] = y
			async(iconViewer(player, "nc"))
			printf = 0
		elseif (lspeech == "nicon") then
			async(iconViewer(player, "n"))
			printf = 0
		elseif (lspeech == "picon") then
			async(iconViewer(player, "p"))
			printf = 0
		elseif (lspeech == "niconc") then
			async(iconViewer(player, "nc"))
			printf = 0
		elseif (lspeech == "piconc") then
			async(iconViewer(player, "pc"))
			printf = 0
			
-- Change disguise / mob look (must on state 4)
		elseif (speech=="ndis") then

			local oldstate = player.state
			
			player.state = 0
			player:updateState()
			if player.disguise == 1340 then
				player.disguise = player.disguise + 3
			else
				player.disguise = player.disguise + 1
			end
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
		elseif (speech=="pdis") then
			if (player.disguise == 0) then
				player:sendMinitext("You may not have negative disguise.")
				return
			end
			local oldstate = player.state
			
			player.state = 0			
			player:updateState()
			if player.disguise == 1343 then
				player.disguise = player.disguise - 3
			else
				player.disguise = player.disguise - 1
			end
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
			
		elseif (speech=="dis")then
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
			
--Disguise Color
		elseif (string.match(speech, "dis (%d+)") ~= nil and string.sub(speech, 0, 3) == "dis") then
			
			local oldstate = player.state
				
			player.state = 0
			player:updateState()
			
			if (tonumber(string.match(speech, "dis (%d+)")) < 0 or tonumber(string.match(speech, "dis (%d+)")) == 1342 or tonumber(string.match(speech, "dis (%d+)")) == 1394) then
				player:sendMinitext("Disguise not allowed.")
			else
				player.disguise = tonumber(string.match(speech, "dis (%d+)"))
			end
			player.state = oldstate
			player:updateState()
			printf = 0
			
		elseif (speech=="ndisc") then
			if (player.disguiseColor == 255) then player:sendMinitext("You may not go over 255 on disguiseColor.") printf = 0 else
				player.disguiseColor = player.disguiseColor + 1
				player:updateState()
				player:sendMinitext("Disguise Color #: "..player.disguiseColor)
				printf = 0
			end
			
		elseif (speech=="pdisc") then
			if player.disguiseColor <= 0 then player:sendMinitext("You may not have negative disguise color.") printf = 0 else
				player.disguiseColor = player.disguiseColor - 1
				player:updateState()
				player:sendMinitext("Disguise Color #: "..player.disguiseColor)
				printf = 0
			end
			
		elseif (speech=="disc")then
			player:sendMinitext("Disguise Color #: "..player.disguiseColor)
			printf = 0			

-- Change armor color / dye	--		
		elseif (speech=="ndye")then
			if (player.gfxClone == 1) then player.gfxDye = player.gfxDye + 1 else player.armorColor = player.armorColor + 1 end
			player:refresh()
			printf = 0
			
		elseif (speech=="pdye")then
			if (player.gfxClone == 1) then player.gfxDye = player.gfxDye - 1 else player.armorColor = player.armorColor - 1 end
			player:refresh()
			printf = 0
			
		elseif (speech=="nsdye")then 
			if (player.gfxClone == 1) then player.gfxShieldC = player.gfxShieldC + 1 else player.armorColor = player.armorColor + 1 end
			player:refresh()
			printf = 0
			
		elseif (speech=="psdye")then
			if (player.gfxClone == 1) then player.gfxShieldC = player.gfxShieldC - 1 else player.armorColor = player.armorColor - 1 end
			player:refresh()
			printf = 0
			
		elseif (speech=="sdye")then
			--player:talk(0,"what the "..player.gfxClone)
			if (player.gfxClone == 1) then player:sendMinitext("gfxShieldC: "..player.gfxShieldC) else player.armorColor = player.armorColor - 1 end
			player:refresh()
			printf = 0
			
		elseif (speech=="dye")then
			if (player.gfxClone == 1) then player:sendMinitext("gfxDye: "..player.gfxDye) else player:sendMinitext("Dye: "..player.armorColor) end
			printf = 0
			
		elseif (string.match(speech, "dye (%d+)") ~= nil and string.sub(speech, 0, 3) == "dye") then
			if (player.gfxClone == 1) then player.gfxDye = tonumber(string.match(speech, "dye (%d+)")) else player.armorColor = tonumber(string.match(speech, "dye (%d+)")) end
			player:refresh()
			printf = 0

-- Change skin color			
		elseif (speech=="nskin")then
			if (player.gfxClone == 1) then player.gfxSkinC = player.gfxSkinC + 1 else player.skinColor = player.skinColor + 1 end
			player:updateState()
			printf = 0
			
		elseif (speech=="pskin")then
			if (player.gfxClone == 1) then player.gfxSkinC = player.gfxSkinC - 1 else player.skinColor = player.skinColor - 1 end
			player:updateState()
			printf = 0
			
		elseif (speech=="skin")then
			if (player.gfxClone == 1) then player:talk(0, "gfxSkinC: "..player.gfxSkinC) else player:talk(0,"Skin color: "..player.skinColor) end	
			printf = 0

		elseif (string.match(speech, "skin (%d+)") ~= nil and string.sub(speech, 0, 4) == "skin") then
			if (player.gfxClone == 1) then player.gfxSkinC = tonumber(string.match(speech, "skin (%d+)")) else player.skinColor = tonumber(string.match(speech, "skin (%d+)")) end
			player:updateState()
			printf = 0

-- Browse spells animation 			
		elseif (speech=="nspell") then
			if (player.registry["gfx_spell"] == 648) then
				player:sendMinitext("You may not go over 648 on spell graphics.")
			else
				player.registry["gfx_spell"] = player.registry["gfx_spell"] + 1
				player:sendAnimation(player.registry["gfx_spell"])
				--player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
				player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			end
			
			printf = 0
		elseif (speech=="pspell") then
			if (player.registry["gfx_spell"] == 0) then
				player:sendMinitext("You may not have negative spell graphics.")
			else
				player.registry["gfx_spell"] = player.registry["gfx_spell"] - 1
				player:sendAnimation(player.registry["gfx_spell"])
			--	player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
				player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			end
			
			player:sendAnimation(player.registry["gfx_spell"])
			printf = 0
		elseif (speech=="spell") then
			player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
		--	player:sendAnimation(player.registry["gfx_spell"])
			printf = 0
		elseif (string.match(speech, "spell (%d+)") ~= nil and string.sub(speech, 0, 5) == "spell") then
			player.registry["gfx_spell"] = tonumber(string.match(speech, "spell (%d+)"))
			player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
		--	player:sendAnimation(player.registry["gfx_spell"])
			printf = 0

			
-- Browse sound effect			
		elseif (speech=="nsound") then
			if (player.registry["gfx_sound"] == 1518) then
				player:sendMinitext("You may not go over 1518 on sound effects.")
			else
				if (player.registry["gfx_sound"] == 147) then
					player.registry["gfx_sound"] = 200
				elseif (player.registry["gfx_sound"] == 206) then
					player.registry["gfx_sound"] = 300
				elseif (player.registry["gfx_sound"] == 313) then
					player.registry["gfx_sound"] = 331
				elseif (player.registry["gfx_sound"] == 371) then
					player.registry["gfx_sound"] = 401
				elseif (player.registry["gfx_sound"] == 421) then
					player.registry["gfx_sound"] = 500
				elseif (player.registry["gfx_sound"] == 514) then
					player.registry["gfx_sound"] = 600
				elseif (player.registry["gfx_sound"] == 603) then
					player.registry["gfx_sound"] = 700
				elseif (player.registry["gfx_sound"] == 740) then
					player.registry["gfx_sound"] = 900
				elseif (player.registry["gfx_sound"] == 910) then
					player.registry["gfx_sound"] = 1001
				else
					player.registry["gfx_sound"] = player.registry["gfx_sound"] + 1
				end
				player:playSound(player.registry["gfx_sound"])
				player:sendMinitext("Sound : "..player.registry["gfx_sound"])
			end
			
			printf = 0
		elseif (speech=="psound") then
			if (player.registry["gfx_sound"] == 0) then
				player:sendMinitext("You may not have negative sound effects.")
			else
				if (player.registry["gfx_sound"] == 200) then
					player.registry["gfx_sound"] = 147
				elseif (player.registry["gfx_sound"] == 300) then
					player.registry["gfx_sound"] = 206
				elseif (player.registry["gfx_sound"] == 331) then
					player.registry["gfx_sound"] = 313
				elseif (player.registry["gfx_sound"] == 401) then
					player.registry["gfx_sound"] = 371
				elseif (player.registry["gfx_sound"] == 500) then
					player.registry["gfx_sound"] = 421
				elseif (player.registry["gfx_sound"] == 600) then
					player.registry["gfx_sound"] = 514
				elseif (player.registry["gfx_sound"] == 700) then
					player.registry["gfx_sound"] = 603
				elseif (player.registry["gfx_sound"] == 900) then
					player.registry["gfx_sound"] = 740
				elseif (player.registry["gfx_sound"] == 1001) then
					player.registry["gfx_sound"] = 910
				else
					player.registry["gfx_sound"] = player.registry["gfx_sound"] - 1
				end
				
				player:playSound(player.registry["gfx_sound"])
				player:sendMinitext("Sound : "..player.registry["gfx_sound"])
			end
			printf = 0
		elseif (speech=="sound") then
			player:sendMinitext("Sound #: "..player.registry["gfx_sound"])
			player:playSound(player.registry["gfx_sound"])
			printf = 0
		elseif (string.match(speech, "sound (%d+)") ~= nil and string.sub(speech, 0, 5) == "sound") then
			player.registry["gfx_sound"] = tonumber(string.match(speech, "sound (%d+)"))
			player:playSound(player.registry["gfx_sound"])
			printf = 0
		end
	end
----------------------------------------------------------------------------------------------------------
-- set afk message	
	if (string.sub(lspeech, 1, 5) == "/afk ") then
		player.afkMessage = string.sub(lspeech, 6)
		printf = 0
	end

-- Test connection speed	
	if (lspeech == "/ping") then
		if player:hasDuration("ping") then
			player:setDuration("ping", 0)
		else
			player:setDuration("ping", 60000)
		end
		printf = 0
	end

-- Time Played (added 8-7-16)
	if (lspeech == "/played") then
		player:msg(4, "This session: "..getSessionTimePlayed(player).."  Total time played: "..getTotalTimePlayed(player), player.ID)
			printf = 0
	end

-- Calculator
	if (string.byte(speech,1)==61) then--== 99)then
		if ((string.byte(speech,2)>=48) and (string.byte(speech,2)<=57)) or ((string.byte(speech,2)==40) and ((string.byte(speech,3)>=48) and (string.byte(speech,3)<=57))) or ((string.byte(speech,2)==46) and ((string.byte(speech,3)>=48) and (string.byte(speech,3)<=57)))then
			local eq = string.gsub(speech,"=","")
			local f, l, x
			f = ""
			for l in string.gmatch(eq,".") do f = f..l end	
			x = string.gsub(""..f.." = $return "..f.."$", "%$(.-)%$", function (s) return loadstring(s)() end)
			player:talk(0, ""..x)
			printf = 0
		end
	end

-- Sensitive commands!!-------------------------------------------------------------------------------------------------------------
	if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
		if speech == "/gmspell" then
			player:addGMSpells()
			return
		end
		
		if (string.match(player.speech, "/testmap (.+)") ~= nil and string.sub(player.speech, 1, 8) == "/testmap") then
			local map = string.match(player.speech, "/testmap (.+)")
			local mapNum = 50000 + player.ID
			
			if (string.byte(map, string.len(map) - 3) == 46) then
				os.execute("cd ../mYnexiaMaps;svn up;cd ../mynexia")
				setMap(mapNum, "../mYnexiaMaps/"..map)
				player:warp(mapNum, 5, 5)
				player.spell = 1
			else
				player:sendMinitext("Only .map is supported, sorry.")
			end	
			printf = 0
		end
		-- Mapper End
		
		if (lspeech == "svn up") then
			os.execute("cd ../mYnexiaMaps;svn up;cd ../mYnexiaLua; svn up; cd ../mynexia; svn up")
			player:gmMsg("<Console>: "..player.name.." has svn up the server.", 50)
			os.execute("echo "..player.name.." has SVN UP the server.")
			printf = 0
		elseif lspeech == "/metan" then
			os.execute("./metan")
			player:gmMsg("<Console>: "..player.name.." has used ./metan", 50)
			os.execute("echo "..player.name.." has used ./metan")
			printf = 0
		elseif lspeech == "/make map" then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + MAP compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make map")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			if (make < 4) then
				player:gmMsg("<Console>: Compilation ERROR on MAP by "..player.name.." ("..make..")", 50)
			else
				player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled map in "..make.." seconds.", 50)
				os.execute("echo "..player.name.." has svn up and compiled map.")
			end
			printf = 0
		elseif (lspeech == "/make char") then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + CHAR compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make char")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled char in "..make.." seconds.", 50)
			os.execute("echo "..player.name.." has svn up and compiled char.")
			printf = 0
		elseif (lspeech == "/make login") then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + LOGIN compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make login")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled LOGIN in "..make.." seconds.", 50)
			os.execute("echo "..player.name.." has svn up and compiled login.")
			printf = 0
		end
	end -- END OF SPECIAL COMMAND	

	
	if player.gmLevel > 0 then
		if player.registry["gm_talk2"] > 0 then
			user = player:getUsers()
			if #user > 0 then
				for i = 1, #user do
					if user[i].gmLevel > 0 then
						if string.match(lspeech, "/(.+)") == nil then
							player:msg(12, "<GM>"..player.name..": "..player.speech.."", user[i].ID)
						end
					end
				end
			end
			printf = 0
		end
	end

	if printf == 0 then
		if player.ID == 2 and lspeech == "/reloadlua" or lspeech == "/rl" then player:speak(player.speech, talkType) end
		snoop.showChat(player, player.speech, talkType)
	return else
		if player:hasDuration("reverse_talk") then
			player:speak(string.reverse(player.speech..""), talkType)
		else
			player:speak(player.speech, talkType)
		end
		snoop.showChat(player, player.speech, talkType)	
	end

	characterLog.localChat(player, player.speech)

	if player.ID <= 249 or player.ID == 1723 then
		characterLog.gmSpeechWrite(player, player.speech)
	elseif player.ID >= 250 and player.ID ~= 1723 then
		--characterLog.speechWrite(player, player.speech)
	end
end
