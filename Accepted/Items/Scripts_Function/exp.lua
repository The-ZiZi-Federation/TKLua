onGetExp = function(x, block)

	local xp, pc = block.experience, x:getObjectsInMap(x.m, BL_PC)
	local party, p = {}, {}
--	local tab, info = {xp, xp*.95, xp*.9, xp*.85, xp*.8, xp*.85, xp*.9, xp*.95}, {"100%", "95%", "90%", "85%", "80%", "85%", "90%", "95%"}
	local tab, info = {xp, xp, xp*.95, xp*.9, xp*.85, xp*.8, xp*.75, xp*.8, xp*.85, xp*.9, xp*.95, xp}, {"100%", "100%", "95%", "90%", "85%", "80%", "75%", "80%", "85%", "90%", "95%", "100%"}
	
	local groupExp
	local highest = 0
	local highestPlayer = 0
	local percentage = 0
	local diff = 0 
	local levelDifference = x.level - block.level
	local divineLightMultiplier = 1

	if x:hasDuration("divine_light") then
		if core.gameRegistry["divine_light_multiplier"] == 1 then
			divineLightMultiplier = 1.5
		elseif core.gameRegistry["divine_light_multiplier"] == 2 then
			divineLightMultiplier = 1.75
		elseif core.gameRegistry["divine_light_multiplier"] == 3 then
			divineLightMultiplier = 2
		elseif core.gameRegistry["divine_light_multiplier"] == 4 then
			divineLightMultiplier = 3
		end
	end

	if x.state ~= 1 then
		if x.groupID == 0 then
			xp = xp * divineLightMultiplier
			giveXP(x, xp)
			if x.exp >= 4000000001 then
				x.exp = x.exp - 4000000000
				x.registry["exp_maxes"] = x.registry["exp_maxes"] + 1
				x:checkLevel()
				x:calcStat()
				x:sendStatus()
				x:refresh()
			end			
		return else
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 then
						if pc[i].groupID == x.groupID then table.insert(party, pc[i].ID) end
					end
				end
		    end
			if #party > 0 then
				if #party <= 12 then
				   groupExp = tab[#party]  
					for i = 1, #party do 
						mem = Player(party[i])
                       	if mem.level > highest then
							highest = mem.level
							highestPlayer = mem.ID
						end
					end
					for i = 1, #party do
      						mem = Player(party[i])
						if mem.m == x.m and mem.state ~= 1 then
							diff = Player(highestPlayer).level - mem.level
                           	percentage = (mem.level/highest)
							if mem:hasDuration("divine_light") then
								finalExp = (groupExp*percentage) * divineLightMultiplier
							else
								finalExp = (groupExp*percentage)
							end
							if diff <= 20 then
								if mem.level == highest then
									giveXP(mem, finalExp)
									mem:calcStat()
									mem:sendStatus()
									if mem.exp >= 4000000001 then
										mem.exp = mem.exp - 4000000000
										mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
										mem:checkLevel()
										mem:calcStat()
										mem:sendStatus()
										mem:refresh()
									end
								else
									giveXP(mem, finalExp+1)
									mem:calcStat()
									mem:sendStatus()
									if mem.exp >= 4000000001 then
										mem.exp = mem.exp - 4000000000
										mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
										mem:checkLevel()
										mem:calcStat()
										mem:sendStatus()
										mem:refresh()
									end

								end
							elseif diff >= 21 then
								giveXP(mem, 1)
								mem:calcStat()
								mem:sendStatus()
								if mem.exp >= 4000000001 then
									mem.exp = mem.exp - 4000000000
									mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
									mem:checkLevel()
									mem:calcStat()
									mem:sendStatus()
									mem:refresh()
								end
							end                     
						end
					end
				else
					x:sendMinitext("You can't gain experience with a group this large!")
					return
				end
			end
		end
	end
end

onGetExp2 = function(player, experience)

	local xp, pc = experience, player:getObjectsInMap(player.m, BL_PC)
	local party, p = {}, {}
	--local tab, info = {xp, xp*.95, xp*.9, xp*.85, xp*.8, xp*.85, xp*.9, xp*.95}, {"100%", "95%", "90%", "85%", "80%", "85%", "90%", "95%"}
	local tab, info = {xp, xp, xp*.95, xp*.9, xp*.85, xp*.8, xp*.75, xp*.8, xp*.85, xp*.9, xp*.95, xp}, {"100%", "100%", "95%", "90%", "85%", "80%", "75%", "80%", "85%", "90%", "95%", "100%"}

	local groupExp
	local highest = 0
	local highestPlayer = 0
	local percentage = 0
	local diff = 0 
	local divineLightMultiplier = 1

	if core.gameRegistry["divine_light_multiplier"] == 1 then
		divineLightMultiplier = 1.5
	elseif core.gameRegistry["divine_light_multiplier"] == 2 then
		divineLightMultiplier = 1.75
	elseif core.gameRegistry["divine_light_multiplier"] == 3 then
		divineLightMultiplier = 2
	elseif core.gameRegistry["divine_light_multiplier"] == 4 then
		divineLightMultiplier = 3
	end
	
	xp = xp * divineLightMultiplier

	if player.state ~= 1 then
		if player.groupID == 0 then
			giveXP(player, xp)
			if player.exp >= 4000000001 then
				player.exp = player.exp - 4000000000
				player.registry["exp_maxes"] = player.registry["exp_maxes"] + 1
				
				player:calcStat()
				player:checkLevel()
				player:sendStatus()
				player:refresh()
			end			
		return else
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 then
						if pc[i].groupID == player.groupID then table.insert(party, pc[i].ID) end
					end
				end
		    end
			if #party > 0 then
				if #party <= 12 then
				   groupExp = tab[#party]  
					for i = 1, #party do 
						mem = Player(party[i])
                       				if mem.level > highest then
							highest = mem.level
							highestPlayer = mem.ID
                      	end
					end
					for i = 1, #party do
      						mem = Player(party[i])
						if mem.m == player.m and mem.state ~= 1 then
							diff = Player(highestPlayer).level - mem.level
                           	percentage = (mem.level/highest)
							finalExp = (groupExp*percentage)
							if diff <= 20 then
								if mem.level == highest then
									giveXP(mem, finalExp)
									mem:calcStat()
									mem:sendStatus()
									--mem:updateState()
									if mem.exp >= 4000000001 then
										mem.exp = mem.exp - 4000000000
										mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
										mem:checkLevel()
										mem:calcStat()
										mem:sendStatus()
										mem:refresh()
									end
								else
									giveXP(mem, finalExp+1)
									mem:calcStat()
									mem:sendStatus()
									if mem.exp >= 4000000001 then
										mem.exp = mem.exp - 4000000000
										mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
										mem:checkLevel()
										mem:calcStat()
										mem:sendStatus()
										mem:refresh()
									end
								end
							elseif diff >= 21 then
								giveXP(mem, 1)
								mem:calcStat()
								mem:sendStatus()
								if mem.exp >= 4000000001 then
									mem.exp = mem.exp - 4000000000
									mem.registry["exp_maxes"] = mem.registry["exp_maxes"] + 1
									mem:checkLevel()
									mem:calcStat()
									mem:sendStatus()
									mem:refresh()
								end
							end   
						end
					end
				else
					player:sendMinitext("You can't gain experience with a group this large!")
					return
				end
			end
		end
	end
end

giveXP = function(p, amount)
	
	local pc = p:getObjectsInCell(p.m, p.x, p.y, BL_PC)
	local get = 0

	if p.state == 1 then
		p:sendAnimation(246)
		p:sendMinitext("You cannot gain exp while dead!")
	return else
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].ID ~= p.ID and pc[i].m ~= 1018 then
					p:sendAnimation(246)
					p:sendMinitext("You cannot gain exp while on top on other players!")
					return
				end
			end
		end
		if p.level > 99 then
			if p.exp + amount > 4294967295 then
				get = math.abs(math.floor(4294967295 - p.exp))
			else
				get = math.abs(math.floor(amount))
			end
		else
			get = math.abs(math.floor(amount))
		end
		--get = get * divineLightMultiplier
		p.exp = p.exp + get
		p:checkLevel()
		p:sendStatus()
		p:sendMinitext(format_number(get).." experience!")
	end
end