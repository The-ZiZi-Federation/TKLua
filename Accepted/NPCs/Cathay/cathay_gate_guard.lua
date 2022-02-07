cathay_gate_guard = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local opts2 = {"Yes", "No"}
			local menuOption
			local menuOptionBuy
			local sellitems = {} --

			if player.quest["spec_extortion"] == 1 and player.quest["angry_guard"] <= 1 then
				table.insert(opts, "Can I enter Cathay?")
			end
			if player.quest["spec_extortion"] == 1 and player:hasItem("kramoris_iou", 1) == true then
				table.insert(opts, "I helped Kramoris")
			end
			if player.quest["spec_extortion"] == 1 and player.quest["angry_guard"] == 11 then
				table.insert(opts, "I brought you some food")
			end
			if player.quest["spec_extortion"] == 1 and player.quest["angry_guard"] == 12 and player.m == 4001 then
				table.insert(opts, "Let me in to Cathay")
			end
			if player.m == 4000 then
				table.insert(opts, "I want to leave Cathay")
			end

			--	if player.quest[""] >= 2 then table.insert(opts, "") end
			--	if player.quest[""] >= 2 then table.insert(sellitems, 1) end
			--	if player.quest[""] == 2 then table.insert(opts, "") end
			--	if player.quest[""] == 3 then table.insert(opts, "") end
			--	if player.quest[""] == 1 then table.insert(opts, "") end

			menu = player:menuString(name .. "Who are you and why are you here?", opts)

			if menu == "Can I enter Cathay?" then
				if player.level >= 100 then
					player.quest["angry_guard"] = 1
					player:dialogSeq(
						{
							t,
							name .. "Cathay is very selective. We don't allow just anyone inside.",
							name .. "What notable accomplishments do you have that would make you worthy enough to enter?",
							name ..
								"Sure, you may have slain some mighty beasts I'm sure, but have you ever helped anyone out of the goodness of your heart, receiving nothing in return?",
							name .. "That's the kind of person I want to meet."
						},
						1
					)
				else
					player:dialogSeq({t, name .. "No. You're too weak."}, 1)
				end
			elseif menu == "I helped Kramoris" then
				if player:hasItem("kramoris_iou", 1) == true then
					player:removeItem("kramoris_iou", 1)
					player.quest["angry_guard"] = 3
					player:dialogSeq(
						{
							t,
							name .. "What is this? An IOU?",
							name .. "*Edd reads the IOU*",
							name .. "So you fought off some grave robbers? Is that all?",
							name .. "Maybe go back and ask Kramoris if he has some REAL enemies for you to fight.",
							name .. "Street urchins perhaps, or maybe some particularly rowdy delivery boys.",
							name .. "Come back once you've done something worthwhile."
						},
						1
					)
				else
					player:dialogSeq({t, name .. "Where's your proof?"}, 1)
				end
			elseif menu == "I brought you some food" then
				if player:hasItem("orcish_delight", 1) == true then
					player:removeItem("orcish_delight", 1)
					player:giveXP(20000000)
					player.quest["angry_guard"] = 12
					player:addLegend("Gained entry to Cathay", "cathay_entry", 7, 16)
					player:msg(4, "[Quest Complete] You fed Edd and gained entry to Cathay!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "Food?",
							name .. "Is that... Orcish Delight?",
							name ..
								"I'm gonna take this. And I'm gonna eat it. But it doesn't change anything. You're still not getting into Cathay.",
							"*Edd takes a bite and his eyes glaze over*",
							name .. "This is.. Incredible...",
							name .. "Ok, fine.",
							name .. "You can go into Cathay whenever you want.",
							name .. "Just ask and I'll open the gate for you.",
							name .. "Thanks again for the meal. Promise that you'll bring me another one of those sometime?"
						},
						1
					)
				end
			elseif menu == "Let me in to Cathay" then
				player:dialogSeq({t, name .. "Sure thing! I'll open the gate!"}, 1)
				player:warp(4000, 135, 87)
			elseif menu == "I want to leave Cathay" then
				player:dialogSeq({t, name .. "Sure thing! I'll open the gate!"}, 1)
				player:warp(4001, 6, 26)
			end
		end
	)
}
