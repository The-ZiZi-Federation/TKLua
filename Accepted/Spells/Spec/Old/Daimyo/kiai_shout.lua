--[[
kiai_shout = {
on_learned = function(player) player.registry["learned_kiai_shout"]=1 end,
on_forget = function(player) player.registry["learned_kiai_shout"]=0 end,

cast = function(player)
	local fury = player.fury
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = ((player.maxHealth*.6)+(player.maxMagic*0.25)+(player.might*50))*fury
	local magicCost = 250
--	local nodes = {"small_sheep", "medium_sheep", "large_sheep", "auto_sheep", "ore", "silver_ore", "golden_ore", "auto_ore",
--		"tree1", "tree2", "tree3", "auto_tree", "emerald", "sapphire", "ruby", "silver", "gold", "diamond", "auto_jewel"}
	local nodes = {3007, 50101, 50102, 50103, 50104, 50106, 50107, 50108, 50109, 50511, 50512, 50513, 50514, 50516, 50517, 50518, 50519, 50520, 50521, 50522, 1000013}
	local m = player.m
	local x = player.x
	local y = player.y
	local threat

	if (not player:canCast(1, 1, 0)) then
		return
	end
	

	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end	
	
	for i = 1, #nodes do
		if mobTarget.mobID == nodes[i] then
			player:sendMinitext("Nope!")
		return
		end

	end
	
		
	
	if mobTarget ~= nil then
		mobTarget.paralyzed = 1
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		player:sendAnimation(349)
		player:sendAnimation(350)
		player:sendAction(18, 60)
		player:talk(2, "KIAI!")
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Kiai Shout")
		player:playSound(14)
		player:setAether("kiai_shout", 10000)
		around_push_stun.aroundCheck(player, BL_MOB, 1)
		mobTarget:sendAnimation(332, 0)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		mobTarget.paralyzed = 0
	elseif pcTarget ~= nil then
	
		
		if (player:canPK(pcTarget)) then
			around_push_stun.aroundCheck(player, BL_PC, 1)
			pcTarget.attacker = player.ID
			player:sendAction(18, 60)
			player:sendAnimation(349)
			player:sendAnimation(350)
			player:talk(2, "KIAI!")
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You cast Kiai Shout")
			pcTarget:sendAnimation(332, 0)
			player:playSound(14)
			player:setAether("kiai_shout", 10000)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
}
]]
--
