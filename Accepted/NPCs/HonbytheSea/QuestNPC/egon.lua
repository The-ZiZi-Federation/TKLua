egon = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local valid = 0
			local opts = {}
			local ghosts = {}
			local targetName
			local questTargetID, questTargetName
			local questTargetAmount
			local ghostIDs = {
				1031,
				1032,
				1033,
				1034,
				1091,
				1092,
				1093,
				1094,
				1131,
				1132,
				1133,
				1134
			}

			if player.level <= 19 and player.quest["ghost_hunt"] == 0 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 20 and player.quest["ghost_hunt"] == 0 then
				table.insert(opts, "Can I help?")
			end
			if player.quest["ghost_hunt"] == 1 then
				table.insert(opts, "Back from the hunt!")
			end
			if player.quest["ghost_hunt"] == 1 then
				table.insert(opts, "Abandon Hunt")
			end

			--------check for invalid target
			if player.registry["ghost_target"] > 0 then
				for i = 1, #ghostIDs do
					if player.registry["ghost_target"] == ghostIDs[i] then
						valid = 1
					end
				end
				if valid == 0 then
					player.quest["ghost_hunt"] = 0
					player.registry["ghost_target"] = 0
					player.registry["ghost_target_amount"] = 0
				end
			end

			menu = player:menuString(name .. "So many ghosts, so little time...", opts)

			if menu == "Who are you?" then
				player:dialogSeq({t, name .. "Someone who is far too busy to deal with you."}, 1)
			elseif menu == "Can I help?" then
				questTargetID, questTargetName = egon.getTarget(player, npc)

				if string.find(questTargetName, "(.*)Mentok(.*)") then
					player.registry["ghost_target_amount"] = 1
				else
					player.registry["ghost_target_amount"] = 50
				end

				player.registry["ghost_target"] = questTargetID
				player.quest["ghost_hunt"] = 1
				player:msg(
					4,
					"[Quest Updated] Slay " .. player.registry["ghost_target_amount"] .. " " .. questTargetName,
					player.ID
				)
				player:flushKills(questTargetID)
				player:dialogSeq(
					{
						t,
						name .. "You want to help?",
						name .. "Sure, go into the Haunted House and slay " .. questTargetName .. ".",
						name .. "" .. player.registry["ghost_target_amount"] .. " is enough."
					},
					1
				)
			elseif menu == "Back from the hunt!" then
				if player.quest["ghost_hunt"] >= 1 then
					if player.registry["ghost_target"] == 1031 then
						targetName = "Girl spirit"
					end
					if player.registry["ghost_target"] == 1032 then
						targetName = "Boy spirit"
					end
					if player.registry["ghost_target"] == 1033 then
						targetName = "Faceless spirit"
					end
					if player.registry["ghost_target"] == 1034 then
						targetName = "Mentok"
					end

					if player.registry["ghost_target"] == 1091 then
						targetName = "Chilled Spirit"
					end
					if player.registry["ghost_target"] == 1092 then
						targetName = "Pale Spirit"
					end
					if player.registry["ghost_target"] == 1093 then
						targetName = "Wavering Spirit"
					end
					if player.registry["ghost_target"] == 1094 then
						targetName = "Chilled Mentok"
					end

					if player.registry["ghost_target"] == 1131 then
						targetName = "Frantic Spirit"
					end
					if player.registry["ghost_target"] == 1132 then
						targetName = "Anxious Spirit"
					end
					if player.registry["ghost_target"] == 1133 then
						targetName = "Tainted Spirit"
					end
					if player.registry["ghost_target"] == 1134 then
						targetName = "Mentok the Mind Taker"
					end

					confirm =
						player:menuString(
						name .. "You're back? So you killed " .. player.registry["ghost_target_amount"] .. " " .. targetName .. "?",
						{"Yes", "No"}
					)

					if confirm == "Yes" then
						if player:killCount(player.registry["ghost_target"]) >= player.registry["ghost_target_amount"] then
							local rewardEXP
							if player.level >= 20 and player.level <= 64 then
								rewardEXP = 20000
							end
							if player.level >= 65 and (player.baseHealth <= 19999 and player.baseMagic <= 19999) then
								rewardEXP = 1000000
							end
							if player.level >= 99 and (player.baseHealth >= 20000 or player.baseMagic >= 20000) then
								rewardEXP = 20000000
							end

							player:flushKills(player.registry["ghost_target"])
							player.quest["ghost_hunt"] = 0
							player.registry["ghost_target"] = 0
							player.registry["ghost_target_amount"] = 0
							giveXP(player, rewardEXP)
							finishedQuest(player)
							player:calcStat()
							player:sendStatus()
							player:msg(4, "[Quest Complete] You busted some ghosts!", player.ID)
							egon.updateLegend(player, npc)
							player:dialogSeq({t, name .. "Thanks!"}, 1)
						else
							player:dialogSeq({t, name .. "Liar!"}, 1)
						end
					end
				end
			elseif menu == "Abandon Hunt" then
				confirm = player:menuString(name .. "Are you sure you wish to abandon your current hunt?", {"Yes", "No"})
				if confirm == "Yes" then
					player.quest["ghost_hunt"] = 0
					player.registry["ghost_target"] = 0
					player.registry["ghost_target_amount"] = 0
					player:dialogSeq({t, name .. "Come back if you'd like another hunt."}, 1)
				end
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 20 and (pc[i].quest["ghost_hunt"] == 0 or pc[i].quest["ghost_hunt"] == 1) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end,
	getTarget = function(player, npc)
		local questTargets = {}
		local targetName = ""

		if player.level >= 20 and player.level <= 64 then --Haunted House 1
			table.insert(questTargets, 1031) -- Girl spirit
			table.insert(questTargets, 1032) -- Boy spirit
			table.insert(questTargets, 1033) -- Faceless spirit
			table.insert(questTargets, 1034) -- Mentok
		end

		if player.level >= 65 and (player.baseHealth <= 19999 and player.baseMagic <= 19999) then --Haunted House 2
			table.insert(questTargets, 1091) --Chilled Spirit
			table.insert(questTargets, 1092) --Pale Spirit
			table.insert(questTargets, 1093) --Wavering Spirit
			table.insert(questTargets, 1094) --Chilled Mentok
		end

		if player.level >= 99 and (player.baseHealth >= 20000 or player.baseMagic >= 20000) then --Haunted House 3
			table.insert(questTargets, 1131) --Frantic Spirit
			table.insert(questTargets, 1132) --Anxious Spirit
			table.insert(questTargets, 1133) --Tainted Spirit
			table.insert(questTargets, 1134) --Mentok the Mind Taker
		end

		if #questTargets > 0 then
			local r = math.random(1, #questTargets)
			finalQuestTarget = questTargets[r]
		end

		if finalQuestTarget == 1031 then
			targetName = "Girl spirit"
		end
		if finalQuestTarget == 1032 then
			targetName = "Boy spirit"
		end
		if finalQuestTarget == 1033 then
			targetName = "Faceless spirit"
		end
		if finalQuestTarget == 1034 then
			targetName = "Mentok"
		end

		if finalQuestTarget == 1091 then
			targetName = "Chilled Spirit"
		end
		if finalQuestTarget == 1092 then
			targetName = "Pale Spirit"
		end
		if finalQuestTarget == 1093 then
			targetName = "Wavering Spirit"
		end
		if finalQuestTarget == 1094 then
			targetName = "Chilled Mentok"
		end

		if finalQuestTarget == 1131 then
			targetName = "Frantic Spirit"
		end
		if finalQuestTarget == 1132 then
			targetName = "Anxious Spirit"
		end
		if finalQuestTarget == 1133 then
			targetName = "Tainted Spirit"
		end
		if finalQuestTarget == 1134 then
			targetName = "Mentok the Mind Taker"
		end
		 --

		--FORCE A TARGET FOR GM TESTING
		--[[	
	if player.ID == 4 then 
		finalQuestTarget =  
	end
]] return finalQuestTarget, targetName
	end,
	updateLegend = function(player)
		if player:hasLegend("ghost_hunt_repeatable") then
			player:removeLegendbyName("ghost_hunt_repeatable")
		end

		if player.registry["ghost_hunt_completed"] > 0 then
			player.registry["ghost_hunt_completed"] = player.registry["ghost_hunt_completed"] + 1
			player:addLegend(
				"Completed " .. player.registry["ghost_hunt_completed"] .. " Ghost Hunts",
				"ghost_hunt_repeatable",
				203,
				16
			)
		else
			player.registry["ghost_hunt_completed"] = 1
			player:addLegend("Completed 1 Ghost Hunt", "ghost_hunt_repeatable", 203, 16)
		end

		if player.registry["ghost_hunt_completed"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Ghost Hunter'!")
		end
		if player.registry["ghost_hunt_completed"] == 250 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Ghost Killer'!")
		end
		if player.registry["ghost_hunt_completed"] == 500 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Ghost Buster'!")
		end
	end
}
