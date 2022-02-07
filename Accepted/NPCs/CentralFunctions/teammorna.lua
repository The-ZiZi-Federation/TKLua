morna2 = {
	click = function(player, npc)
		clone.gfx(player, npc)
		local total = {}
		local name, stat = "<b>[Team Morna]\n\n", ""
		--	local t = {graphic = convertGraphic(776, "monster"), color = 0}
		--	player.npcGraphic = t.graphic
		--	player.npcColor = t.color
		player.dialogType = 2

		if player.registry["swingDamage_script"] == 0 then
			xx = "Old"
		else
			xx = "New"
		end

		local opts = {}
		table.insert(opts, "Invite")
		table.insert(opts, "Member list")
		table.insert(opts, "swingDamage = " .. xx)
		table.insert(opts, "Team Morna Board")

		for i = 1, 20 do
			if core.gameRegistry["morna" .. i] > 0 then
				table.insert(total, i)
			end
		end

		menu = player:menuString(name .. "Welcome to Team Morna..\nWhat do you need?\n\nTotal member: " .. #total, opts)

		if menu == "Invite" then
			target = string.lower(player:input(name .. "Enter target name:"))
			target = Player(target)
			if target == nil then
				player:popUp(name .. "User not found in database!")
				return
			else
				if target.ID == player.ID then
					player:popUp(name .. "You cannot invite your self!")
					return
				else
					if morna2.checkID(target) == true then
						player:popUp(name .. "Target is already in Team!")
						return
					else
						if player.gfxClone == 0 then
							clone.equip(player, core)
						else
							clone.gfx(player, core)
						end
						core.gfxClone = 1
						target.lastClick = core.ID
						target:sendAnimation(248)
						target:freeAsync()
						morna2.invitation(target, core, player)
						player:popUp(name .. "Invitation sended!")
					end
				end
			end
		elseif menu == "swingDamage = " .. xx then
			if player.registry["swingDamage_script"] == 0 then
				player.registry["swingDamage_script"] = 1
			else
				player.registry["swingDamage_script"] = 0
			end
			player:sendMinitext("Done!!")
		elseif menu == "Team Morna Board" then
			player:showBoard(301)
		elseif menu == "Member list" then
			local member = {}
			for i = 1, 20 do
				if player.gameRegistry["morna" .. i] > 0 then
					table.insert(member, getOfflineID(player.gameRegistry["morna" .. i]) .. "")
				end
			end
			mem = player:menuString(name .. "\nTotal member: " .. #member, member)
			if mem ~= nil then
				if string.lower(player.name) == string.lower(mem) then
					todo = player:menuString("<b>[" .. mem .. "]\n\nWhat do you want to do?", {"Leave Team Morna", "Exit"})
					if todo == "Leave Team Morna" then
						slot = morna2.slot(player.ID)
						if player.gameRegistry["morna" .. slot] == player.ID then
							player.gameRegistry["morna" .. slot] = 0
							player.registry["morna"] = 0
							morna2.msg(0, "[Team Morna] " .. player.name .. " is out from Team morna")
						end
					end
					return
				else
					if player.gmLevel == 0 and Player(string.lower(mem)).gmLevel > 0 then
						player:msg(
							4,
							"[Team Morna] " .. player.name .. " is try to kick you from Team Morna",
							Player(string.lower(mem)).ID
						)
						player:popUp(name .. "You cannot kick this member!")
						return
					else
						if Player(string.lower(mem)) ~= nil then
							stat = "Online"
						else
							stat = "Offline"
						end
						todo =
							player:menuString(
							"<b>[" ..
								mem ..
									"]\n\nGM level: " .. Player(string.lower(mem)).gmLevel .. "\nStatus: " .. stat .. "\n\nWhat do you want to do?",
							{"Kick", "Exit"}
						)
						if todo == "Kick" then
							t = Player(string.lower(mem))
							if t ~= nil then
								if t.ID == 2 then
									player:msg(4, "[Team Morna] " .. player.name .. " is try to kick you from Team Morna", t.ID)
									player:popUp(name .. "You cannot kick this member!")
									return
								else
									for i = 1, 20 do
										if player.gameRegistry["morna" .. i] == t.ID then
											found = i
											break
										end
									end
									if found == 0 then
										return false
									else
										player.gameRegistry["morna" .. found] = 0
										t.registry["morna"] = 0
										player:sendMinitext("Kicked!")
										morna2.msg(0, "[Team Morna] " .. mem .. " has kicked from team by " .. player.name .. "!!")
										morna2.click(player, npc)
									end
								end
							end
						end
					end
				end
			end
		end
	end,
	invitation = async(
		function(player, npc, by)
			local name = "<b>[Team Morna]\n\n"
			local user = player:getUsers()
			player.dialogType = 2

			menu = player:menuString(name .. "You're invited by " .. by.name .. " to Team Morna.", {"Confirm", "Decline"})

			if menu == "Decline" then
				player:msg(0, "[Team Morna] " .. player.name .. " has declined your invitation!", by.ID)
				return
			else
				player:sendAnimation(221)
				for i = 1, 20 do
					if player.gameRegistry["morna" .. i] == 0 then
						player.gameRegistry["morna" .. i] = player.ID
						break
					end
				end
				player.registry["morna"] = 1
				if #user > 0 then
					for i = 1, #user do
						if user[i].registry["morna"] == 1 then
							user[i]:msg(0, "" .. player.name .. " has joined Team Morna (invited by: " .. by.name .. ")", user[i].ID)
						end
					end
				end
			end
		end
	),
	msg = function(type, text)
		local target = {}

		for i = 1, 20 do
			if core.gameRegistry["morna" .. i] > 0 then
				table.insert(target, core.gameRegistry["morna" .. i])
			end
		end

		if #target > 0 then
			for i = 1, #target do
				if Player(target[i]) ~= nil then
					core:msg(type, text .. "", Player(target[i]).ID)
				end
			end
		end
	end,
	slot = function(id)
		local found

		for i = 1, 20 do
			if core.gameRegistry["morna" .. i] == id then
				found = i
				break
			end
		end
		return found
	end,
	checkID = function(player)
		local found = false

		for i = 1, 20 do
			if core.gameRegistry["morna" .. i] == player.ID then
				found = true
			end
		end
		return found
	end
}
