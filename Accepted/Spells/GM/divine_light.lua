divine_light = {


broadcast = function()

	local timeRemaining = core.gameRegistry["divine_light_timer"] - os.time()
	
	if core.gameRegistry["divine_light_multiplier"] == 1 then
		mult = 1.5
	elseif core.gameRegistry["divine_light_multiplier"] == 2 then
		mult = 1.75
	elseif core.gameRegistry["divine_light_multiplier"] == 3 then
		mult = 2
	elseif core.gameRegistry["divine_light_multiplier"] == 4 then
		mult = 3
	end

--	Player(4):talk(0,""..timeRemaining)
	
	if realMinute() == 15 or (timeRemaining <= 3600 and timeRemaining >= 3540) or (timeRemaining <= 1800 and timeRemaining >= 1740) or (timeRemaining <= 600 and timeRemaining >= 540) then
		broadcast(-1, "[DIVINE LIGHT]: "..mult.."x EXP | Time remaining: "..getTimerValues("divine_light_timer"))
	end
	

	--60 min, 30 min, 10 min
	
	

end,

auto = function()

	local pc = core:getUsers()
	local player
	local mult

	if core.gameRegistry["divine_light_multiplier"] == 1 then
		mult = 1.5
	elseif core.gameRegistry["divine_light_multiplier"] == 2 then
		mult = 1.75
	elseif core.gameRegistry["divine_light_multiplier"] == 3 then
		mult = 2
	elseif core.gameRegistry["divine_light_multiplier"] == 4 then
		mult = 3
	end

	if #pc > 0 then
		for i = 1, #pc do
			player = pc[i]
			if core.gameRegistry["divine_light"] == 1 then
				if not player:hasDuration("divine_light") then
					if player.state ~= 1 then
						if not player:hasDuration("divine_light") then
							player:sendAnimation(348)
							player:playSound(106)
							player:sendMinitext("You are bathed in Divine Light (("..mult.."x EXP))          "..getTimerValues("divine_light_timer").." remaining")
							player:setDuration("divine_light", 100000000)
						end
					end
				end
					
			elseif core.gameRegistry["divine_light"] == 0 then
				if player:hasDuration("divine_light") then
					player:setDuration("divine_light", 0)
				end
			end
		end
	end

end,

cast = function(player) -- need to edit into something useful, currently just ends all light

	--local pc = player:getUsers()
--	local input
--	player.dialogType = 0
--	player.npcGraphic = 0
--	player.npcColor = 0
	--Player(4):talk(0,"LIGHT STATUS:")
	
	core.gameRegistry["divine_light"] = 0
	core.gameRegistry["divine_light_timer"] = 0
	core.gameRegistry["divine_light_multiplier"] = 0 
	mapLight()
	
	--Player(4):talk(0,"OFF")
	
--[[
	if core.gameRegistry["divine_light"] == 1 then
		core.gameRegistry["divine_light"] = 0
		core.gameRegistry["divine_light_timer"] = 0
		player:sendMinitext("Divine Light: OFF")
	elseif core.gameRegistry["divine_light"] == 0 then
	
		input = math.abs(tonumber(player:input("How long for Divine Light (in minutes)?")))
		
		if input >= 1 and input <= 1440 then
			core.gameRegistry["divine_light"] = 1
			core.gameRegistry["divine_light_timer"] = os.time() + (input*60)
			player:sendMinitext("Divine Light: ON")
			mapLight()
			
			
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					--pc[i]:sendAnimation(348)
					--pc[i]:playSound(106)
					pc[i]:talk(0, ""..pc[i].name..": Praise the GMs!")
				end
			end
			
			for j = 1, 500 do
				if NPC(j) ~= nil then
					if NPC(j).state ~= 2 then
						NPC(j):talk(0, ""..NPC(j).name..": Praise the GMs!")
					end
				end
			end
		end
	end
]]--
end,


uncast = function(player)

	player:sendMinitext("The Divine Light has faded.")
	
end,

while_cast = function(player)

--player:sendAnimation(348)

end,

	

cronTimer1 = function()

	if core.gameRegistry["divine_light"] == 1 then
		if core.gameRegistry["divine_light_timer"] > 0 and core.gameRegistry["divine_light_timer"] < os.time() then
			core.gameRegistry["divine_light"] = 0
			core.gameRegistry["divine_light_timer"] = 0
			core.gameRegistry["divine_light_multiplier"] = 0 
			mapLight()
		end
	end
end,

cronTimer2 = function()

	if realHour() == 12 then
		characterLog.divineLightDailyTotal()
		core.gameRegistry["divine_light_lapis_daily"] = 0
	end

end,

checkIfOn = function()

--Player(4):talk(0,"checkifon")
	if core.gameRegistry["divine_light"] == 0 then
		core.gameRegistry["divine_light"] = 1
	end

end,


setPurchase = function(amount)

	local mult = 720 --100 lapis == 12 minutes
--Player(4):talk(0,"setPurchase")
	if core.gameRegistry["divine_light_timer"] == 0 then
		core.gameRegistry["divine_light_timer"] = os.time() + (mult * (amount / 100))
		
	elseif core.gameRegistry["divine_light_timer"] > 0 then 
--Player(4):talk(0,"already on")		
		core.gameRegistry["divine_light_timer"] = core.gameRegistry["divine_light_timer"] + (mult * (amount / 100))
--Player(4):talk(0,"set to: "..core.gameRegistry["divine_light_timer"])		
	end
--Player(4):talk(0,"setting daily total")		
	core.gameRegistry["divine_light_lapis_daily"] = core.gameRegistry["divine_light_lapis_daily"] + amount
--Player(4):talk(0,"daily total: "..core.gameRegistry["divine_light_lapis_daily"])
end,




setMultiplier = function()

	if core.gameRegistry["divine_light_multiplier"] == 0 then
		if core.gameRegistry["divine_light_lapis_daily"] > 0 and core.gameRegistry["divine_light_lapis_daily"] <= 4999 then
			core.gameRegistry["divine_light_multiplier"] = 1
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 5000 and core.gameRegistry["divine_light_lapis_daily"] <= 9999 then
			core.gameRegistry["divine_light_multiplier"] = 2
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 10000 and core.gameRegistry["divine_light_lapis_daily"] <= 29999 then
			core.gameRegistry["divine_light_multiplier"] = 3
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 30000 then
			core.gameRegistry["divine_light_multiplier"] = 4
		end
		
	elseif core.gameRegistry["divine_light_multiplier"] == 1 then
		if core.gameRegistry["divine_light_lapis_daily"] >= 5000 and core.gameRegistry["divine_light_lapis_daily"] <= 9999 then
			core.gameRegistry["divine_light_multiplier"] = 2	
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 10000 and core.gameRegistry["divine_light_lapis_daily"] <= 29999 then
			core.gameRegistry["divine_light_multiplier"] = 3
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 30000 then
			core.gameRegistry["divine_light_multiplier"] = 4
		end
		
	elseif core.gameRegistry["divine_light_multiplier"] == 2 then
		if core.gameRegistry["divine_light_lapis_daily"] >= 10000 and core.gameRegistry["divine_light_lapis_daily"] <= 29999 then
			core.gameRegistry["divine_light_multiplier"] = 3
		elseif core.gameRegistry["divine_light_lapis_daily"] >= 30000 then
			core.gameRegistry["divine_light_multiplier"] = 4
		end
	elseif core.gameRegistry["divine_light_multiplier"] == 3 then	
		if core.gameRegistry["divine_light_lapis_daily"] >= 30000 then
			core.gameRegistry["divine_light_multiplier"] = 4
		end
	end

end
}
