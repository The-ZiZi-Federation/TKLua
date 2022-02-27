
buya_admin = {

click = async(function(player, npc)

	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID
	
	local opts={}
	
	table.insert(opts, "What can I do here?")
	if player.registry["buya_citizen"] == 1 then table.insert(opts, "How goes the recordkeeping?") end
	if player.registry["buya_citizen"] == 0 then table.insert(opts, "I'd like to become a citizen of Buya.") end
	

	
	menu = player:menuString(name.."Hello! I am the town Administrator. I keep track of the city's population and grant citizenship.", opts)
	
	if (menu == "What can I do here?") then
		player:dialogSeq({t, name.."You're new to the Kingdom? You should register your name as a citizen if you plan on sticking around.",
							name.."If you become a citizen you will recieve a mark on your papers and a special weapon."}, 1)
	elseif (menu == "I'd like to become a citizen of Buya.") then
		choice = player:menuString("You want to become a citizen of Buya?", {"Yes", "No"})
		if choice == "Yes" then
			player:dialogSeq({t, name.."Great! I hope you decide to stick around!",
								name.."Now that you are a citizen, I'll give you a special weapon to assist you in your adventures...",
								name.."It's called a Titanium Fork...there are only a few left so don't tell your friends!",
								name.."Best of luck in your travels...."}, 1)

			if player.registry["buya_citizen"] == 0 then player:addItem("sky_iron_fork", 1) end
			player:removeLegendbyName("citizen")
			player:addLegend("Became a citizen of Buya "..curT(), "citizen", 11, 1)
			player.registry["buya_citizen"] = 1
			player.country = 1  -- Buya
			player:sendStatus()
			finishedQuest(player)
		end
	elseif (menu == "How goes the recordkeeping?") then
		player:dialogSeq({t, name.."I am just fine, myself. How about you?",
							name.."I hope you're enjoying your new life in Buya."}, 1)
	end	
end
)
}