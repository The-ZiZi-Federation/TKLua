--[[
ninja_vanish = {

on_learn = function(player) player.registry["learned_ninja_vanish"] = 1 end,
on_forget = function(player) player.registry["learned_ninja_vanish"] = 0 end,

cast = function(player)
	
    local magicCost = 1000
	local aether = 60000
	local duration = 10000
	
    if not player:canCast(1,1,0) then return end
    if player.magic < magicCost then notEnoughMP(player) return end


    player:sendAction(6, 20)
    player.magic = player.magic - magicCost
	player:sendStatus()     
	player:setAether("ninja_vanish", aether)       
	player:setDuration("ninja_vanish", duration)       
	player:sendAnimation(249)       
	player:playSound(0)
	player:sendMinitext("You cast ninja_vanish")
	
end,


on_takedamage_while_cast = function(player, attacker)

	if player.health <= player.maxHealth*0.05 then
		ninja_vanish.trigger(player, attacker)
	end
 
end,

trigger = function(player)
	
	ninja_vanish.decoy(player)
	invisible.cast(player)
	blink.warp(player, 1)

end,

decoy = function(player)
	
	local same = {}
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local x, y = player.x, player.y
	local decoy
	
	--	x, y = getFacingXY(player)
	player:spawn(99, x, y, 1)
	decoy = player:getObjectsInCell(player.m, x, y, BL_MOB)
	if #decoy > 0 then
		for i = 1, #decoy do
			if decoy[i].yname == "decoy" then
				if player.gfxClone == 0 then
					clone.equip(player, decoy[i])
					if player.registry["show_title"] == 1 then decoy[i].gfxName = player.title.." "..player.name else
						decoy[i].gfxName = player.name
					end
				else
					clone.gfx(player, decoy[i])
					decoy[i].gfxName = player.gfxName
				end
				decoy[i].gfxClone = 1
				if player.side >= 2 then
					decoy[i].side = player.side - 2
				else
					decoy[i].side = player.side + 2
				end
				decoy[i]:sendSide()
				decoy[i].owner = player.ID
				decoy[i]:setDuration("decoy", 60000, player.ID)
				decoy[i]:sendAnimation(3)
				player:setDuration("decoy", 60000)
				--player.state = 2
				--player:updateState()
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do pc[i]:refresh() end
	end
	
	
	
end
}]]
--
--[[
setduration "anger"

anger ontakedamagewhilecast

registry "getting_angry" +#damage

uncast
surrounding targets take damage = getting_angry
registry set to 0

]]
--
