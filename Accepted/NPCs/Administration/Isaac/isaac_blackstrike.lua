isaac_blackstrike = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "What is this place?")
			if player.registry["blackstrike_tower_eye"] == 0 then
				table.insert(opts, "How can I use this eye?")
			end
			if player.registry["blackstrike_tower_eye"] == 1 then
				table.insert(opts, "See you around!")
			end
			if player.quest["blackstrike_torch"] <= 1 then
				table.insert(opts, "Tell me about the torch")
			end
			if player.quest["blackstrike_torch"] == 2 and player:hasItem("unlit_eclipse_torch", 1) == true then
				table.insert(opts, "I have the Torch")
			end
			menu =
				player:menuString(name .. "Wow, you again. If you plan to meet Blackstrike, you will need a special torch.", opts)

			if menu == "What is this place?" then
				player:dialogSeq(
					{
						t,
						name .. "This is an Eye of Teleportation. You will find them all over the world.",
						name .. "If you have unlocked your mind to know a destination then you can travel there from here.",
						name .. "If you go stand on the Eye itself and say out loud where you wish to go...",
						name .. "And you have that mental image clear enough to travel...",
						name .. "Then it will take you to where you desire.",
						name .. "But if you don't know where you are going. You will just look like a fool."
					},
					1
				)
			elseif menu == "How can I use this eye?" then
				player:dialogSeq(
					{
						t,
						name .. "First you must hold your hands together, Pray with me.",
						name .. "In the name of the All Seeing All Knowing God!",
						name .. "Grant me the power to Use the Eye of Teleportation!"
					},
					1
				)
				player:sendAnimation(194)
				player.registry["blackstrike_tower_eye"] = 1
				player:addLegend(
					"Found the Eye of Teleportation for Blackstrike Tower " .. curT(),
					"blackstrike_tower_eye_open",
					202,
					202
				)
				player:msg(4, "[Unlocked Blackstrike Tower Eye of Teleportation]", player.ID)
			elseif menu == "See you around!" then
				player:dialogSeq({t, name .. "If you live long enough!"}, 1)
			elseif menu == "Tell me about the torch" then
				player.quest["blackstrike_torch"] = 1
				player:dialogSeq(
					{
						t,
						name .. "You will need to gather 10 Living Tree Roots and 5 Mud Clumps to hold it together",
						name .. "Then head to the Hermit in Hon for help forming and enchanting the torch",
						name .. "Return to me after all that and I will show you how to light the torch."
					},
					1
				)
				player:msg(4, "[Quest Updated] Gather 10 Living tree roots, 5 Mud clumps, and talk to Hon Hermit!", player.ID)
			elseif menu == "I have the Torch" then
				player:dialogSeq(
					{t, name .. "With the torch in your inventory, press 'o' next to the eternal flame burning on the cliff above"},
					1
				)
				player:msg(4, "[Quest Updated] Press 'o' next to the Eternal Flame on the cliff above!", player.ID)
			end
		end
	)
}
