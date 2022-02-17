fate_npc = {
	click = async(
		function(player, npc)
			if player.level == 1 then
				fate_npc.questions(player, npc)
			elseif player.level == 99 then
				fate_npc.level100(player, npc)
			--elseif player.level == 110 then
			--	fate_npc.level110(player, npc)
			end
		end
	),
	questions = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts = {}

		if player.registry["fate_q_answered"] == 0 then
			table.insert(opts, "I wasn't strong enough")
			table.insert(opts, "I wasn't fast enough")
			table.insert(opts, "I wasn't smart enough")
			table.insert(opts, "I wasn't good enough")

			menu = player:menuString(name .. "Your life was pathetic. A waste, really.\nHow did you end up there?", opts)

			if menu == "I wasn't strong enough" then
				player.registry["fate_q_1"] = 1
			elseif menu == "I wasn't fast enough" then
				player.registry["fate_q_1"] = 2
			elseif menu == "I wasn't smart enough" then
				player.registry["fate_q_1"] = 3
			elseif menu == "I wasn't good enough" then
				player.registry["fate_q_1"] = 4
			end

			player.registry["fate_q_answered"] = 1
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 1 then
			table.insert(opts, "Report him to the authorities")
			table.insert(opts, "Extort him for my silence")
			table.insert(opts, "Kill him and take everything")
			table.insert(opts, "Congratulate him and tell no one")

			menu =
				player:menuString(
				name ..
					"Your friend has robbed a merchant, and may have murdered as well. He comes to you asking for help. What do you do?",
				opts
			)

			if menu == "Report him to the authorities" then
				player.registry["fate_q_2"] = 1
			elseif menu == "Extort him for my silence" then
				player.registry["fate_q_2"] = 2
			elseif menu == "Kill him and take everything" then
				player.registry["fate_q_2"] = 3
			elseif menu == "Congratulate him and tell no one" then
				player.registry["fate_q_2"] = 4
			end

			player.registry["fate_q_answered"] = 2
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 2 then
			table.insert(opts, "Power")
			table.insert(opts, "Faith")
			table.insert(opts, "Battle")
			table.insert(opts, "Riches")

			menu = player:menuString(name .. "What was your drive in life?", opts)

			if menu == "Power" then
				player.registry["fate_q_3"] = 1
			elseif menu == "Faith" then
				player.registry["fate_q_3"] = 2
			elseif menu == "Battle" then
				player.registry["fate_q_3"] = 3
			elseif menu == "Riches" then
				player.registry["fate_q_3"] = 4
			end

			player.registry["fate_q_answered"] = 3
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 3 then
			table.insert(opts, "Amass power")
			table.insert(opts, "Protect the weak")
			table.insert(opts, "Slay the innocent")
			table.insert(opts, "Mind my own business")

			menu = player:menuString(name .. "What would you do if you had another chance?", opts)

			if menu == "Amass power" then
				player.registry["fate_q_4"] = 1
			elseif menu == "Protect the weak" then
				player.registry["fate_q_4"] = 2
			elseif menu == "Slay the innocent" then
				player.registry["fate_q_4"] = 3
			elseif menu == "Mind my own business" then
				player.registry["fate_q_4"] = 4
			end

			player.registry["fate_q_answered"] = 4
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 4 then
			table.insert(opts, "White")
			table.insert(opts, "Purple")
			table.insert(opts, "Pink")
			table.insert(opts, "Red")
			table.insert(opts, "Orange")
			table.insert(opts, "Yellow")
			table.insert(opts, "Green")
			table.insert(opts, "Blue")
			table.insert(opts, "Brown")
			table.insert(opts, "Black")

			menu = player:menuString(name .. "What color is your soul?", opts)

			if menu == "White" then
				player.registry["fate_q_5"] = 1
			elseif menu == "Purple" then
				player.registry["fate_q_5"] = 2
			elseif menu == "Pink" then
				player.registry["fate_q_5"] = 3
			elseif menu == "Red" then
				player.registry["fate_q_5"] = 4
			elseif menu == "Orange" then
				player.registry["fate_q_5"] = 5
			elseif menu == "Yellow" then
				player.registry["fate_q_5"] = 6
			elseif menu == "Green" then
				player.registry["fate_q_5"] = 7
			elseif menu == "Blue" then
				player.registry["fate_q_5"] = 8
			elseif menu == "Brown" then
				player.registry["fate_q_5"] = 9
			elseif menu == "Black" then
				player.registry["fate_q_5"] = 10
			end

			player.registry["fate_q_answered"] = 5
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 5 then
			table.insert(opts, "Somewhere warm")
			table.insert(opts, "Somewhere cold")
			table.insert(opts, "Home")
			table.insert(opts, "Valhalla")
			table.insert(opts, "The Nine Hells")
			table.insert(opts, "To the End")

			menu =
				player:menuString(name .. "So, where do actually think you�re going to go?\nWhen this is all over, I mean.", opts)

			if menu == "Somewhere warm" then
				player.registry["fate_q_6"] = 1
			elseif menu == "Somewhere cold" then
				player.registry["fate_q_6"] = 2
			elseif menu == "Home" then
				player.registry["fate_q_6"] = 3
			elseif menu == "Valhalla" then
				player.registry["fate_q_6"] = 4
			elseif menu == "The Nine Hells" then
				player.registry["fate_q_6"] = 5
			elseif menu == "To the End" then
				player.registry["fate_q_6"] = 6
			end

			player.registry["fate_q_answered"] = 6
			fate_npc.questions(player, npc)
		elseif player.registry["fate_q_answered"] == 6 then
			email =
				string.lower(
				player:input("What is your Email address? (VALID EMAIL REQUIRED FOR CHARACTER PROGRESSION AND PASSWORD RECOVERY)")
			)

			if (string.len(email) > 32) then
				player:popUp("Your email address must be no longer than 32-characters.")
				return
			end

			local goodEmail = validateEmail(email)

			if (goodEmail == nil or goodEmail == false) then
				player:popUp("Your email address is invalid. Please retry.")
				return
			end

			sendEmail(player, email)
			player.email = email

			player:dialogSeq(
				{
					t,
					player.name ..
						"\n\nThe email address you provided has been registered with this character, however the registration process is not complete just yet. In the email that has been sent to you, an activation key has been provided. You must enter that key in the F1->Activate menu to progress past level 5 and to choose a path."
				},
				1
			)

			player.registry["fate_q_answered"] = 7
			finishedQuest(player)
		elseif player.registry["fate_q_answered"] == 7 then
			player:dialogSeq(
				{
					t,
					name .. "It seems our time together is at an end...",
					name .. "Farewell."
				},
				1
			)
			player:warp(1035, math.random(8, 14), math.random(9, 14))
			player:playSound(106)
			player:sendMinitext(
				"Your spirit is weary, but as you drift among the worlds, you do not find rest. Instead, you arrive on Morna."
			)
			player:sendAnimation(254)
			player.money = 0
			player:calcStat()
		end
	end,
	level100 = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local goodKarma = player.registry["good_karma"]
		local badKarma = player.registry["bad_karma"]
		local disposition = 0

		local opts = {}

		if goodKarma > badKarma then
			disposition = 1
		elseif badKarma > goodKarma then
			disposition = 2
		elseif badKarma == goodKarma then
			disposition = 3
		end

		if player.registry["fate_q_answered"] == 7 then
			player:dialogSeq(
				{
					t,
					name .. "You again?",
					name .. "How long has it been?",
					name .. "And now here you are, dead again.",
					name .. "What did you do with that life I gave you?"
				},
				1
			)
			if disposition == 1 then
				player:dialogSeq(
					{
						t,
						name .. "Well, you were on the right track.",
						name .. "I would be proud of you if you had survived.",
						name .. "Doing the right thing is never easy, is it?",
						name .. "Now, you will be tested."
					},
					1
				)
				player.quest["holy_path"] = 1
			elseif disposition == 2 then
				player:dialogSeq(
					{
						t,
						name .. "What a waste. I had you pegged right the first time, it seems",
						name .. "Truly pathetic. At this rate, we will never meet again.",
						name .. "A life of evil leads to unhappiness, sorrow, and, too often, a painful death.",
						name .. "Now, you will be tested."
					},
					1
				)
				player.quest["unholy_path"] = 1
			elseif disposition == 3 then
				player:dialogSeq(
					{
						t,
						name .. "You've made the most of yourself.",
						name .. "But I wouldn't say you made much of a difference.",
						name .. "Your life mattered, sure, but only to you.",
						name .. "Now, you will be tested."
					},
					1
				)
				player.quest["neutral_path"] = 1
			end

			table.insert(opts, "Victory")
			table.insert(opts, "Purity")
			table.insert(opts, "Revenge")
			table.insert(opts, "Fruition")

			menu = player:menuString(name .. "You are a Seer. Which vision do you see?", opts)

			if menu == "Victory" then
				player.registry["level100_q_1"] = 1
			elseif menu == "Purity" then
				player.registry["level100_q_1"] = 2
			elseif menu == "Revenge" then
				player.registry["level100_q_1"] = 3
			elseif menu == "Fruition" then
				player.registry["level100_q_1"] = 4
			end

			player.registry["fate_q_answered"] = 8
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 8 then
			table.insert(opts, "Freedom")
			table.insert(opts, "Wealth")
			table.insert(opts, "Longevity")
			table.insert(opts, "Belief")

			menu = player:menuString(name .. "You are a Wanderer. What path do you take?", opts)

			if menu == "Freedom" then
				player.registry["level100_q_2"] = 1
			elseif menu == "Wealth" then
				player.registry["level100_q_2"] = 2
			elseif menu == "Longevity" then
				player.registry["level100_q_2"] = 3
			elseif menu == "Belief" then
				player.registry["level100_q_2"] = 4
			end

			player.registry["fate_q_answered"] = 9
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 9 then
			table.insert(opts, "Hatred")
			table.insert(opts, "Prosperity")
			table.insert(opts, "Wisdom")
			table.insert(opts, "War")

			menu = player:menuString(name .. "You are a Builder. What plan will you build?", opts)

			if menu == "Hatred" then
				player.registry["level100_q_3"] = 1
			elseif menu == "Prosperity" then
				player.registry["level100_q_3"] = 2
			elseif menu == "Wisdom" then
				player.registry["level100_q_3"] = 3
			elseif menu == "War" then
				player.registry["level100_q_3"] = 4
			end

			player.registry["fate_q_answered"] = 10
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 10 then
			table.insert(opts, "Mercy")
			table.insert(opts, "Terror")
			table.insert(opts, "Bliss")
			table.insert(opts, "Conquest")

			menu = player:menuString(name .. "You are a Leader. What is your vision?", opts)

			if menu == "Mercy" then
				player.registry["level100_q_4"] = 1
			elseif menu == "Terror" then
				player.registry["level100_q_4"] = 2
			elseif menu == "Bliss" then
				player.registry["level100_q_4"] = 3
			elseif menu == "Conquest" then
				player.registry["level100_q_4"] = 4
			end

			player.registry["fate_q_answered"] = 11
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 11 then
			table.insert(opts, "Affection")
			table.insert(opts, "Sacrifice")
			table.insert(opts, "Truth")
			table.insert(opts, "Resolve")

			menu = player:menuString(name .. "You have a Burden. What do you bear?", opts)

			if menu == "Affection" then
				player.registry["level100_q_5"] = 1
			elseif menu == "Sacrifice" then
				player.registry["level100_q_5"] = 2
			elseif menu == "Truth" then
				player.registry["level100_q_5"] = 3
			elseif menu == "Resolve" then
				player.registry["level100_q_5"] = 4
			end

			player.registry["fate_q_answered"] = 12
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 12 then
			table.insert(opts, "Change")
			table.insert(opts, "Glory")
			table.insert(opts, "Peace")
			table.insert(opts, "Control")

			menu = player:menuString(name .. "Now, tell The Almighty, what is your future?", opts)

			if menu == "Change" then
				player.registry["level100_q_6"] = 1
			elseif menu == "Glory" then
				player.registry["level100_q_6"] = 2
			elseif menu == "Peace" then
				player.registry["level100_q_6"] = 3
			elseif menu == "Control" then
				player.registry["level100_q_6"] = 4
			end

			player.registry["fate_q_answered"] = 13
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 13 then
			player:dialogSeq(
				{
					t,
					name .. "This is it, then.",
					name .. "I'll give you one last chance to impress me.",
					name .. "You think you hit the limits of mortal power?",
					name .. "You are wrong.",
					name .. "There is so much more out there, and you died before even catching a glimpse of it.",
					name .. "If you don't do better this time, then this will be our last meeting.",
					name .. "Goodbye, " .. player.name .. "."
				},
				1
			)

			player.registry["fate_q_answered"] = 14
			player.registry["killed_yourself"] = 1
			player:warp(1035, 11, 11)
			player.exp = 0
			player.registry["exp_maxes"] = 0
			player:maxLevelUp()
			spend_sp.respec(player)
			broadcast(-1, "[CONGRATULATIONS!] " .. player.name .. " has reached level 100!")
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Exemplar'!")

			if disposition == 1 then
				player:addLegend("Champion for The Almighty", "holy_path", 43, 9)
			elseif disposition == 2 then
				player:addLegend("Shunned by The Almighty", "unholy_path", 43, 6)
			elseif disposition == 3 then
				player:addLegend("Accepted by The Almighty", "neutral_path", 43, 22)
			end
		end
	end,
	level110 = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local goodKarma = player.registry["good_karma"]
		local badKarma = player.registry["bad_karma"]
		local disposition = 0

		local opts = {}

		if goodKarma > badKarma then
			disposition = 1
		elseif badKarma > goodKarma then
			disposition = 2
		elseif badKarma == goodKarma then
			disposition = 3
		end

		if player.registry["fate_q_answered"] == 14 then
			player:dialogSeq(
				{
					t,
					name .. "So here you are again.",
					name .. "It appears you have decided what kind of person you will be.",
					name .. "With that being said it is time for your exit interview."
				},
				1
			)
			if disposition == 1 then
				player:dialogSeq(
					{
						t,
						name .. "Before we start I have something to say.",
						name .. "I am so proud of you!",
						name .. "You have certainly were born with the right stuff.",
						name .. "Now, it is time to begin."
					},
					1
				)
				player:addLegend("Blessed by ASAK", "holy_path", 43, 9)
			elseif disposition == 2 then
				player:dialogSeq(
					{
						t,
						name .. "Before we start I have something to say.",
						name .. "I am disappointed in you!",
						name .. "I do not see the point in testing you now.",
						name .. "However, I will not release you until this is completed."
					},
					1
				)
				player:addLegend("Disowned by ASAK", "unholy_path", 43, 6)
			elseif disposition == 3 then
				player:dialogSeq(
					{
						t,
						name .. "Before we start I have something to say.",
						name .. "I am saddened at your selfishness.",
						name .. "I think there is still hope for you.",
						name .. "Now, it is time to begin."
					},
					1
				)
				player:addLegend("A Hopeful of ASAK", "neutral_path", 43, 22)
			end

			table.insert(opts, "Give the kid some coins!")
			table.insert(opts, "Find the kid a home!")
			table.insert(opts, "Make kid your sidekick!")
			table.insert(opts, "Eliminate the kid!")

			menu = player:menuString(name .. "You see a child, homeless and dying of starvation. What do you do?", opts)

			if menu == "Give the kid some coins!" then
				player.registry["level110_q_1"] = 1
			elseif menu == "Find the kid a home!" then
				player.registry["level110_q_1"] = 2
			elseif menu == "Make kid your sidekick!" then
				player.registry["level110_q_1"] = 3
			elseif menu == "Eliminate the kid!" then
				player.registry["level110_q_1"] = 4
			end

			player.registry["fate_q_answered"] = 15
			fate_npc.level110(player, npc)
		elseif player.registry["fate_q_answered"] == 15 then
			table.insert(opts, "Parent")
			table.insert(opts, "Child")
			table.insert(opts, "Lover")
			table.insert(opts, "Myself")

			menu = player:menuString(name .. "Only one can live. Who is it?", opts)

			if menu == "Parent" then
				player.registry["level110_q_2"] = 1
			elseif menu == "Child" then
				player.registry["level110_q_2"] = 2
			elseif menu == "Lover" then
				player.registry["level110_q_2"] = 3
			elseif menu == "Myself" then
				player.registry["level110_q_2"] = 4
			end

			player.registry["fate_q_answered"] = 16
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 16 then
			table.insert(opts, "Help my People!")
			table.insert(opts, "Buy my Hometown!")
			table.insert(opts, "Taunt My Hometown!")
			table.insert(opts, "Destory and Salt the Lands!")

			menu =
				player:menuString(
				name .. "You come from a very poor village. You get rich after leaving your home.\nWhat do you do now?",
				opts
			)

			if menu == "Help my People!" then
				player.registry["level110_q_3"] = 1
			elseif menu == "Buy my Hometown!" then
				player.registry["level110_q_3"] = 2
			elseif menu == "Taunt My Hometown!" then
				player.registry["level110_q_3"] = 3
			elseif menu == "Destory and Salt the Lands!" then
				player.registry["level110_q_3"] = 4
			end

			player.registry["fate_q_answered"] = 17
			fate_npc.level100(player, npc)
		elseif player.registry["fate_q_answered"] == 17 then
			table.insert(opts, "World Peace")
			table.insert(opts, "Infinite Wealth")
			table.insert(opts, "Infinite Power")
			table.insert(opts, "Utter Chaos")

			menu = player:menuString(name .. "You can only have one wish. What is it?", opts)

			if menu == "World Peace" then
				player.registry["level110_q_4"] = 1
			elseif menu == "Infinite Wealth" then
				player.registry["level110_q_4"] = 2
			elseif menu == "Infinite Power" then
				player.registry["level110_q_4"] = 3
			elseif menu == "Utter Chaos" then
				player.registry["level110_q_4"] = 4
			end

			player.registry["fate_q_answered"] = 18
			fate_npc.level110(player, npc)
		elseif player.registry["fate_q_answered"] == 18 then
			if disposition == 1 then
				player:dialogSeq(
					{
						t,
						name .. "Strength of the Bear!",
						name .. "Courage of the Lion!",
						name .. "Goodbye, " .. player.name .. "."
					},
					1
				)
			elseif disposition == 2 then
				player:dialogSeq(
					{
						t,
						name .. "Strength of the Bear!",
						name .. "Courage of the Lion!",
						name .. "Goodbye, " .. player.name .. "."
					},
					1
				)
			elseif disposition == 3 then
				player:dialogSeq(
					{
						t,
						name .. "You have lost my favor!",
						name .. "Goodbye, " .. player.name .. "."
					},
					1
				)
			end
			player.registry["fate_q_answered"] = 19
			player.exp = 1
			player.registry["exp_maxes"] = 0
			player.registry["mana_sold"] = 0
			player.registry["vita_sold"] = 0
			player.expSold = 0
			player.level = 5
			player.baseHealth = 1000
			player.baseMagic = 1000
			player:sendStatus()
			spend_sp.respec(player)
			player:warp(1035, 11, 11)
			player:popUp(
				"WARNING\nDO NOT REMOVE YOUR EQUIPMENT!\nYOU WILL NOT BE ABLE TO EQUIP IT AGAIN UNTIL YOU REACH THE LEVEL REQUIREMENT ON EACH PIECE!\n\nWARNING\nDO NOT REMOVE YOUR GEAR!"
			)
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].registry["fate_q_answered"] == 0 or pc[i].registry["fate_q_answered"] == 7 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

