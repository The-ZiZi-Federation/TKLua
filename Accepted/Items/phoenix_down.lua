phoenix_down = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	local deadPC = getTargetFacing(player, BL_PC, 1)
	local duration = 20000
	local anim = 165

	if not player:canAction(1, 1, 1) then
		player:sendMinitext("You cannot do that right now!")
	return end

	if player:hasDuration("phoenix_down") then
		anim(player)
		delay = player:getDuration("")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")
	return end

	if deadPC ~= nil then
		if player:hasItem(item.yname, 1) == true then
			if deadPC.state == 1 then
				player:removeItemSlot(player.invSlot, 1)	
				player:sendAction(2, 20)
				deadPC:sendAnimation(anim)
				--deadPC:sendAnimation(5)
				deadPC.state = 0
				deadPC:updateState()
				deadPC:addHealth(deadPC.maxHealth*0.1)
				deadPC:sendStatus()
				deadPC:sendMinitext(""..player.name.." revives you with a Phoenix Down")
				player:sendMinitext("Your Phoenix Down revives "..deadPC.name)
				player:setDuration("phoenix_down", duration)
			end
		end
	end
end
}