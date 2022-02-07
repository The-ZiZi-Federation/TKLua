-- Hon by the Sea (Harvey)
drunk_fur_trader = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			--local buyitems = {"black_fox_fur", "red_fox_fur", "light_fox_fur", "rainbow_fox_fur", "kumiho_tail", "black_wolf_fur", "wolf_claw", "dire_wolf_fur", "dire_wolf_fang", "red_wolf_fur", "brown_wolf_fur"}
			--local sellitems = {"black_fox_fur", "red_fox_fur", "light_fox_fur", "rainbow_fox_fur", "kumiho_tail", "black_wolf_fur", "wolf_claw", "dire_wolf_fur", "dire_wolf_fang", "red_wolf_fur", "brown_wolf_fur"}

			local buyitems = {}
			local sellitems = {
				3016,
				3017,
				3018,
				3019,
				3020,
				3031,
				3032,
				3033,
				3034,
				3035,
				3036,
				3041,
				3042,
				3043,
				3044,
				3051,
				3052,
				3053,
				3054
			}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")

			if player.level >= 10 and player.quest["drunk_mug"] == 0 then
				table.insert(opts, "Lost your mug?")
			end
			if player.level >= 10 and player.quest["drunk_mug"] == 1 and player.registry["found_drunk_mug"] == 1 then
				table.insert(opts, "Is this your mug?")
			end

			if player.level >= 15 and player.quest["fox_fur"] == 0 then
				table.insert(opts, "What kind of work?")
			end
			if player.level >= 15 and player.quest["fox_fur"] == 1 then
				table.insert(opts, "Is this enough furs?")
			end

			if player.quest["drunk_mug"] == 2 and player.quest["fox_fur"] == 2 then
				menu = player:menuString(name .. "(hic) T-thankya buddy, you suuure are the b-(hic)-best...", opts)
			elseif player.quest["drunk_mug"] == 2 and player.quest["fox_fur"] < 2 then
				menu = player:menuString(name .. "(hic) Go away, cantya see I have TOOONES of w-work to do...", opts)
			elseif player.level >= 70 and player.quest["lost_something"] == 0 then
				menu =
					player:menuString(
					name .. "(hic)Can't buhleev I lost it in there... Tha guy shore aint gun be harppy thats for shore...",
					opts
				)
			else
				menu =
					player:menuString(
					name .. "(hic) N-not only do I have TOOONES of w-work to do, but now I lost my damned m-mug...",
					opts
				)
			end

			if menu == "Buy" then
				player:buyExtend(name .. "What would you like to buy?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif menu == "Lost your mug?" then
				player.quest["drunk_mug"] = 1
				player:msg(4, "[Quest Started] Find Randall's mug!", player.ID)
				player:dialogSeq(
					{t, name .. "Yesh I shore did, I was out partying at t-the little outdoor bar southwest of here..."},
					1
				)
			elseif menu == "Is this your mug?" then
				if player:hasItem("drunk_mug", 1) == true then
					if player:removeItem("drunk_mug", 1) == true then
						player.quest["drunk_mug"] = 2
						giveXP(player, 1000)
						player:addGold(5000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You found Randall's mug!", player.ID)
						player:dialogSeq({t, name .. "Thanks bud! You alllright, yeah."}, 1)
					else
						player:dialogSeq({t, name .. "Welll, wherizzit?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Welll, wherizzit?"}, 1)
				end
			elseif menu == "What kind of work?" then
				player.quest["fox_fur"] = 1
				player:msg(
					4,
					"[Quest Started] Gather 50 Black and Red Fox Fur, 10 Light and Rainbow Fox Fur and Kumiho's Tails!",
					player.ID
				)
				player:dialogSeq(
					{
						t,
						name .. "Dirty work. N-need cash for booze, need skins to sell.",
						name ..
							"So go to the Fox Hole by west gate, get me 50 Black Fox Fur, 50 Red Fox Fur, 10 Light Fox Fur, 10 Rainbow Fox Fur, oh, and bring me Kumiho's Tails as well.",
						name .. "You wanna work, thassa work I need done..."
					},
					1
				)
			elseif menu == "Is this enough furs?" then
				if
					player:hasItem("black_fox_fur", 50) == true and player:hasItem("red_fox_fur", 50) == true and
						player:hasItem("light_fox_fur", 10) == true and
						player:hasItem("rainbow_fox_fur", 10) == true and
						player:hasItem("kumiho_tail", 1) == true
				 then
					if
						player:removeItem("black_fox_fur", 50) == true and player:removeItem("red_fox_fur", 50) == true and
							player:removeItem("light_fox_fur", 10) == true and
							player:removeItem("rainbow_fox_fur", 10) == true and
							player:removeItem("kumiho_tail", 1) == true
					 then
						player.quest["fox_fur"] = 2
						giveXP(player, 4000)
						player:addGold(5000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You gathered Fox Fur for Randall!", player.ID)
						player:dialogSeq(
							{
								t,
								name ..
									"Youse a reel pal. Wanna come get drunk after I sell these furs? I promise, I'll show you a good time like you've never seen..."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "No. That's not enough furs for me to get drunk."}, 1)
					end
				else
					player:dialogSeq({t, name .. "No. That's not enough furs for me to get drunk."}, 1)
				end
			end
		end
	),
	say = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local speech = string.lower(player.speech)
		local item
		local number

		if string.find(speech, "(.*)lost(.*)") then
			if player.quest["lost_something"] < 2 then
				if player.quest["lost_something"] == 0 then
					player.quest["lost_something"] = 1
				end
				if player.registry["necromon_crate"] == 0 then
					player.registry["necromon_crate"] = math.random(1, 5)
				end
				player:dialogSeq({t, name .. "Yesh I losht it, and now he'sh gonna kill mee..."}, 1)
			end
		elseif string.find(speech, "(.*)necromon(.*)") then
			if player.quest["lost_something"] >= 2 and player.quest["lost_something"] < 4 then
				player.quest["lost_something"] = 3
				player:dialogSeq(
					{
						t,
						name ..
							"Yesh! Nechromong! Thasst the thing I lost! That was the naem, allryte.\n\nNowif I could o-(hic)-nly premember who wanted that tihng."
					},
					1
				)
			end
		end

		if
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 20) == "black fox fur" or
				string.sub(speech, 8, 18) == "red fox fur" or
				string.sub(speech, 8, 20) == "light fox fur" or
				string.sub(speech, 8, 22) == "rainbow fox fur" or
				string.sub(speech, 8, 18) == "kumiho tail" or
				string.sub(speech, 8, 21) == "black wolf fur" or
				string.sub(speech, 8, 19) == "red wolf fur" or
				string.sub(speech, 8, 21) == "brown wolf fur" or
				string.sub(speech, 8, 16) == "wolf claw" or
				string.sub(speech, 8, 20) == "dire wolf fur" or
				string.sub(speech, 8, 21) == "dire wolf fang"
		 then
			item = Item(string.sub(speech, 8, 20))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item ~= nil) then
				number = tonumber(string.match(speech, "buy my " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeItem(item.yname, number)) == true then
					player:addGold(item.sell * number)
					npc:talk(
						0,
						"" .. npc.name .. ": I bought your " .. number .. " " .. item.name .. " for " .. (item.sell * number) .. " coins."
					)
				end
			end
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if (pc[i].level >= 10 and pc[i].quest["drunk_mug"] == 0) or pc[i].level >= 15 and pc[i].quest["fox_fur"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
