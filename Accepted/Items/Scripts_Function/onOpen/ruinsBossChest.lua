
ruinsBossChest = {

open = function(player)
	--[[
	local pc = core:getObjectsInMap(player.m, BL_PC)
	local mob = core:getObjectsInMap(3115, BL_MOB)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObjFacing(player, player.side)	
	local randomDrops = {6070}

	local party = {}
	
	local highestRoll = 0
	local highestPlayer = 0
	local itemNumber = 0
	local dropItem = 0

	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].groupID == player.groupID then
				table.insert(party, pc[i].ID) 
			end
		end
	end

	if m == 3115 then
		if obj == 13583 then				
			if #mob == 0 then				
				setObject(3115, 3, 3, 13584)
				player.mapRegistry["highest_roll"] = 0
				player.mapRegistry["highest_player"] = 0
				player.mapRegistry["num_choices"] = 0
				core.gameRegistry["ruins_chest_timer"] = os.time() + 60
				core.gameRegistry["ruins_chest"] = os.time()+7200				
				player.mapRegistry["item_number"] = randomDrops[math.random(1, #randomDrops)]				
				player.mapRegistry["drop_item"] = player.mapRegistry["item_number"]
				player.mapRegistry["party_members"] = #party			
				for i = 1, #party do Player(party[i]):freeAsync() async(ruinsBossChest.choice(Player(party[i]))) end
			else
				player:talk(0, player.name..": No time for treasure, there's monsters around!")
			end				
		elseif obj == 13584 then
			if player.registry["ruins_chest_choice"] == 1 then
				player:freeAsync()
				async(ruinsBossChest.choice(player))
			else
				player:talkSelf(0, "There's no treasure left.")
			end
		end
	end
	]]--
end,

choice = async(function(player)

	local pc = core:getObjectsInMap(player.m, BL_PC)
	local party = {}
	local itemNumber = player.mapRegistry["item_number"]

	local opts = {}
	player.lastClick = player.ID
	player.dialogType = 0

	player.registry["ruins_chest_choice"] = 1

	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].groupID == player.groupID then
				table.insert(party, pc[i].ID) 
			end
		end
	end

	table.insert(opts, "Roll")
	table.insert(opts, "Pass")
	menu = player:menuString("The chest contains a "..Item(player.mapRegistry["item_number"]).name.." \n\nWhat do you do?", opts)

	if menu == "Roll" then
		ruinsBossChest.roll(player)
		player.registry["ruins_chest_choice"] = 2

	elseif menu == "Pass" then
		ruinsBossChest.pass(player)		
		player.registry["ruins_chest_choice"] = 2
		
	end
end),

roll = function(player)

	local pc = core:getObjectsInMap(player.m, BL_PC)
	local party = {}
	--player:freeAsync()
	local itemNumber = player.mapRegistry["item_number"]

	local opts = {}

	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].groupID == player.groupID then
				table.insert(party, pc[i].ID) 
			end
		end
	end
	
	playerRoll = math.random(1, 10000)
	player:talk(0, ""..player.name..": I rolled a "..playerRoll.." out of 10000 on the "..Item(player.mapRegistry["item_number"]).name..".")
	if playerRoll > player.mapRegistry["highest_roll"] then
		player.mapRegistry["highest_roll"] = playerRoll
		player.mapRegistry["highest_player"] = player.ID
	end
	player.mapRegistry["num_choices"] = player.mapRegistry["num_choices"] + 1
	
	if player.mapRegistry["num_choices"] == player.mapRegistry["party_members"] then
		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: All group members have rolled or passed on "..Item(player.mapRegistry["item_number"]).name.."!")
		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: Winner is "..Player(player.mapRegistry["highest_player"]).name.." with a roll of "..player.mapRegistry["highest_roll"].."!")
		ruinsBossChest.finish(Player(player.mapRegistry["highest_player"]))
		--Player(player.mapRegistry["highest_player"]):addItem(Item(player.mapRegistry["item_number"]))
	end
end,

pass = function(player)

	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].groupID == player.groupID then
				table.insert(party, pc[i].ID) 
			end
		end
	end
	
	local pc = core:getObjectsInMap(player.m, BL_PC)
	local party = {}
	local itemNumber = player.mapRegistry["item_number"]

	local opts = {}

	player:talk(0, ""..player.name..": I'll pass on the "..Item(player.mapRegistry["item_number"]).name..".")
	player.mapRegistry["num_choices"] = player.mapRegistry["num_choices"] + 1
	player.registry["ruins_chest_choice"] = 1
		
	if player.mapRegistry["num_choices"] == player.mapRegistry["party_members"] then
		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: All group members have rolled or passed on "..Item(player.mapRegistry["item_number"]).name.."!")
		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: Winner is "..Player(player.mapRegistry["highest_player"]).name.." with a roll of "..player.mapRegistry["highest_roll"].."!")
		ruinsBossChest.finish(Player(player.mapRegistry["highest_player"]))
		--Player(player.mapRegistry["highest_player"]):addItem(Item(player.mapRegistry["item_number"]))
	end
end,

finish = function(player)

	local itemNumber = player.mapRegistry["item_number"]

	local pc = player:getObjectsInMap(player.m, BL_PC)
	local party = {}

	player:addItem(itemNumber, 1)

	player.mapRegistry["highest_roll"] = 0
	player.mapRegistry["highest_player"] = 0
	player.mapRegistry["num_choices"] = 0
	player.mapRegistry["party_members"] = 0
	player.mapRegistry["drop_item"] = 0
	core.gameRegistry["ruins_chest_timer"] = 0

	if #pc > 0 then 
		for i = 1, #pc do
			if pc[i].groupID == player.groupID then
				table.insert(party, pc[i].ID)
			end
		end
	end
	if #party > 0 then
		for i = 1, #party do
			Player(party[i]).registry["ruins_chest_choice"] = 0
		end
	end
end,

core = function()

	ruinsBossChest.timer()
	ruinsBossChest.auto()

end,

timer = function()
	local mob = core:getObjectsInMap(3115, BL_MOB)
	local player = NPC("Ruins Chest Helper")
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local party = {}

	if core.gameRegistry["ruins_chest_timer"] > 0 and core.gameRegistry["ruins_chest_timer"] < os.time() then
		if #pc > 0 then 
			for i = 1, #pc do
				if pc[i].groupID == player.groupID then
					table.insert(party, pc[i].ID)
				end
			end
		end
		if #party > 0 then
			for i = 1, #party do
				Player(party[i]).registry["ruins_chest_choice"] = 0
			end
		end

		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: All group members have rolled or passed on "..Item(player.mapRegistry["item_number"]).name.."!")
		broadcast(3115, "["..Item(player.mapRegistry["item_number"]).name.."]: Winner is "..Player(player.mapRegistry["highest_player"]).name.." with a roll of "..player.mapRegistry["highest_roll"].."!")
		ruinsBossChest.finish(Player(player.mapRegistry["highest_player"]))
	end
end,

auto = function()

	local mob = core:getObjectsInMap(3115, BL_MOB)
	if #mob > 0  then
		if core.gameRegistry["ruins_chest"] > 0 and core.gameRegistry["ruins_chest"] < os.time() then
			setObject(3115, 3, 3, 13583)
			core.gameRegistry["ruins_chest"] = 0
		end
	end
end
}
