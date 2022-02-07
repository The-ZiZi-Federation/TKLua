summon_mount = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if player:hasDuration("dismounting") then
			player:sendMinitext("You need to wait a second to ride again!")
			return
		end

		if player.mapTitle == "Sumo Course" then
			player:sendMinitext("Can't mount here!")
			return
		end

		if player.m >= 15000 and player.m < 60000 then
			if player.m >= 30001 and player.m <= 30050 then
				player:sendMinitext("Your mount would freeze here!")
				return
			else
				player:sendMinitext("Can't ride here!")
				return
			end
		end

		--	if not player:canAction(1, 1, 1) then
		--		player:sendMinitext("You cannot do that right now!")
		--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 80
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
			onDismount(player)
		end
		--	end
	end
}
 --

--[[


----------------------------------COMMONS-------------------------------------



doe_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





pink_snake_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m == 15000 or player.m == 15010 or player.m == 15011 then
		player:sendMinitext("Can't ride here!")
	return
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





brown_ox_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





red_ox_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





zebra_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





pig_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





brown_bear_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


----------------------------------UNCOMMONS-------------------------------------



panther_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





underdark_zebra_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





polar_bear_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





rookie_gama_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





blood_wolf_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





sled_dog_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





rhino_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


----------------------------------RARES-------------------------------------



purple_goat_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





unitiger_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





seasoned_gama_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





blue_rooster_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





lava_scorpion_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





cute_bat_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}





fire_dragon_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}

----------------------------------EPICS-------------------------------------



nightmare_tiger_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}

-------------------------------SHOP SERIES 1---------------------------------


chaos_dragon_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


cloud_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


pegasus_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}
-------------------------------SHOP SERIES 2---------------------------------

goat_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


white_rabbit_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}

----------------------------------UNIQUE-------------------------------------




shadow_scorpion_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}

armored_warhorse_mount = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)

	if player.m >= 15000 and player.m < 60000 then
		if player.m >= 30001 and player.m <= 30050 then
			player:sendMinitext("Your mount would freeze here!")
			return
		else
			player:sendMinitext("Can't ride here!")			
			return
		end
	end
	
--	if not player:canAction(1, 1, 1) then
--		player:sendMinitext("You cannot do that right now!")
--	return else
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
--	end		
end
}


]] epicMountLegend = function(
	player)
	local reg = player.registry["epic_mount"]

	finishedQuest(player)
	if player:hasLegend("epic_mount") then
		player:removeLegendbyName("epic_mount")
	end

	if reg > 0 then
		player.registry["epic_mount"] = player.registry["epic_mount"] + 1
		player:addLegend("Opened " .. player.registry["epic_mount"] .. " Epic Mounts", "epic_mount", 15, 15)
	else
		player.registry["epic_mount"] = 1
		player:addLegend("Opened an Epic Mount", "epic_mount", 15, 15)
		broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Epic'!")
	end
end
