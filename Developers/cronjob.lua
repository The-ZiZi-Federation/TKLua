cronJobSec = function()
	if curServer() == 0 then
		cronJobSecServer0()
	elseif curServer() == 1 then
		cronJobSecServer1()
	end
end

cronJobSecServer0 = function()
	divine_light.cronTimer1()

	final_moment.autoWarp()

	elixir_war.core()
	freeze_war.core()
	beach_war.core()
	sumo_war.core()
	bomber_war.core()

	--	carnage.core()
	--	zombie_war.core()

	disturbed_tomb_hidden_stairs.auto()

	spike_trap.auto()

	leech_chest.auto()
	sewer_chest.auto()
	sewer_crank.auto()

	ruinsBossChest.core()

	library_door.auto()
	ruins_door.auto()
	ruins_door2.auto()

	nearbyQuestsServer0()

	oKeyPickupsServer0.regen()

	-- janken.auto(NPC(115))   --need to fix?
end

cronJobSecServer1 = function()
	ice_palace_hidden_door.auto_1()
	ice_palace_key_armory.auto_1()
	ice_palace_key_treasury.auto_1()
	ice_palace_key_throne_hall.auto_1()

	ice_palace_hidden_door.auto_2()
	ice_palace_key_armory.auto_2()
	ice_palace_key_treasury.auto_2()
	ice_palace_key_throne_hall.auto_2()
	divine_light.cronTimer1()
	nearbyQuestsServer1()
	spike_trap.auto()
end

-----------------------------------------------------------------------------------------------------

cronJobMin = function()
	if curServer() == 0 then
		cronJobMinServer0()
	elseif curServer() == 1 then
		cronJobMinServer1()
	end
	mapLight()
	if core.gameRegistry["divine_light"] == 1 then
		divine_light.broadcast()
	end
end

cronJobMinServer0 = function()
	if realMinute() % 5 == 0 then
		ogre_mine_walls.regenWalls()
	end

	if realMinute() % 10 == 0 then
		randomChestnuts.spawn()
	end

	divine_light.auto()
end

cronJobMinServer1 = function()
	divine_light.auto()
	dayNightCritterSweep(4003)
	--	if core.gameRegistry["divine_light"] == 1 then
	--		divine_light.broadcast()
	--	end
	--	if core.gameRegistry["divine_light"] == 1 then
	--		divine_light.broadcast()
	--	end
end

-----------------------------------------------------------------------------------------------------

cronJobHour = function()
	if curServer() == 0 then
		cronJobHourServer0()
	elseif curServer() == 1 then
		cronJobHourServer1()
	end
end

cronJobHourServer0 = function()
	if (realHour() % 2) == 0 then -- even hour
		randomMinigame()
	end

	if realHour() == 00 then
		ogre_mine_walls.randomizeRooms()
		lortz_bounty_hunter.price(NPC("Teff"))
	end
	divine_light.cronTimer2()
end

cronJobHourServer1 = function()
	divine_light.cronTimer2()
end

-----------------------------------------------------------------------------------------------------

cronJobDay = function()
end

-----------------------------------------------------------------------------------------------------
--
--
--
--
--
--
--
--

clearInstanceMaps = function(block)
	local i

	if (#instances > 0) then
		i = 0
		clearInstances(block, i)
	end

	block:warp(1, 0, 0)
end

clearInstances = function(block, i)
	repeat
		i = i + 1
		block:warp(instances[i], 0, 0)
		if (block.mapTitle == "Ruins") then
			i = clearRuins(block)
		elseif (block.mapTitle == "Merry Forest") then
			clearCanidae(block, i)
		end
	until (i == #instances)
end

clearRuins = function(block)
	local room1Players = #block:getObjectsInMap(instances[i], BL_PC)
	local room2Players = #block:getObjectsInMap(instances[i + 1], BL_PC)
	local room3Players = #block:getObjectsInMap(instances[i + 2], BL_PC)
	local room4Players = #block:getObjectsInMap(instances[i + 3], BL_PC)
	local room5Players = #block:getObjectsInMap(instances[i + 4], BL_PC)

	if (room1Players + room2Players + room3Players + room4Players + room5Players == 0) then
		unloadInstance(instances[i], 5)
		return 0
	end
end

clearCanidae = function(block, i)
	local room1Players = #block:getObjectsInMap(instances[i], BL_PC)
	local room2Players = #block:getObjectsInMap(instances[i + 1], BL_PC)
	local room3Players = #block:getObjectsInMap(instances[i + 2], BL_PC)
	local room4Players = #block:getObjectsInMap(instances[i + 3], BL_PC)
	local room5Players = #block:getObjectsInMap(instances[i + 4], BL_PC)
	local room6Players = #block:getObjectsInMap(instances[i + 5], BL_PC)

	maps = 6

	if (room1Players + room2Players + room3Players + room4Players + room5Players + room6Players == 0) then
		unloadInstance(instances[i], 6)
		return 0
	end
end
