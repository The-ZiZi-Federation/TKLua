summon_pet = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	player.registry["pet_type"] = item.look
	summon_pet.cast(player, mob)
end,

cast = function(player, mob)

	local m = player.m
	local x = player.x
	local y = player.y
	local reg = player.registry["summon_pet"]
	local pet = player.registry["pet_type"]
	
	if player.registry["summon_pet"] > 0 and player:hasDuration("summon_pet") then
		if Mob(reg) ~= nil then
			Mob(reg):removeHealth(Mob(reg).health)
		end
		player:sendAction(4, 30)
		player.registry["summon_pet"] = 0
		player:setDuration("summon_pet", 0)
		return
	else
		player:setDuration("summon_pet", 10800000)
		player:sendAction(6, 20)
		player:spawn(pet, x, y, 1)
		mob = player:getObjectsInCell(m,x,y, BL_MOB)
		if #mob > 0 then
			for i = 1, #mob do
				mob[i].owner = player.ID
				mob[i].side = 2
				mob[i]:sendSide()
				player.registry["summon_pet"] = mob[i].ID
				mob[i]:setDuration("summon_pet", 10800000)
			end
		end
		player:updateState()
	end
end,

while_cast_250 = function(player)
	
	req = player.registry["summon_pet"]
	
	if Mob(req) ~= nil then
		if not player.m == Mob(req).m then
			Mob(req):warp(player.m, player.x, player.y)
			Mob(req):sendAnimation(16)
			player:playSound(29)
		end
	end
end,

uncast = function(player)

	local pet = Mob(player.registry["summon_pet"])
	if pet ~= nil then
		pet:removeHealth(pet.health)
	end
	player.registry["summon_pet"] = 0
	player.registry["pet_type"] = 0
end
}