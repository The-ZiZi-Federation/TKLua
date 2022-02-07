intimidate = {
	cast = function(player)
		local magicCost = (player.maxMagic / 22.3) + (player.level * 15)
		local duration = 6000
		local aether = 30000
		local mob = player:getObjectsInArea(BL_MOB)
		local nodes = {
			3007,
			50101,
			50102,
			50103,
			50104,
			50106,
			50107,
			50108,
			50109,
			50511,
			50512,
			50513,
			50514,
			50516,
			50517,
			50518,
			50519,
			50520,
			50521,
			50522,
			1000013
		}

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendAnimation(149)
				player:setAether("intimidate", aether)
				player:sendAction(6, 20)
				player:playSound(27)
				--player:sendAnimation(164)
				player:sendMinitext("You cast Intimidate")
				if #mob > 0 then
					for i = 1, #mob do
						if distanceSquare(player, mob[i], 4) then
							if mob[i].owner == 0 then
								for j = 1, #nodes do
									if mob.mobID ~= nodes[j] then
										if
											not mob[i]:hasDuration("intimidate") and mob[i].yname ~= "haunted_tree" and mob[i].yname ~= "small_sheep" and
												mob[i].yname ~= "medium_sheep" and
												mob[i].yname ~= "large_sheep" and
												mob[i].yname ~= "auto_sheep" and
												mob[i].yname ~= "ore" and
												mob[i].yname ~= "silver_ore" and
												mob[i].yname ~= "golden_ore" and
												mob[i].yname ~= "auto_ore" and
												mob[i].yname ~= "tree1" and
												mob[i].yname ~= "tree2" and
												mob[i].yname ~= "tree3" and
												mob[i].yname ~= "auto_tree" and
												mob[i].yname ~= "emerald" and
												mob[i].yname ~= "sapphire" and
												mob[i].yname ~= "ruby" and
												mob[i].yname ~= "silver" and
												mob[i].yname ~= "gold" and
												mob[i].yname ~= "diamond" and
												mob[i].yname ~= "auto_jewel" and
												mob[i].yname ~= "sansak" and
												mob[i].yname ~= "testing_box" and
												mob[i].yname ~= "ton_shipwreck_crate"
										 then
											if checkResist(player, mob[i], "intimidate") == 1 then
												return
											end
											mob[i]:setDuration("intimidate", duration, player.ID)
											mob[i]:sendAnimation(248)
											--mob[i]:sendAnimationXY(267, mob[i].x, mob[i].y)
											if mob[i].target > 0 then
												mob[i].target = 0
											end
											if mob[i].paralyzed == false then
												RunAway(mob[i], player)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end,
	while_cast = function(block, caster)
		local dura = block:getDuration("intimidate")

		if caster ~= nil then
			if caster.m ~= block.m then
				block:setDuration("intimidate", 0)
				return
			else
				if block.target > 0 then
					block.target = 0
				end
				if block.attacker > 0 then
					block.attacker = 0
				end
				if distanceSquare(block, caster, 2) then
					if block.paralyzed == false then
						RunAway(block, caster)
					end
				end
			end
		end
	end,
	uncast = function(block)
		block.state = MOB_ALIVE
		block:calcStat()
	end,
	requirements = function(player)
		local level = 25
		local item = {0, 389, 6033}
		local amounts = {4500, 50, 12}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Intimidate is a spell to make your enemies flee in terror.", txt}
		return level, item, amounts, desc
	end
}
