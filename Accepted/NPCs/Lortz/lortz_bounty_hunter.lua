lortz_bounty_hunter = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			--local timer = player.registry["daily_ogre_hunt_timer"]

			table.insert(opts, "Todays price?")
			table.insert(opts, "Collect bounty")

			if player.quest["met_lortz_bounty_hunter"] == 0 then
				player.quest["met_lortz_bounty_hunter"] = 1
				player:dialogSeq(
					{
						t,
						name .. "You came through Lortz Pass? So you fought your way past the ogres?",
						name .. "I'm a bounty hunter, tasked by the city of Lortz with combating ogre activity in the area.",
						name ..
							"Maybe you've met the other hunters. Hon's Magistrate is soft on ogres, so he limits how many bounties they can collect.",
						name .. "In Lortz we do things differently. Once per day I'll pay a bounty on as many ogre ears as you can carry.",
						name .. "The bounty price will vary from day to day, so if you want a better deal you can try coming back later."
					},
					1
				)
			end

			menu = player:menuString(name .. "Are you here to collect a bounty?", opts)

			if menu == "Todays price?" then
				player:dialogSeq(
					{
						t,
						name .. "Today's price is: " .. npc.registry["bounty_price"] .. " coins.",
						name .. "Don't like it? Come back another time."
					},
					1
				)
			elseif menu == "Collect bounty" then
				if player.registry["lortz_bounty_timer"] < os.time() then
					input = player:input("How many Ogre Ears do you want to collect a bounty on?")
					input = math.abs(tonumber(input))
					price = npc.registry["bounty_price"]
					if input > 0 then
						if player:hasItem("ogre_ear", input) == true then
							player:removeItem("ogre_ear", input)
							player:addGold(input * price)
							player.registry["lortz_bounty_timer"] = os.time() + 86400
							player:dialogSeq({t, name .. "Come back again sometime!"}, 1)
						else
							player:dialogSeq({t, name .. "That number doesn't seem right..."})
						end
					end
				else
					player:dialogSeq(
						{t, name .. "You already collected once today. If you still have more Ogre Ears, then come back tomorrow."}
					)
				end
			else
			end
		end
	),
	price = function(npc)
		--	local price = npc.registry["bounty_price"]
		local r = math.random(300, 750)

		npc.registry["bounty_price"] = r
	end
}
