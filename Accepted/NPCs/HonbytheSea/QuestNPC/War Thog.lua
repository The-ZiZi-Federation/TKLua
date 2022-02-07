-- War Thog
war_thog = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local quest1 = player.quest["fighter_path"]
			local quest2 = player.quest["scoundrel_path"]
			local quest3 = player.quest["wizard_path"]
			local quest4 = player.quest["priest_path"]
			local opts = {}

			if quest1 <= 3 and quest1 >= 1 then
				table.insert(opts, "Who are you?")
			end
			if quest1 == 4 then
				table.insert(opts, "I come on behalf of Jamlamin in Hon")
			end
			if quest1 >= 5 then
				table.insert(opts, "So, do we have anything to worry about from you or your men?")
			end

			if quest2 <= 3 and quest2 >= 1 then
				table.insert(opts, "Who are you?")
			end
			if quest2 == 4 then
				table.insert(opts, "I come by request from the Baron, Rodrik")
			end
			if quest2 >= 5 then
				table.insert(opts, "So, do we have anything to worry about from you or your men?")
			end

			if quest3 <= 3 and quest3 >= 1 then
				table.insert(opts, "Who are you?")
			end
			if quest3 == 4 then
				table.insert(opts, "Delta sent me to talk to you.")
			end
			if quest3 >= 5 then
				table.insert(opts, "So, do we have anything to worry about from you or your men?")
			end

			if quest4 <= 3 and quest4 >= 1 then
				table.insert(opts, "Who are you?")
			end
			if quest4 == 4 then
				table.insert(opts, "I bring Blessings of the All Seeing All Knowing GOD")
			end
			if quest4 >= 5 then
				table.insert(opts, "So, do we have anything to worry about from you or your men?")
			end

			menu = player:menuString(name .. "What brings you to my home, young one?", opts)

			----------------------------------------------------------------------------------------------------------

			if menu == "Who are you?" and quest1 <= 3 and player.class == 1 then
				player:dialogSeq(
					{
						t,
						name .. "Who am I? Has my legend really grown so dim?",
						name .. "Only a few years ago I would have slain you right here, without a second thought.",
						name ..
							"I am War Thog. Slayer of Adventurers Kingdom wide. But now, I am helping my son raise an army, to march off and found our own Kingdom."
					},
					1
				)
			elseif menu == "I come on behalf of Jamlamin in Hon" and quest1 == 4 and player.class == 1 then
				player:dialogSeq(
					{
						t,
						name .. "Jamlamin? He tried to take me on himself, twenty years ago, and I left him bleeding in the dirt.",
						name .. "Now he sends some young upstart to try and kill an old man? Pathetic.",
						name ..
							"Tell Jamlamin I no longer intend to harm anyone living in Hon. I am simply training my boy and our soldiers before we leave this place.",
						name .. "Here, take these and tell Jamlamin I said to equip his fighter more or they'll all die."
					},
					1
				)
				player:addItem(16201, 1)
				player:addItem(16301, 1)
				player.quest["fighter_path"] = 5
				player:msg(4, "[Quest Updated] Return to Jamlamin and tell him what War Thog said.", player.ID)
			elseif menu == "So, do we have anything to worry about from you or your men?" and quest1 >= 5 and player.class == 1 then
				------------------------------------------------
				player:dialogSeq(
					{
						t,
						name .. "You have my word, we will not harm anyone within the walls of Hon.",
						name .. "Down here in the Earthworks, however, my men will still see you as fair game.",
						name ..
							"Slay as many of them as you like. Any man weak enough to fall to YOU is not someone I want defending my son."
					},
					1
				)
			elseif menu == "Who are you?" and quest2 <= 3 and player.class == 2 then
				player:dialogSeq(
					{
						t,
						name .. "Who am I? Has my legend really grown so dim?",
						name .. "Only a few years ago I would have slain you right here, without a second thought.",
						name ..
							"I am War Thog. Slayer of Adventurers Kingdom wide. But now, I am helping my son raise an army, to march off and found our own Kingdom."
					},
					1
				)
			elseif menu == "I come by request from the Baron, Rodrik" and quest2 == 4 and player.class == 2 then
				player:dialogSeq(
					{
						t,
						name .. "You come here, to my home, to tell me about the Baron's Plans.",
						name .. "When Rodrik was young he came into my old home. He thought he was the shit.",
						name ..
							"I broke both his arms and then tied the lacing from his boots together and watching him waddle out crying.",
						name .. "So what does the 'Baron' want now? I bet it is about the men he lost to my command.",
						name .. "Tell Rodrik, I will compensate him for his losses as a one time courtesy. As for you though...",
						name ..
							"If you want to live long in this world. You better equip yourself better. Take these and tell Rodrik to stop being cheap with his new recruits."
					},
					1
				)
				player:addItem(17201, 1)
				player:addItem(17301, 1)
				player.quest["scoundrel_path"] = 5
				player:msg(4, "[Quest Updated] Return to Baron Rodrik with the good news.", player.ID)
			elseif menu == "So, do we have anything to worry about from you or your men?" and quest2 >= 5 and player.class == 2 then
				------------------------------------------------------
				player:dialogSeq(
					{
						t,
						name .. "You have my word, we will not harm anyone within the walls of Hon.",
						name .. "Down here in the Earthworks, however, my men will still see you as fair game.",
						name ..
							"Slay as many of them as you like. Any man weak enough to fall to YOU is not someone I want defending my son."
					},
					1
				)
			elseif menu == "Who are you?" and quest3 <= 3 and player.class == 3 then
				player:dialogSeq(
					{
						t,
						name .. "Who am I? Has my legend really grown so dim?",
						name .. "Only a few years ago I would have slain you right here, without a second thought.",
						name ..
							"I am War Thog. Slayer of Adventurers Kingdom wide. But now, I am helping my son raise an army, to march off and found our own Kingdom."
					},
					1
				)
			elseif menu == "Delta sent me to talk to you." and quest3 == 4 and player.class == 3 then
				player:dialogSeq(
					{
						t,
						name .. "Ahh Delta, that old goat. You know, a long time ago, Delta was the best prankster ever.",
						name ..
							"Oh, he attracted all the ladies, and I think all the men too. I am sure you don't want to hear an old story.",
						name .. "I assume, he sent to ask whether or not I will continue to honor our agreement.",
						name .. "Luckily for you, our plans of raising an army and starting a kingdom will require Seagrove's aid.",
						name .. "You can return to Delta and tell him we will continue to take his advice.",
						name ..
							"As for you, The stingy wizards from Seagrove clearly did not prepare you well. Take these and good luck making it out of here."
					},
					1
				)
				player:addItem(18201, 1)
				player:addItem(18301, 1)
				player.quest["wizard_path"] = 5
				player:msg(4, "[Quest Updated] Return to Seagrove and tell Malcor about War Thog's Plans.", player.ID)
			elseif menu == "So, do we have anything to worry about from you or your men?" and quest3 >= 5 and player.class == 3 then
				--------------------------------------------------------------
				player:dialogSeq(
					{
						t,
						name .. "You have my word, we will not harm anyone within the walls of Hon.",
						name .. "Down here in the Earthworks, however, my men will still see you as fair game.",
						name ..
							"Slay as many of them as you like. Any man weak enough to fall to YOU is not someone I want defending my son."
					},
					1
				)
			elseif menu == "Who are you?" and quest4 <= 3 and player.class == 4 then
				player:dialogSeq(
					{
						t,
						name .. "Who am I? Has my legend really grown so dim?",
						name .. "Only a few years ago I would have slain you right here, without a second thought.",
						name ..
							"I am War Thog. Slayer of Adventurers Kingdom wide. But now, I am helping my son raise an army, to march off and found our own Kingdom."
					},
					1
				)
			elseif menu == "I bring Blessings of the All Seeing All Knowing GOD" and quest4 == 4 and player.class == 4 then
				player:dialogSeq(
					{
						t,
						name .. "Hold your tongue, not another word. ASAK this and ASAK that. I won't be having it down here.",
						name .. "Now Trukovich, that's a God to talk about. God of Iron and War. Blood must have blood.",
						name .. "Ahhh, Trukovich, that is it. Maybe when our army is ready to travel, we will settle near Cold Iron.",
						name ..
							"All the strongest warriors of Cold Iron will join my son's kingdom by the time I finish training them. Ahhahhahaahhaa.",
						name ..
							"As for you, 'Priest of ASAK', you have no shield, your head is unprotected. Take these and get out before I sharpen my blade on your bones."
					},
					1
				)
				player:addItem(19201, 1)
				player:addItem(19301, 1)
				player.quest["priest_path"] = 5
				player:msg(
					4,
					"[Quest Updated] Return to The House of ASAK and tell Bishop Eugene about War Thog's Plans.",
					player.ID
				)
			elseif menu == "So, do we have anything to worry about from you or your men?" and quest4 >= 5 and player.class == 4 then
				player:dialogSeq(
					{
						t,
						name .. "You have my word, we will not harm anyone within the walls of Hon.",
						name .. "Down here in the Earthworks, however, my men will still see you as fair game.",
						name ..
							"Slay as many of them as you like. Any man weak enough to fall to YOU is not someone I want defending my son."
					},
					1
				)
			else
				player:dialogSeq({t, name .. "Good luck making it out alive."}, 1)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if
					pc[i].quest["fighter_path"] == 4 or pc[i].quest["scoundrel_path"] == 4 or pc[i].quest["wizard_path"] == 4 or
						pc[i].quest["priest_path"] == 4
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end,
	say = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local s = string.lower(player.speech)

			if string.find(s, "(.*)mercenaries(.*)") then
				if player.quest["gerards_quest"] == 2 then
					player:dialogSeq(
						{
							t,
							name .. "A contract offer?",
							name .. "Well, our numbers are swelling and this territory is getting boring...",
							name .. "Some of the men would probably love a chance like this.",
							name .. "I'll deploy them out to Cathay posthaste to meet this Gerard fellow."
						},
						1
					)
					player.quest["gerards_quest"] = 3
				end
			end
		end
	)
}
