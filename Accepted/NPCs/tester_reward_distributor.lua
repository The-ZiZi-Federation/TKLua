tester_reward_distributor = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local veryHighRewards = {279, 294, 300, 301, 458, 4}
			local highRewards = {265, 590, 251, 263, 277, 258, 267, 274, 339, 250, 262, 252, 257, 305, 351}
			local mediumRewards = {266, 273, 259, 283, 343, 347, 408, 278, 282, 393, 298, 582, 284, 319}
			local maxInvSlotRewards = {
				265,
				301,
				251,
				263,
				277,
				250,
				262,
				252,
				266,
				273,
				257,
				259,
				294,
				305,
				343,
				347,
				351,
				408,
				458
			}

			local you = player.ID
			local chance = math.random(1, 100)

			table.insert(opts, "How Was Alpha?")
			if player.registry["alpha_rewards_received"] == 0 then
				table.insert(opts, "Can I have my Alpha Reward?")
			end
			--if player.m == 1 then table.insert(opts, "Can I have my Alpha Reward?") end
			if player.registry["alpha_rewards_received"] == 1 then
				table.insert(opts, "Thank you for the gifts!")
			end

			menu = player:menuString(name .. "Hello! You are back! Wonderful! Daabbaaddee! Come for your rewards?", opts)

			if menu == "How Was Alpha?" then
				player:dialogSeq(
					{
						t,
						name .. "Well, it had it's ups and downs for sure.",
						name .. "The community was very helpful while the kingdoms were active.",
						name .. "Can't wait to see all the activity in this new Beta version 2.0!"
					},
					1
				)
			elseif menu == "Can I have my Alpha Reward?" then
				player:dialogSeq(
					{
						t,
						name .. "I would be delighted to provide you with your Alpha Rewards!",
						name ..
							"NOTE: All rewards are calculated on recorded assists, reports, and suggestions.\n We decided to combine Alpha and Early Beta Rewards.\n As such everyone can receive a reward here but not everyone will receive the same.",
						name .. "LASTLY: There are some random roll rewards as well, you may or may not get them based on chance."
					},
					1
				)

				for i = 1, #veryHighRewards do
					if you == veryHighRewards[i] then
						if you == 279 then
							if player.registry["reward_level"] == 0 then
								player.registry["reward_level"] = 1
							end
						elseif you == 294 then
							if player.registry["reward_level"] == 0 then
								player.registry["reward_level"] = 2
							end
						elseif you == 300 then
							if player.registry["reward_level"] == 0 then
								player.registry["reward_level"] = 3
							end
						elseif you == 301 then
							if player.registry["reward_level"] == 0 then
								player.registry["reward_level"] = 4
							end
						elseif you == 458 then
							if player.registry["reward_level"] == 0 then
								player.registry["reward_level"] = 5
							end
						end
					end
				end

				for i = 1, #highRewards do
					if you == highRewards[i] then
						for j = 1, #maxInvSlotRewards do
							if you == maxInvSlotRewards[j] then
								if player.registry["reward_level"] == 0 then
									player.registry["reward_level"] = 6
								end
							else
								if player.registry["reward_level"] == 0 then
									player.registry["reward_level"] = 7
								end
							end
						end
					end
				end

				for i = 1, #mediumRewards do
					if you == mediumRewards[i] then
						for j = 1, #maxInvSlotRewards do
							if you == maxInvSlotRewards[j] then
								if player.registry["reward_level"] == 0 then
									player.registry["reward_level"] = 8
								end
							else
								if player.registry["reward_level"] == 0 then
									player.registry["reward_level"] = 9
								end
							end
						end
					end
				end

				if player.registry["reward_level"] == 0 then
					player.registry["reward_level"] = 10
				end

				if player.registry["reward_level"] == 1 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 2)
					player:addItem("golden_ticket", 2)
					player:addItem("max_inv_slot", 2)
					player:addItem("lapis_ticket_2500", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "Thank you Blasyn. You were our biggest contributor from Alpha.\nAs a token of our appreciation...",
							name .. "We have given you a Lapis Ticket for 2500 and a bunch of other stuff including 2 Engrave Tokens.",
							name .. "Please contact Peter for a personalized Title. Thanks Again!"
						},
						1
					)
				elseif player.registry["reward_level"] == 2 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 2)
					player:addItem("max_inv_slot", 2)
					player:addItem("lapis_ticket_500", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you Edge. You were the biggest help for Scoundrel testing and development.\nAs a token of our appreciation...",
							name ..
								"We have given you a Lapis Ticket for 500 and a bunch of other stuff including 2 Gold Tickets and 2 Inventory Expansions.",
							name .. "Please contact Peter for a personalized Title. Thanks Again!"
						},
						1
					)
				elseif player.registry["reward_level"] == 3 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 2)
					player:addItem("max_inv_slot", 1)
					player:addItem("lapis_ticket_500", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you Destruction. You were our second highest Bug Finder from Alpha.\nAs a token of our appreciation...",
							name .. "We have given you a Lapis Ticket for 500 and a bunch of other stuff including 2 Gold Tickets.",
							name .. "Please contact Peter for a personalized Title. Thanks Again!"
						},
						1
					)
				elseif player.registry["reward_level"] == 4 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 2)
					player:addItem("golden_ticket", 2)
					player:addItem("max_inv_slot", 1)
					player:addItem("lapis_ticket_1000", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "Thank you Oryx. You were our Biggest Bug Finder from Alpha.\nAs a token of our appreciation...",
							name .. "We have given you a Lapis Ticket for 1000 and a bunch of other stuff including 2 Engrave Tokens.",
							name .. "Please contact Peter for a personalized Title. Thanks Again!"
						},
						1
					)
				elseif player.registry["reward_level"] == 5 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 2)
					player:addItem("golden_ticket", 2)
					player:addItem("max_inv_slot", 2)
					player:addItem("lapis_ticket_2500", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "Thank you Atlas. Helping with the website was so much help.\nAs a token of our appreciation...",
							name .. "We have given you a Lapis Ticket for 2500 and a bunch of other stuff including 2 Engrave Tokens.",
							name .. "Please contact Peter for a personalized Title. Thanks Again!"
						},
						1
					)
				elseif player.registry["reward_level"] == 6 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 1)
					player:addItem("max_inv_slot", 1)
					player:addItem("lapis_ticket_500", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you for being a Major Contributor to MornaTK during Alpha and Early Beta. We hope you enjoy your rewards!"
						},
						1
					)
				elseif player.registry["reward_level"] == 7 then
					player:addLegend("Major Contributor in Early Access Alpha " .. curT(), "alpha_major_contributor", 48, 10)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					if chance <= 25 then
						player:addItem("max_inv_slot", 1)
					end
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you for being a Major Contributor to MornaTK during Alpha and Early Beta. We hope you enjoy your rewards!"
						},
						1
					)
				elseif player.registry["reward_level"] == 8 then
					player:addLegend("Contributor in Early Access Alpha " .. curT(), "alpha_contributor", 79, 11)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 1)
					player:addItem("max_inv_slot", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you for being a Contributor to MornaTK during Alpha and Early Beta. We hope you enjoy your rewards!"
						},
						1
					)
				elseif player.registry["reward_level"] == 9 then
					player:addLegend("Contributor in Early Access Alpha " .. curT(), "alpha_contributor", 79, 11)
					player:addItem("engrave_token", 1)
					player:addItem("golden_ticket", 1)
					player.registry["alpha_tester"] = 1
					player.registry["beta_tester"] = 1
					player.registry["alpha_rewards_received"] = 1
					finishedQuest(player)
					if chance <= 25 then
						player:addItem("max_inv_slot", 1)
					end
					player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"Thank you for being a Contributor to MornaTK during Alpha and Early Beta. We hope you enjoy your rewards!"
						},
						1
					)
				elseif player.registry["reward_level"] == 10 then
					if player.ID <= 632 or player.ID == 673 then
						player:addLegend("Tester in Early Access Alpha " .. curT(), "alpha_tester", 106, 13)
						player:addItem("golden_ticket", 1)
						player.registry["beta_tester"] = 1
						player.registry["alpha_rewards_received"] = 1
						finishedQuest(player)
						if chance <= 25 then
							player:addItem("max_inv_slot", 1)
						end
						player:msg(4, "[TESTER REWARDS RECEIVED] Thank you for helping Make Morna Great Again!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Thank you for being a Tester for MornaTK during Alpha and Early Beta. We hope you enjoy your rewards!"
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name ..
									"I am sorry, you were not born in time for rewards. Don't worry though, you can gain rewards by reporting bugs and assisting GMs during beta testing."
							},
							1
						)
					end
				end
			elseif menu == "Thank you for the gifts!" then
				player:dialogSeq(
					{
						t,
						name .. "No, Thank you for testing Morna TK.",
						name .. "Truly, these kingdoms need people like you, or it will all just fall apart!"
					},
					1
				)
			end
		end
	)
}
