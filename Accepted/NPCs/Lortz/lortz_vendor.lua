lortz_vendor = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "Buy (500,000 coins)")
			table.insert(opts, "No, thanks.")
			player:dialogSeq(
				{
					t,
					name ..
						"Well hello there sir or ma'am well you do most certainly, genuinely and in fact positively look far and farther down upon your luck,",
					name ..
						"So let me be the first to lift your spirits by telling you about an incredible opportunity that I am now going to put forward forth toward you here today on this most finest of days",
					name ..
						"For you are now one of the luckiest of the lucky and the fewest of the few, as I am letting you have a chance at a chance to put yourself into a select and secretive category of individuals.",
					name ..
						"I am in fact suggesting that you yourself should make every effort to become one of the proud and satisfied owners of the incredible, the original, the most-certainly-one-of-a-kind genuine Vending Ransel.",
					name ..
						"I assure you I can already hear your voice inside my own head-skull. 'What is a Vending Ransel?' you ask? Oh, you poor, wonderful, ignorant, rich, (rich? c'mon...) newest and best friend of mine...",
					name ..
						"A genuine, one-of-a-kind Vending Ransel is the answer to all of life's troubles. It'll soothe your tired eyes at night and it'll wake you up in the morning with breakfast ready",
					name .. "...What?",
					name .. "Ok, ok, it won't cook you breakfast. It isn't magic, you know.",
					name .. "What it will do, is let you set up your own shop, anytime, anywhere.",
					name ..
						"You can load up to 5 items into the Vending Ransel, set their prices, and then you're ready to open up for business.",
					name .. "When something is sold, you'll be send a letter with a copy of the invoice.",
					name ..
						"It really is a great invention, I promise. And worth every copper! For you, here, today, I'll only charge 500,000 coins."
				},
				1
			)

			menu = player:menuString(name .. "So, do you want to buy a Vending Ransel?", opts)

			if menu == "Buy (500,000 coins)" then
				if player:removeGold(500000) == true then
					player:addItem("vending_ransel", 1)
					player:dialogSeq(
						{
							t,
							name .. "Wow! Thanks! I promise, you won't regret it.",
							name ..
								"To use your new Vending Ransel, just equip it, and press F1 and choose 'Vending'. Just note that you won't be able to use it everywhere, prime market locations only."
						},
						1
					)
				else
					player:dialogSeq(
						{
							t,
							name ..
								"Sorry, I guess exclusivity isn't for everyone. This isn't a charity, so come back when you can afford it."
						},
						1
					)
				end
			else
			end
		end
	)
}
