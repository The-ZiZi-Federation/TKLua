-- Hon Shaman (Archbishop Monroe)
hon_raise_priest = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {}

			table.insert(options, "Can you resurrect me?")
			if player.quest["priest_favor"] == 1 and player.quest["pickup_scroll"] == 0 then
				table.insert(options, "Pick up scroll")
			end

			if player:hasItem("child_skull", 1) == true and player.quest["bless_skull"] == 0 then
				player:dialogSeq(
					{
						t,
						name .. "Are those human remains?",
						t,
						name .. "Where did you get that?",
						t,
						name .. "Please! You must allow me to bless this poor soul and give him his last rites!"
					},
					1
				)
				player.quest["bless_skull"] = 1
			end

			if player.quest["bless_skull"] == 1 then
				table.insert(options, "Please send this poor soul to rest")
			end

			if player:hasItem("basic_rune", 1) == true and (player.registry["basic_rune_donation_time"] < os.time()) then
				table.insert(options, "Rune Donation")
			end

			menu = player:menuString(name .. "May the All Seeing All Knowing GOD, Bless You.", options)

			if menu == "Can you resurrect me?" then
				if (player.state == 1) then
					player.speed = 80
					player.state = 0
					player:updateState()
					player:sendAnimation(96)
					player:playSound(112)
					npc:talk(0, "" .. npc.name .. ": We shall meet again, " .. player.name .. ".")
					player:addHealth2(10000000)
					player:addMagic(1000000)
					player.registry["lastrez"] = os.time()
				else
					player:dialogSeq({t, name .. "I can't resurrect you until you die."}, 1)
				end
			elseif menu == "Please send this poor soul to rest" then
				if player:hasItem("child_skull", 1) == true then
					player:dialogSeq({t, name .. "Bless you, child. Now this poor soul may know peace through the glory of ASAK."}, 1)
					player:removeItem("child_skull", 1)
					player.quest["bless_skull"] = 2
					onGetExp2(player, 100)
					player:addGold(1000)
					player:msg(4, "[Quest Completed]: You have pleased the Church of ASAK!", player.ID)
					hon_raise_priest.addLegend(player)
				else
					player:dialogSeq({t, name .. "Where did the skull go? Please return it here so that it may be laid to rest."}, 1)
				end
			elseif menu == "Pick up scroll" then
				player.quest["pickup_scroll"] = 1
				player:addItem("mysterious_scroll", 1)
				player:dialogSeq(
					{
						t,
						name .. "This was a most fascinating scroll.",
						name .. "I am just thankful to have had the chance to read it, even if only once."
					},
					1
				)
			elseif menu == "Rune Donation" then
				player:dialogSeq(
					{
						t,
						name ..
							"You found a Basic Rune? I can tell by your look. All of the adventurers come across Runes from time to time.",
						name ..
							"Those Runes are used in many important Church ceremonies and consecrations. There are dark forces at work in Hon and we need all the help we can get. Would you be willing to bestow it upon us as an offering to ASAK?"
					},
					1
				)
				confirm = player:menuString("Please, do what you feel is right.", {"Give him a Basic Rune", "Leave"})
				if confirm == "Give him a Basic Rune" then
					if player:removeItem("basic_rune", 1) == true then
						hon_raise_priest.runeDonation(player, npc)
						player:dialogSeq(
							{
								t,
								name .. "Thank you kindly! May the All Seeing All Knowing GOD bless you this day!",
								name ..
									"You are always welcome in the House of ASAK. If you can spare another Rune, bring it by for tomorrow's ceremonies."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "It is not kind of rescind an offering."}, 1)
					end
				else
					player:dialogSeq({t, name .. "You can only do what you feel is right, but I beg you to reconsider."}, 1)
				end
			end
		end
	),
	runeDonation = function(player)
		local reg = player.registry["rune_donation_monroe"]

		player.registry["basic_rune_donation_time"] = os.time() + 86400
		finishedQuest(player)
		player:leveledEXP("donation")
		if player:hasLegend("rune_donation_monroe") then
			player:removeLegendbyName("rune_donation_monroe")
		end

		if reg > 0 then
			player.registry["rune_donation_monroe"] = player.registry["rune_donation_monroe"] + 1
			player:addLegend(
				"Offered " .. player.registry["rune_donation_monroe"] .. " Runes to the House of ASAK",
				"rune_donation_monroe",
				143,
				16
			)
		else
			player.registry["rune_donation_monroe"] = 1
			player:addLegend("Offered 1 Rune to the House of ASAK", "rune_donation_monroe", 143, 16)
		end

		if player.registry["rune_donation_monroe"] % 10 == 0 then
			hon_raise_priest.addLegend(player)
		end
	end,
	addLegend = function(player)
		local reg = player.registry["good_karma"]

		finishedQuest(player)
		if player:hasLegend("honor") then
			player:removeLegendbyName("honor")
		end

		if reg > 0 then
			player.registry["good_karma"] = player.registry["good_karma"] + 1
			player:addLegend("Did the right thing " .. player.registry["good_karma"] .. " times", "honor", 35, 144)
		else
			player.registry["good_karma"] = 1
			player:addLegend("Did the right thing 1 time", "honor", 35, 144)
		end
	end,
	say = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local expReward = 2500000
		local goldReward = 75000

		local s = string.lower(player.speech)

		if
			(string.find(s, "(.*)thank you(.*)") or string.find(s, "(.*)terima kasih(.*)") or string.find(s, "(.*)tq(.*)") or
				string.find(s, "(.*)thx(.*)") or
				string.find(s, "(.*)ty(.*)"))
		 then
			if player.state ~= 1 then
				player:playSound(505)
				player.health = player.maxHealth
				player.magic = player.maxMagic
				player:calcStat()
				player:sendStatus()
				npc:talk(0, "" .. npc.name .. ": You're welcome " .. player.name .. "!")
			else
				npc:talk(0, "" .. npc.name .. ": Would you like me to Raise you?")
			end
		elseif
			((string.find(s, "(.*)res(.*)") or string.find(s, "(.*)rez(.*)") or string.find(s, "(.*)raise(.*)") or
				string.find(s, "(.*)legs please(.*)") or
				string.find(s, "(.*)legs(.*)") or
				string.find(s, "(.*)legs plz(.*)")) and
				player.state == 1)
		 then
			player.state = 0
			player:updateState()
			player:sendAnimation(96)
			player:playSound(112)
			npc:talk(0, "" .. npc.name .. ": We shall meet again, " .. player.name .. ".")
			player:addHealth2(10000000)
			player:addMagic(1000000)
			player:calcStat()
			player:sendStatus()
			player.registry["lastrez"] = os.time()
		elseif string.find(s, "(.*)necromon(.*)") then
			if player.quest["lost_something"] == 3 then
				player:freeAsync()
				async(hon_raise_priest.necromon(player, npc))
			end
		end
	end,
	necromon = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local expReward = 50000000
			local goldReward = 10000

			player:dialogSeq(
				{
					t,
					name .. "You have The Necromon?!",
					name .. "It is a most unholy work! It must be destroyed now!",
					name .. "Please, let me cleanse the evil from this artifact."
				},
				1
			)
			choice = player:menuString("Give him the book?", {"Yes", "No"})
			if choice == "Yes" then
				if player:hasItem("necromon_vol3", 1) == true then
					if player:removeItem("necromon_vol3", 1) == true then
						player.quest["lost_something"] = 4
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Completed] You helped Monroe destroy the Necromon!", player.ID)
						onGetExp2(player, expReward)
						player:addGold(goldReward)
						player:addLegend("Destroyed the Necromon " .. curT(), "necromon", 128, 9)
						player:addSpell("spiritual_transformation")
						player:sendMinitext("You learn Spiritual Transformation")
						hon_raise_priest.addLegend(player)
						player:dialogSeq(
							{
								t,
								name .. "Thank you, child",
								name .. "You have done a great thing today.",
								name .. "May ASAK smile upon you."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Please, do not be careless with evil relics! Bring the book back here!"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Please, do not be careless with evil relics! Bring the book back here!"}, 1)
				end
			elseif choice == "No" then
				player:dialogSeq({t, name .. "I will not sieze the book by force, but I do hope you will reconsider."}, 1)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["bless_skull"] < 2 and pc[i]:hasItem("child_skull", 1) == true then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
