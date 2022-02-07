hon_guard = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local locs = {}

			local mob = player:getObjectsInMap(player.m, BL_MOB)

			if #mob > 0 then
				for i = 1, #mob do
					if mob[i].yname == "angry_blue_chick" then
						player:dialogSeq({t, name .. "Something funny is going on. I'd better not leave my post."}, 1)
						return
					end
				end
			end

			table.insert(opts, "I'm lost! Can you help me?")
			table.insert(opts, "No, sorry.")

			table.insert(locs, "The Quiet Temple ((TUTORIAL))")
			table.insert(locs, "The Drunk Duck Inn")
			table.insert(locs, "The Arena")
			table.insert(locs, "The Fighter's Guild")
			table.insert(locs, "The Scoundrel's Guild")
			table.insert(locs, "The Wizard's Guild")
			table.insert(locs, "The Priest's Guild")
			table.insert(locs, "The Stable")
			table.insert(locs, "The Weapon Smith")
			table.insert(locs, "The Armor Smith")
			table.insert(locs, "The Clothing Shop")
			table.insert(locs, "The Butcher")
			table.insert(locs, "The Game Room")
			table.insert(locs, "The Oracle")
			table.insert(locs, "Harvey's Hut")
			table.insert(locs, "Banon's Workshop")
			table.insert(locs, "The Sewer")
			table.insert(locs, "The Earthworks")

			table.insert(locs, "The Palace")
			table.insert(locs, "The Town Administrator")
			table.insert(locs, "The Parcel Shop")
			table.insert(locs, "The Three Tree Inn")
			table.insert(locs, "The Hon City Eye")
			table.insert(locs, "The Hon Casino")

			menu = player:menuString(name .. "It sure is boring being a guard. Can I help you?", opts)

			if menu == "I'm lost! Can you help me?" then
				warp = player:menuString(name .. "Where would you like to go?", locs)
				if warp == "The Quiet Temple ((TUTORIAL))" then
					player:dialogSeq(
						{
							t,
							name .. "I don't really know what goes on in there, but I see new faces coming out of the temple all the time."
						},
						1
					)
					player:warp(1000, 115, 121)
				elseif warp == "The Drunk Duck Inn" then
					player:dialogSeq(
						{t, name .. "The Drunk Duck is a popular place. It's where the Lapis Vendor hangs out. Follow me."},
						1
					)
					player:warp(1000, 97, 85)
				elseif warp == "The Fighter's Guild" then
					player:dialogSeq({t, name .. "The Fighter's Guild is near the north gate. I'll show you the way."}, 1)
					player:warp(1000, 89, 51)
				elseif warp == "The Scoundrel's Guild" then
					if player.baseClass ~= 0 and player.baseClass ~= 2 then
						player:dialogSeq({t, name .. "You must be mistaken. There's nothing like that here."}, 1)
					else
						if player.quest["leech_lord"] == 2 then
							player:dialogSeq(
								{
									t,
									name .. "It's you!",
									name .. "Did you need an escort to the Baron's Manor, sir?"
								},
								1
							)
							player:warp(1000, 114, 41)
						else
							player:dialogSeq(
								{
									t,
									name .. "(LOUDLY)\n\nI don't know what on earth you're talking about.",
									name .. "*glares*\n\nA rookie like you? You'll have to go in the back way."
								},
								1
							)
							player:warp(1000, 125, 35)
						end
					end
				elseif warp == "The Wizard's Guild" then
					player:dialogSeq(
						{
							t,
							name .. "There's no guild in town, but that old kook Delta can take you there.",
							name .. "I'll show you where he hangs out."
						},
						1
					)
					player:warp(1000, 111, 54)
				elseif warp == "The Priest's Guild" then
					player:dialogSeq(
						{
							t,
							name .. "Priest Guild? You must want the House of ASAK.",
							name .. "It is a holy place, dedicated to the worship of the All Seeing All Knowing GOD."
						},
						1
					)
					player:warp(1000, 31, 39)
				elseif warp == "The Stable" then
					player:dialogSeq(
						{
							t,
							name .. "Looking for transportation? If you're looking to buy a horse of your own you'll need to go to Lortz.",
							name ..
								"The only stable in Hon is owned by Clayven Courier Company, but Clayven Jr might let you borrow one of their horses."
						},
						1
					)
					player:warp(1000, 41, 8)
				elseif warp == "The Weapon Smith" then
					player:dialogSeq({t, name .. "That place can be tough to find if you're new. I'll show you the way."}, 1)
					player:warp(1000, 56, 62)
				elseif warp == "The Armor Smith" then
					player:dialogSeq({t, name .. "The armor smith's shop is near the north gate. I can show you."}, 1)
					player:warp(1000, 57, 52)
				elseif warp == "The Clothing Shop" then
					player:dialogSeq({t, name .. "Hon Finer Things is near the north gate. I can show you."}, 1)
					player:warp(1000, 66, 52)
				elseif warp == "The Butcher" then
					player:dialogSeq({t, name .. "That place can be tough to find if you're new. I'll show you the way."}, 1)
					player:warp(1000, 66, 62)
				elseif warp == "The Game Room" then
					player:dialogSeq(
						{
							t,
							name .. "The game room? That place is awesome! I love throwing dice and playing goh. I'll show you where it is."
						},
						1
					)
					player:warp(1000, 20, 55)
				elseif warp == "The Arena" then
					player:dialogSeq(
						{t, name .. "Looking for some bloodsports? I know the feeling. I'll show you where we blow off steam."},
						1
					)
					player:warp(1000, 114, 83)
				elseif warp == "The Oracle" then
					player:dialogSeq(
						{t, name .. "The oracle? That dude creeps me out. His place is near north gate. I'll show you."},
						1
					)
					player:warp(1000, 90, 24)
				elseif warp == "Harvey's Hut" then
					player:dialogSeq(
						{
							t,
							name .. "Harvey is a great kid, but don't drink anything he offers you.",
							name .. "His drinks can be a little... explosive."
						},
						1
					)
					player:warp(1000, 100, 125)
				elseif warp == "Banon's Workshop" then
					player:dialogSeq(
						{
							t,
							name ..
								"Banon is a great guy, but he's always trying to make a quick buck to fund some new invention. I'll show you his workshop."
						},
						1
					)
					player:warp(1000, 27, 115)
				elseif warp == "The Sewer" then
					player:dialogSeq(
						{
							t,
							name ..
								"There are entrances to the sewer all over town. There's one near the north gate that's easy to spot. I'll show you."
						},
						1
					)
					player:warp(1000, 65, 22)
				elseif warp == "The Earthworks" then
					player:dialogSeq(
						{t, name .. "I'm not sure why anyone would want to go in that snake hole, but I'll show you where it is."},
						1
					)
					player:warp(1000, 63, 123)
				elseif warp == "The Palace" then
					player:dialogSeq(
						{
							t,
							name .. "They're kind of weird about security up there. No one has gone in or out for quite a while.",
							name .. "It's in the northwest corner of town, I'll show you."
						},
						1
					)
					player:warp(1000, 22, 35)
				elseif warp == "The Town Administrator" then
					player:dialogSeq(
						{t, name .. "Going to become a Hon Citizen? Chi-Fu will help you out, I'll take you to his office."},
						1
					)
					player:warp(1000, 15, 41)
				elseif warp == "The Parcel Shop" then
					player:dialogSeq(
						{t, name .. "It's fun sending parcels to your friends! The shop is in the southwest, near the bar. Follow me."},
						1
					)
					player:warp(1000, 19, 128)
				elseif warp == "The Three Tree Inn" then
					player:dialogSeq(
						{t, name .. "They have clean rooms at a good price, but that manager creeps me out. Watch out for him."},
						1
					)
					player:warp(1000, 120, 135)
				elseif warp == "The Hon City Eye" then
					player:dialogSeq(
						{t, name .. "It won't do you any good until you find another Eye somewhere, but I'll show you the one in Hon."},
						1
					)
					player:warp(1000, 99, 144)
				elseif warp == "The Hon Casino" then
					player:dialogSeq({t, name .. "Please be careful there. Remember, the house ALWAYS wins."}, 1)
					player:warp(1003, 92, 50)
				end
			else
			end
		end
	)
}
