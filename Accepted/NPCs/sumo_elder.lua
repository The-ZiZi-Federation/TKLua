sumo_elder = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {"Challenge the Course", "What is the Sumo Course?", "Leave"}
			local confirm
			local menu

			if player.ID ~= 4 then
				return
			end

			if player.level < 80 then
				player:dialogSeq({t, name .. "Sorry, I don't talk to weaklings."}, 1)
				return
			end

			if player.registry["sumo_course_times_complete"] >= 1 then
				if not player:hasSpell("knockback_strike") then
					player:dialogSeq(
						{
							t,
							name .. "Incredible! Your Sumo skills are fearsome indeed.",
							name .. "As promised, I have a technique to teach that you may find useful.",
							"The elder spends several hours drilling you in his school's special technique.",
							"You learn the Knockback Strike skill.",
							name .. "You muse use these skills wisely, young one.",
							name .. "Just kidding! Have fun shoving enemies around."
						},
						1
					)
					player:addSpell("knockback_strike")
					player:sendMinitext("You learn Knockback Strike!")
				end
			end

			if player.quest["sumo_course"] == 0 then
				player:dialogSeq({t, name .. "Sorry, can't talk. Too parched, need a little drink."}, 1)
			elseif player.quest["sumo_course"] == 1 then
				player:dialogSeq(
					{t, name .. "Maybe you're powerful enough to teach my students a lesson about messing with the locals."},
					1
				)
			elseif player.quest["sumo_course"] == 2 then
				player:dialogSeq({t, name .. "Have you brought me something powerful?"}, 1)
			elseif player.quest["sumo_course"] == 3 then
				player:dialogSeq(
					{t, name .. "You're powerful alright. Now, what are we going to do about those wild students of mine?"},
					1
				)
			elseif player.quest["sumo_course"] == 4 then
				player:dialogSeq({t, name .. "Do you have 15 Sumo Medals yet?"}, 1)
			elseif player.quest["sumo_course"] == 5 then
				menu = player:menuString(name .. "Are you going to try the Sumo Course?", options)
			end

			if menu == "Challenge the Course" then
				local confirm = player:menuString(name .. "Are you sure you are ready?", {"Yes", "No"})

				if confirm == "Yes" then
					if (#player.group > 1) then
						player:dialogSeq({t, name .. "Your group is too big! You must face the Sumo Course alone."}, 1)
					else
						if player:hasSpace("Yellow Scroll", 1) then
							player:addItem("yellow_scroll", 1)
							local mapStart = getFreeInstance(1)
							if (mapStart ~= false) then
								if (loadInstance(mapStart, "sumoCourse") == true) then
									player.registry["sumo_course_start_time"] = os.time()
									player.registry["sumo_course_dunks"] = 0
									player:warp(mapStart, 53, 23)
								end
							end
						else
							player:dialogSeq({t, name .. "There is something I must give you first, please free some space in your bag."}, 1)
						end
					end
				end
			elseif menu == "What is the Sumo Course?" then
				player:dialogSeq(
					{
						t,
						name .. "The Sumo Course is an ancient training regimen that we have practiced tirelessly.",
						name ..
							"The rules are simple enough. You must push 10 defending sumos into the water, then make your way safely to the East side of the Course.",
						name ..
							"Before you enter, I will give you a Yellow Scroll. If you are unable to complete the Sumo Course, you must use that scroll to return home.",
						name ..
							"If you complete the Sumo Course within 3 minutes, I will teach you an ancient Sumo Skill. Isn't that grand?"
					},
					1
				)
			end
		end
	),
	say = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {}
			local confirm
			local menu

			local s = string.lower(player.speech)

			if player.level < 80 then
				return
			end

			if player.quest["sumo_course"] == 0 then
				if string.find(s, "(.*)drink(.*)") then
					player:dialogSeq(
						{
							t,
							name .. "Did I stutter? Yeah, I need a little something to drink.",
							name .. "Worthless kid..."
						},
						1
					)
					return
				end
				if string.find(s, "(.*)water(.*)") then
					if player:hasItem("vial_of_water", 1) == true then
						if player:removeItem("vial_of_water", 1) == true then
							player.quest["sumo_course"] = 1
							player:dialogSeq(
								{
									t,
									name .. "Water? Is this for me?",
									"**The old Sumo sips delicately from the vial**",
									name .. "Hey, thanks, kid. My boys hate the Hon locals, but you don't seem that bad.",
									name .. "Maybe you can help me teach them a lesson: that not everyone in Hon is to be messed with."
								},
								1
							)
							return
						end
					else
						player:dialogSeq(
							{
								t,
								name .. "Yeah, a little water'd be great. What, don't you have any?",
								name .. "Weak."
							},
							1
						)
						return
					end
				end
			elseif player.quest["sumo_course"] == 1 then
				if string.find(s, "(.*)lesson(.*)") then
					player:dialogSeq(
						{
							t,
							name .. "Well, I'd like someone to teach them a lesson anyway.",
							name .. "Maybe it could be you.",
							name .. "I dunno though, are you powerful enough?"
						},
						1
					)
					return
				end
				if string.find(s, "(.*)powerful(.*)") then
					player.quest["sumo_course"] = 2
					player:dialogSeq(
						{
							t,
							name .. "My students won't be defeated by just anyone.",
							name .. "You're going to have to be pretty powerful, and so far nothing I've seen from you really hits the mark.",
							name .. "Bring me something powerful, then maybe I'll believe you can take them on."
						},
						1
					)
					return
				end
			elseif player.quest["sumo_course"] == 2 then
				if string.find(s, "(.*)eldritch(.*)") then
					if player:hasItem("eldritch_enchant_rune", 1) == true then
						if player:removeItem("eldritch_enchant_rune", 1) == true then
							player.quest["sumo_course"] = 3
							player:dialogSeq(
								{
									t,
									"**The old Sumo's eyes shine brightly**",
									name .. "Hahaha, an Eldritch Enchant Rune! I haven't seen one of these in years!",
									name .. "I won one as a prize in the Sumo Wars a very long time ago, but lost it somewhere.",
									name .. "Thank you for replacing it! You're so powerful and kind! **grin**",
									name .. "Now, about the matter of my students..."
								},
								1
							)
							return
						end
					else
						player:dialogSeq(
							{
								t,
								name .. "Eldritch Runes are rumored to be pretty powerful indeed.",
								name .. "Of course a weakling like you doesn't have one."
							},
							1
						)
						return
					end
				end
			elseif player.quest["sumo_course"] == 3 then
				if string.find(s, "(.*)students(.*)") then
					player.quest["sumo_course"] = 4
					player:dialogSeq(
						{
							t,
							name .. "You've proven yourself, now go test your mettle against my students.",
							name .. "They have been hanging out over the bridge, shoving anyone who walks by into the water.",
							name ..
								"Each of them carries a Sumo Medal. It is a badge of honor, a sigil that demonstrates their dedication to the sumo art.",
							name ..
								"You are going to dunk a bunch of those brats and take their medals. Can you imagine how they'll feel having to beg me to get them back? **cackles**",
							name .. "Bring me 15 of those Sumo Medals, and you'll be rewarded."
						},
						1
					)
					return
				end
			elseif player.quest["sumo_course"] == 4 then
				if string.find(s, "(.*)medals(.*)") then
					if player:hasItem("sumo_medal", 15) == true then
						if player:removeItem("sumo_medal", 15) == true then
							player.quest["sumo_course"] = 5
							finishedQuest(player)
							player:leveledEXP("minigame")
							player:addLegend("Dunked Sumo Crew to defend Hon by the Sea " .. curT(), "sumo_event", 7, 16)
							player:dialogSeq(
								{
									t,
									name .. "You really did it!",
									name .. "Those little bastards are gonna be moping for weeks!",
									name .. "I can't thank you enough for the laughs. You Hon folks are alright.",
									name .. "Since you did me a favor, I'll grant you a rare opportunity: I'll let you challenge the Sumo Course.",
									name ..
										"The Sumo Course is an ancient training program. We were able to become the world's greatest sumos only through mastery of the Course.",
									name .. "Just talk to me any time you want to take the challenge."
								},
								1
							)
							return
						end
					else
						player:dialogSeq(
							{
								t,
								name .. "Sumo Medals are indeed what I asked you to retrieve.",
								name .. "Come back when you have 15 of them."
							},
							1
						)
						return
					end
				end
			end
		end
	)
}
