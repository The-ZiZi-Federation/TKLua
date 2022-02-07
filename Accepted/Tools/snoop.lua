snoop = {
	clear = function(player)
		for i = 1, 50 do
			player.npc["snoop" .. i] = 0
			player.npc["snoop_by" .. i] = 0
		end
	end,
	menu = function(player, npc)
		local name = "<b>[Snoop Chat]\n\n"
		local opts, setting = {}, {"Remove from list", "Change color", "<< Back"}
		table.insert(opts, "[Add]+")
		table.insert(opts, "------------ Target List ------------")
		table.insert(opts, "")

		player.dialogType = 2

		for i = 1, 50 do
			if player.npc["snoop" .. i] > 0 then
				if Player(player.npc["snoop" .. i]).npc["snoop_by" .. i] == player.ID then
					table.insert(
						opts,
						i .. " - " .. Player(player.npc["snoop" .. i]).name .. " - (" .. snoop.getColor(player, i) .. ")"
					)
				end
			end
		end
		menu = player:menuString(name .. "This tool allows you to read all chats from target.", opts)

		if menu == "" or menu == "------------ Target List ------------" then
			snoop.menu(player, npc)
			return
		elseif menu == "[Add]+" then
			t = player:input(name .. "Enter a target name:")
			if Player(t) ~= nil then
				if Player(t).ID == player.ID then
					player:dialogSeq({name .. "You cannot add your self!"}, 1)
					snoop.menu(player, npc)
					return
				else
					for i = 1, 50 do
						if player.npc["snoop" .. i] == Player(t).ID then
							player:dialogSeq({name .. "Target (" .. Player(t).name .. ") is already in list!"}, 1)
							snoop.menu(player, npc)
							return
						else
							if player.npc["snoop" .. i] == 0 then
								player.npc["snoop" .. i] = Player(t).ID
								Player(t).npc["snoop_by" .. i] = player.ID
								snoop.menu(player, npc)
								return
							end
						end
					end
				end
			end
		else
			for i = 1, 50 do
				if menu == i .. " - " .. Player(player.npc["snoop" .. i]).name .. " - (" .. snoop.getColor(player, i) .. ")" then
					change =
						player:menuString(
						name ..
							"Target : " ..
								Player(player.npc["snoop" .. i]).name .. "\nColor  : " .. snoop.getColor(player, i) .. "\n\nWhat to do next?",
						setting
					)
					if change == "<< Back" then
						snoop.menu(player, npc, target)
					elseif change == "Change color" then
						color =
							player:menuString(
							"This would change target's chat color on your screen.\nWhat color for target's chat?",
							{"Blue", "Yellow", "Orange", "Grey"}
						)
						if color ~= nil then
							snoop.changeColor(player, npc, Player(player.npc["snoop" .. i]), color)
							snoop.menu(player, npc, target)
						end
						return
					elseif change == "Remove from list" then
						snoop.clear(Player(player.npc["snoop" .. i]))
						player:sendMinitext("Removed!!")
						snoop.menu(player, npc, target)
					end
				end
			end
		end
	end,
	showChat = function(player, speech, type)
		local talk = ""
		local show, color
		if type == 0 then
			talk = "Talk"
		elseif type == 1 then
			talk = "Shout"
		end

		for i = 1, 50 do
			if player.npc["snoop_by" .. i] > 0 then
				show = Player(player.npc["snoop_by" .. i])
				if show.npc["snoop" .. i] == player.ID then
					color = show.npc["snoop" .. player.ID .. "color"]
					show:msg(color, "[Snoop(" .. talk .. ")]" .. player.name .. ": " .. speech, show.ID)
				end
			end
		end
	end,
	changeColor = function(player, npc, target, color)
		local colorC = {"Blue", "Yellow", "Orange", "Grey"}
		local reg = {0, 4, 12, 11}

		for i = 1, 50 do
			if target.npc["snoop_by" .. i] == player.ID and player.npc["snoop" .. i] == target.ID then
				for c = 1, #colorC do
					if color == colorC[c] then
						player.npc["snoop" .. target.ID .. "color"] = reg[c]
						player:sendMinitext("Done!!")
					end
				end
			end
		end
	end,
	getColor = function(player, slot)
		local color = ""
		local target = Player(player.npc["snoop" .. slot])

		if player.npc["snoop" .. slot] > 0 then
			if target.npc["snoop_by" .. slot] == player.ID then
				if player.npc["snoop" .. target.ID .. "color"] == 0 then
					color = "Blue"
				end
				if player.npc["snoop" .. target.ID .. "color"] == 4 then
					color = "Yellow"
				end
				if player.npc["snoop" .. target.ID .. "color"] == 12 then
					color = "Orange"
				end
				if player.npc["snoop" .. target.ID .. "color"] == 11 then
					color = "Grey"
				end
			end
		end
		return color
	end
}