validateEmail = function(str)
	if str == nil then
		return nil
	end
	if (type(str) ~= "string") then
		error("Expected string")
		return nil
	end
	local lastAt = str:find("[^%@]+$")
	local localPart = str:sub(1, (lastAt - 2)) -- Returns the substring before '@' symbol
	local domainPart = str:sub(lastAt, #str) -- Returns the substring after '@' symbol
	-- we werent able to split the email properly
	if localPart == nil then
		return nil, "Local name is invalid"
	end

	if domainPart == nil then
		return nil, "Domain is invalid"
	end
	-- local part is maxed at 64 characters
	if #localPart > 64 then
		return nil, "Local name must be less than 64 characters"
	end
	-- domains are maxed at 253 characters
	if #domainPart > 253 then
		return nil, "Domain must be less than 253 characters"
	end
	-- somthing is wrong
	if lastAt >= 65 then
		return nil, "Invalid @ symbol usage"
	end
	-- quotes are only allowed at the beginning of a the local name
	local quotes = localPart:find('["]')
	if type(quotes) == "number" and quotes > 1 then
		return nil, "Invalid usage of quotes"
	end
	-- no @ symbols allowed outside quotes
	if localPart:find("%@+") and quotes == nil then
		return nil, "Invalid @ symbol usage in local part"
	end

	-- no dot found in domain name
	if not domainPart:find("%.") then
		return nil, "No TLD found in domain"
	end
	-- only 1 period in succession allowed
	if domainPart:find("%.%.") then
		return nil, "Too many periods in domain"
	end
	if localPart:find("%.%.") then
		return nil, "Too many periods in local part"
	end
	-- just a general match
	if not str:match("[%w]*[%p]*%@+[%w]*[%.]?[%w]*") then
		return nil, "Email pattern test failed"
	end
	-- all our tests passed, so we are ok
	return true
end
