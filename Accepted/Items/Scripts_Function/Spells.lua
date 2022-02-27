function Player.learnSpell(player, npc)

	local npcName = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID

	if player.npcGraphic == nil or player.npcGraphic == 32768 then
		player.npcGraphic = 0 											 
		player.npcColor = 0													
		player.dialogType = 1
	end

	--Player(4):talkSelf(0,""..npcName)
	
	local found
	local properName
	local spellNames = player:getUnknownSpells()
	local spellName = {}
	local spellNameLevel = {}
	local spellYName = {}
	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}
	local spellSpec = {}
	

	local sortedSpellName = {}
	local sortedSpellYName = {}
	local sortedSpellItemReq = {}
	local sortedSpellItemAmount = {}
	local sortedSpellLevelReq = {}
	local sortedSpellDesc = {}
	local sortedSpellSpec = {}
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	
	for i = 1, #spellYName do
		local level = 1
		local items = {0}
		local amounts = {100}
		local spec = 0
		local desc = {"A spell"}
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)

		if (func ~= nil) then
			level, items, amounts, desc = func(player)
		end
			
		table.insert(spellLevelReq, level)
		table.insert(spellItemReq, items)
		table.insert(spellItemAmount, amounts)
		table.insert(spellDesc, desc)
		--table.insert(spellSpec, getSpellSubSpec(spellYName[i]))
		
		
	end
	
	if (#spellLevelReq > 0) then
		local name
		local yname
		
		local i = 1
		
		while i < #spellLevelReq + 1 do
			if spellLevelReq[i] > player.level then --if the level req of spell[i] is higher then your level
				level = table.remove(spellLevelReq, i)
				items = table.remove(spellItemReq, i)
				amounts = table.remove(spellItemAmount, i)
				desc = table.remove(spellDesc, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)
				--spec = table.remove(spellSpec, i)
				i = 1
			end
			i = i + 1
		end
		sortedSpellName = sort_relative(spellLevelReq, spellName)
		sortedSpellYName = sort_relative(spellLevelReq, spellYName)
		sortedSpellItemReq = sort_relative(spellLevelReq, spellItemReq)
		sortedSpellItemAmount = sort_relative(spellLevelReq, spellItemAmount)
		sortedSpellLevelReq = sort_relative(spellLevelReq, spellLevelReq)
		sortedSpellDesc = sort_relative(spellLevelReq, spellDesc)
		--sortedSpellSpec = sort_relative(spellLevelReq, spellSpec)
	


		spellName = sortedSpellName
		spellYName = sortedSpellYName
		spellItemReq = sortedSpellItemReq
		spellItemAmount = sortedSpellItemAmount
		spellLevelReq = sortedSpellLevelReq
		spellDesc = sortedSpellDesc
		--spellSpec = sortedSpellSpec
		

	end
	
	for i = 1, #spellName do
		spellNameLevel[i] = spellName[i]
	end
	
	for i = 1, #spellNameLevel do
		spellNameLevel[i] = "Level "..getSpellLevel(spellYName[i])..": "..spellNameLevel[i]
	end
	
	local c = player:menuString(npcName.."What would you like to learn?", spellNameLevel)
	if(c ~= "" ) then
		for x = 1, #spellNameLevel do
			if (spellNameLevel[x] == c) then
				found = x
				break
			end
		end	
	end
		
	if(found > 0) then

		if(not player:dialogSeq((spellDesc[found]), 1)) then
			return false
		end
		
		if player.npcGraphic == nil or player.npcGraphic == 32768 then
			player.npcGraphic = 0 											 
			player.npcColor = 0													
			player.dialogType = 1
		end
		local choice = player:menuString(npcName.."Do you want to learn "..spellName[found].."?", {"Yes", "No"})
		if (choice == "Yes") then
			--player:talk(0,""..spellSpec[found])
			if (player.level < spellLevelReq[found]) then
				player:dialog("You are not high enough level for that.", {})
				return false
			end


			
			if (#spellItemReq[found] > 0) then
				if (player:checkItems(spellItemReq[found], spellItemAmount[found])) then
					player:removeItems(spellItemReq[found], spellItemAmount[found])
				else
					player:dialog("You do not have the required items.", {})
					return false
				end
			end
			
						
			player.registry["learned_"..spellYName[found]] = 1
			player:addSpell(spellYName[found])
			player:sendMinitext("You learn "..spellName[found])
			
			
		elseif (c == "No") then
			return false
		end
	end
end

function Player.forgetSpell(player)
	local t = {graphic = 0, color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	
	local spellNames = player:getSpellName()
	local spellNameLevels = {}
	local spellYNames = player:getSpellYName()
	local spellIDs = player:getSpells()
	local placeholder
	local found
	local selection

	for i = 1, #spellNames do
		spellNameLevels[i] = spellNames[i]
	end
	
	for i = 1, #spellNameLevels do
		spellNameLevels[i] = "Level "..getSpellLevel(spellYNames[i])..": "..spellNameLevels[i]
	end
	
	
	selection = player:menuString("What would you like to forget?", spellNameLevels)
	if(selection ~= "" ) then
		for x = 1, #spellNameLevels do
			if(spellNameLevels[x] == selection) then
				found = x
				break
			end
		end	
	end
	selection = player:menuString("Are you sure you wish to forget "..spellNames[found].."?", {"Yes", "No"})
	if(selection == "Yes") then
		player.registry["learned_"..spellYNames[found]] = 0
		player:removeSpell(spellIDs[found])
		player:sendMinitext("You have forgotten the spell "..spellNames[found])
	end
end

function Player.checkItems(player, items, amounts)
	for x = 1, #items do
		if (items[x] == 0) then
			if (player.money < amounts[x]) then
			    return false
			end
		else
			if (player:hasItem(items[x], amounts[x]) == true) then
			else
				return false
			end
		end
	end
	
	return true
end

function Player.removeItems(player, items, amounts)
	for x = 1, #items do
		if (items[x] == 0) then
			player.money = player.money - amounts[x]
			player:sendStatus()
		else
			player:removeItem(items[x], amounts[x])
		end
	end
end


function Player.canLearnSpell(player, str)
	if (type(str) ~= "string") then
		return false
	end
	local spells = player:getSpells()
	if (#spells < 52) then
		if (player:hasSpell(""..str)) then
			return false
		end
		return true
	else
		return false
	end
end

function Player.learnSpell2(player, npc, spells)

	
	
	local npcName = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID

	--Player(4):talkSelf(0,""..npcName)
	
	local found
	local properName
	local spellNames = spells
	local spellName = {}
	local spellNameLevel = {}
	local spellYName = {}
	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}
	
	for i = 1, #spellNames do
		properName = string.gsub(spellNames[i], "'", "")
		yname = string.lower(string.gsub(properName, "%s+", "_"))
--		Player(4):talk(0,""..yname)
		table.insert(spellYName, yname)
		table.insert(spellName, spellNames[i])
	end
	
	
	for i = 1, #spellNames do
		
	end
	
	for i = 1, #spellYName do

		local level = 1
		local items = {0}
		local amounts = {100}
		local desc = {"A spell"}
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)

		if (func ~= nil) then
			level, items, amounts, desc = func(player)
		end
			
		table.insert(spellLevelReq, level)
		table.insert(spellItemReq, items)
		table.insert(spellItemAmount, amounts)
		table.insert(spellDesc, desc)
			
	end
	
	if (#spellLevelReq > 0) then
		local i = 1
		local level
		local items
		local amounts
		local desc
		local name
		local yname
		
		repeat
			if (i <= #spellLevelReq and (spellLevelReq[i] > player.level or (spellLevelReq[i - 1] ~= nil and spellLevelReq[i] < spellLevelReq[i - 1]))) then
				level = table.remove(spellLevelReq, i)
				items = table.remove(spellItemReq, i)
				amounts = table.remove(spellItemAmount, i)
				desc = table.remove(spellDesc, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)

				if (level <= player.level) then
					table.insert(spellLevelReq, 1, level)
					table.insert(spellItemReq, 1, items)
					table.insert(spellItemAmount, 1, amounts)
					table.insert(spellDesc, 1, desc)
					table.insert(spellName, 1, name)
					table.insert(spellYName, 1, yname)
				end
				
				i = 1
			else
				i = i + 1
			end
		until i > #spellLevelReq
	end
	
	for i = 1, #spellName do
		spellNameLevel[i] = spellName[i]
	end
	
	for i = 1, #spellNameLevel do
		spellNameLevel[i] = "Level "..getSpellLevel(spellYName[i])..": "..spellNameLevel[i]
	end
	
	local c = player:menuString(npcName.."What would you like to learn?", spellNameLevel)
	if(c ~= "" ) then
		for x = 1, #spellNameLevel do
			if (spellNameLevel[x] == c) then
				found = x
				break
			end
		end	
	end
		
	if(found > 0) then
	
		if(not player:dialogSeq((spellDesc[found]), 1)) then
			return false
		end
		
		player.npcGraphic = t.graphic													 
		player.npcColor = t.color														
		player.dialogType = 0
		player.lastClick = npc.ID
		local choice = player:menuString(npcName.."Do you want to learn "..spellName[found].."?", {"Yes", "No"})
		if (choice == "Yes") then
			
			if (#spellItemReq[found] > 0) then
				if (player:checkItems(spellItemReq[found], spellItemAmount[found])) then
					player:removeItems(spellItemReq[found], spellItemAmount[found])
				else
					player:dialog("You do not have the required items.", {})
					return false
				end
			end
			
			if (player.level < spellLevelReq[found]) then
				player:dialog("You are not high enough level for that.", {})
				return false
			end
			
			player.registry["learned_"..spellYName[found]] = 1
			player:addSpell(spellYName[found])
			player:sendMinitext("You learn "..spellName[found])
			
			
		elseif (c == "No") then
			return false
		end
	end
end




function Player.futureSpells(player, npc)

	
	local npcName = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID

	--Player(4):talkSelf(0,""..npcName)
	
	local found
	local properName
	local spellNames = player:getUnknownSpells()
	local spellName = {}
	local spellNameLevel = {}
	local spellYName = {}
	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}
	
	local sortedSpellName = {}
	local sortedSpellYName = {}
	local sortedSpellItemReq = {}
	local sortedSpellItemAmount = {}
	local sortedSpellLevelReq = {}
	local sortedSpellDesc = {}
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	
	for i = 1, #spellYName do
		local level = 1
		local items = {0}
		local amounts = {100}
		local desc = {"A spell"}
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)

		if (func ~= nil) then
			level, items, amounts, desc = func(player)
		end
			
		table.insert(spellLevelReq, level)
		table.insert(spellItemReq, items)
		table.insert(spellItemAmount, amounts)
		table.insert(spellDesc, desc)
	end
	
	if (#spellLevelReq > 0) then
		--local level
		--local items
		--local amounts
		--local desc
		local name
		local yname
		
		local num = 1
		
		while num <= #spellLevelReq do
			if (spellLevelReq[num] <= player.level) or (spellLevelReq[num] - player.level > 10) then --if the level req of spell[i] is less than or equal to then your level
				level = table.remove(spellLevelReq, num)
				items = table.remove(spellItemReq, num)
				amounts = table.remove(spellItemAmount, num)
				desc = table.remove(spellDesc, num)
				name = table.remove(spellName, num)
				yname = table.remove(spellYName, num)
				num = 1
			end
			num = num + 1
		end
		
		sortedSpellName = sort_relative(spellLevelReq, spellName)
		sortedSpellYName = sort_relative(spellLevelReq, spellYName)
		sortedSpellItemReq = sort_relative(spellLevelReq, spellItemReq)
		sortedSpellItemAmount = sort_relative(spellLevelReq, spellItemAmount)
		sortedSpellLevelReq = sort_relative(spellLevelReq, spellLevelReq)
		sortedSpellDesc = sort_relative(spellLevelReq, spellDesc)

		spellName = sortedSpellName
		spellYName = sortedSpellYName
		spellItemReq = sortedSpellItemReq
		spellItemAmount = sortedSpellItemAmount
		spellLevelReq = sortedSpellLevelReq
		spellDesc = sortedSpellDesc

	end
	
	num = 1
	while num < #spellLevelReq do
		if (spellLevelReq[num] <= player.level) or (spellLevelReq[num] - player.level > 10) then --if the level req of spell[i] is less than or equal to then your level
			level = table.remove(spellLevelReq, num)
			items = table.remove(spellItemReq, num)
			amounts = table.remove(spellItemAmount, num)
			desc = table.remove(spellDesc, num)
			name = table.remove(spellName, num)
			yname = table.remove(spellYName, num)
			num = 1
		end
		num = num + 1
	end
	
	for i = 1, #spellName do
		spellNameLevel[i] = spellName[i]
	end
	
	for i = 1, #spellNameLevel do
		spellNameLevel[i] = "Level "..getSpellLevel(spellYName[i])..": "..spellNameLevel[i]
	end
	
	local c = player:menuString(npcName.."These are your future spells.", spellNameLevel)
	if(c ~= "" ) then
		for x = 1, #spellNameLevel do
			if (spellNameLevel[x] == c) then
				found = x
				break
			end
		end	
	end
		
	if(found > 0) then
	
		if(not player:dialogSeq((spellDesc[found]), 1)) then
			return false
		end
	end
end



function Player.spellBook(player, npc)

	
--	local npcName = "<b>["..npc.name.."]\n\n"
	local npcName = "<b>[Spellbook]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = player.ID

	--Player(4):talkSelf(0,""..npcName)
	
	local found
	local properName
	local spellNames = player:getAllSpells()
	local spellName = {}
	local spellNameLevel = {}
	local spellYName = {}
	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}
	
	local sortedSpellName = {}
	local sortedSpellYName = {}
	local sortedSpellItemReq = {}
	local sortedSpellItemAmount = {}
	local sortedSpellLevelReq = {}
	local sortedSpellDesc = {}
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	
	for i = 1, #spellYName do
		local level = 1
		local items = {0}
		local amounts = {100}
		local desc = {"A spell"}
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)

		if (func ~= nil) then
			level, items, amounts, desc = func(player)
		end
			
		table.insert(spellLevelReq, level)
		table.insert(spellItemReq, items)
		table.insert(spellItemAmount, amounts)
		table.insert(spellDesc, desc)
--Player(4):talk(0,""..spellYName[i])
	end
	
	if (#spellLevelReq > 0) then
		--local level
		--local items
		--local amounts
		--local desc
		local name
		local yname

		
		sortedSpellName = sort_relative(spellLevelReq, spellName)
		sortedSpellYName = sort_relative(spellLevelReq, spellYName)
		sortedSpellItemReq = sort_relative(spellLevelReq, spellItemReq)
		sortedSpellItemAmount = sort_relative(spellLevelReq, spellItemAmount)
		sortedSpellLevelReq = sort_relative(spellLevelReq, spellLevelReq)
		sortedSpellDesc = sort_relative(spellLevelReq, spellDesc)

		spellName = sortedSpellName
		spellYName = sortedSpellYName
		spellItemReq = sortedSpellItemReq
		spellItemAmount = sortedSpellItemAmount
		spellLevelReq = sortedSpellLevelReq
		spellDesc = sortedSpellDesc

	end
	
	for i = 1, #spellName do
		spellNameLevel[i] = spellName[i]
	end
	
	for i = 1, #spellNameLevel do
		spellNameLevel[i] = "Level "..getSpellLevel(spellYName[i])..": "..spellNameLevel[i]
	end
	
	local c = player:menuString(npcName.."These are your path's spells.", spellNameLevel)
	if(c ~= "" ) then
		for x = 1, #spellNameLevel do
			if (spellNameLevel[x] == c) then
				found = x
				break
			end
		end	
	end
		
	if(found > 0) then
	
		if(not player:dialogSeq((spellDesc[found]), 1)) then
			return false
		end
	end
end