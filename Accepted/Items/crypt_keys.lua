crypt_key = { 

use = function(player)
	
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local item = player:getInventoryItem(player.invSlot) --create a reference to the item being used
	local chest = item.maxDmg	 --set the key's maxDam to the mobID of the chest it should open
	local goldAmount = item.vita --set the key's vita to the amount of gold inside the chest
	local expAmount = item.mana  --set the key's mana to the exp reward for opening
	local mob = getTargetFacing(player, BL_MOB) --create a reference to a mob that the player is facing
	
	if not player:canAction(1, 1, 1) then return end

	if player:hasItem(item.yname, 1) == true then	--if you have the key
		if mob ~= nil then							--if there is a mob in front of you
			if mob.mobID == chest then				--if the mob's ID is the chest for this key
				player:removeItemSlot(player.invSlot, 1)	
				player:sendMinitext("You unlock the "..mob.name)
				mob:vanish2()
				player:addGold(goldAmount)
				giveXP(player, expAmount)
			else	--If there is a mob, but it is not the matching chest
				player:sendMinitext("It doesn't fit!")
			end
		else		--if there is no mob
			player:sendMinitext("Nothing to unlock!")
		end
	end
end
}
