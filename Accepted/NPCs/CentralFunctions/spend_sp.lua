spend_sp = {
	click = function(player, npc)
		--	clone.gfx(player, npc)
		player.dialogType = 0

		local opts = {}
		table.insert(opts, "Might")
		table.insert(opts, "Will")
		table.insert(opts, "Grace")
		table.insert(opts, "Armor")
		--	table.insert(opts, "Tier")

		local sp = player.registry["stat_points"]
		local menu, req, max, txt, input, add, ok
		local value = 0
		local increase = 0

		if player.registry["stat_points"] == 0 and player.registry["sp_spent"] == 0 then
			totalStatPoints = player.registry["total_stat_points"]
			player.registry["stat_points"] = totalStatPoints
			player:popUp("You have been awarded " .. totalStatPoints .. " Stat Points! Spend them wisely.")
			return
		end

		menu =
			player:menuString(
			"<b>[Spend SP]\n\nYou currently have " ..
				player.registry["stat_points"] .. " points to spend.\n\nWhich stat would you like to increase?",
			opts
		)

		if menu == "Might" then
			value = player.basemight
			increase =
				tonumber(
				math.floor(
					player:input(
						"Current Might: " ..
							format_number(value) ..
								"\nCurrent SP:   " .. format_number(sp) .. "\n\nHow much Might do you want?\n\n1 SP = 1 Might"
					)
				)
			)
			if value + increase > 4294967295 then
				anim(player)
				player:sendMinitext("Error value!")
			elseif increase > 0 then
				if player.registry["sp_spent_might"] + increase > player.level then
					player:popUp("Number of SP spent per stat can't exceed character level!")
					return
				end

				confirm =
					player:menuString(
					"Before   : " ..
						format_number(value) ..
							"\nIncrease : " ..
								format_number(increase) ..
									"\n------------------ +\nAfter >> " .. format_number(value + increase) .. "\nConfirm your choice",
					{"Confirm", "Cancel"}
				)
				if confirm == "Confirm" then
					if player.registry["stat_points"] >= increase then
						player.basemight = player.basemight + increase
						player.registry["stat_points"] = player.registry["stat_points"] - increase
						player.registry["sp_spent"] = player.registry["sp_spent"] + increase
						player.registry["sp_spent_might"] = player.registry["sp_spent_might"] + increase
						player:calcStat()
						player:sendMinitext("Might increased by: " .. increase)
						player:sendMinitext("Remaining SP: " .. player.registry["stat_points"])
					else
						player:popUp("Not enough SP!")
					end
				end
			end
		elseif menu == "Will" then
			value = player.basewill
			increase =
				tonumber(
				math.floor(
					player:input(
						"Current Will: " ..
							format_number(value) ..
								"\nCurrent SP:   " .. format_number(sp) .. "\n\nHow much Will do you want?\n\n1 SP = 1 Will"
					)
				)
			)
			if value + increase > 4294967295 then
				anim(player)
				player:sendMinitext("Error value!")
			elseif increase > 0 then
				if player.registry["sp_spent_will"] + increase > player.level then
					player:popUp("Number of SP spent per stat can't exceed character level!")
					return
				end
				confirm =
					player:menuString(
					"Before   : " ..
						format_number(value) ..
							"\nIncrease : " ..
								format_number(increase) ..
									"\n------------------ +\nAfter >> " .. format_number(value + increase) .. "\nConfirm your choice",
					{"Confirm", "Cancel"}
				)
				if confirm == "Confirm" then
					if player.registry["stat_points"] >= increase then
						player.basewill = player.basewill + increase
						player.registry["stat_points"] = player.registry["stat_points"] - increase
						player.registry["sp_spent"] = player.registry["sp_spent"] + increase
						player.registry["sp_spent_will"] = player.registry["sp_spent_will"] + increase
						player:calcStat()
						player:sendMinitext("Will increased by: " .. increase)
						player:sendMinitext("Remaining SP: " .. player.registry["stat_points"])
					else
						player:popUp("Not enough SP!")
					end
				end
			end
		elseif menu == "Grace" then
			value = player.basegrace
			increase =
				tonumber(
				math.floor(
					player:input(
						"Current Grace: " ..
							format_number(value) ..
								"\nCurrent SP:   " .. format_number(sp) .. "\n\nHow much Grace do you want?\n\n1 SP = 1 Grace"
					)
				)
			)
			if value + increase > 4294967295 then
				anim(player)
				player:sendMinitext("Error value!")
			elseif increase > 0 then
				if player.registry["sp_spent_grace"] + increase > player.level then
					player:popUp("Number of SP spent per stat can't exceed character level!")
					return
				end
				confirm =
					player:menuString(
					"Before   : " ..
						format_number(value) ..
							"\nIncrease : " ..
								format_number(increase) ..
									"\n------------------ +\nAfter >> " .. format_number(value + increase) .. "\nConfirm your choice",
					{"Confirm", "Cancel"}
				)
				if confirm == "Confirm" then
					if player.registry["stat_points"] >= increase then
						player.basegrace = player.basegrace + increase
						player.registry["stat_points"] = player.registry["stat_points"] - increase
						player.registry["sp_spent"] = player.registry["sp_spent"] + increase
						player.registry["sp_spent_grace"] = player.registry["sp_spent_grace"] + increase
						player:calcStat()
						player:sendMinitext("Grace increased by: " .. increase)
						player:sendMinitext("Remaining SP: " .. player.registry["stat_points"])
					else
						player:popUp("Not enough SP!")
					end
				end
			end
		elseif menu == "Armor" then
			value = player.basearmor
			increase =
				tonumber(
				math.floor(
					player:input(
						"Current Armor: " ..
							format_number(value) ..
								"\nCurrent SP:   " ..
									format_number(sp) .. "\n\nHow much SP would you like to spend on Armor?\n\n1 SP = 80 Armor"
					)
				)
			)
			if value + increase > 4294967295 then
				anim(player)
				player:sendMinitext("Error value!")
			elseif increase > 0 then
				if player.registry["sp_spent_armor"] + increase > player.level then
					player:popUp("Number of SP spent per stat can't exceed character level!")
					return
				end
				armorIncrease = increase * 80
				confirm =
					player:menuString(
					"Before   : " ..
						format_number(value) ..
							"\nIncrease : " ..
								format_number(armorIncrease) ..
									"\n------------------ +\nAfter >> " .. format_number(value + armorIncrease) .. "\nConfirm your choice",
					{"Confirm", "Cancel"}
				)
				if confirm == "Confirm" then
					if player.registry["stat_points"] >= increase then
						player.basearmor = player.basearmor + armorIncrease
						player.registry["stat_points"] = player.registry["stat_points"] - increase
						player.registry["sp_spent"] = player.registry["sp_spent"] + increase
						player.registry["sp_spent_armor"] = player.registry["sp_spent_armor"] + increase
						player:calcStat()
						player:sendMinitext("Armor increased by: " .. armorIncrease)
						player:sendMinitext("Remaining SP: " .. player.registry["stat_points"])
					else
						player:popUp("Not enough SP!")
					end
				end
			end
		end
	end,
	respec = function(player)
		local mainStat = math.ceil(((player.level) * .2))
		local secondStat = math.ceil((mainStat * .5))
		local thirdStat = math.ceil((secondStat * .6))
		local path = player.baseClass

		if path == 1 then --fighter paths
			player.basemight = mainStat
			player.basegrace = secondStat
			player.basewill = thirdStat
			player.basearmor = player.level * 100
		elseif path == 2 then --scoundrel paths
			player.basemight = secondStat
			player.basegrace = mainStat
			player.basewill = thirdStat
			player.basearmor = player.level * 35
		elseif path == 3 then --wizard paths
			player.basemight = thirdStat
			player.basegrace = secondStat
			player.basewill = mainStat
			player.basearmor = player.level * 20
		elseif path == 4 then --priest paths
			player.basemight = secondStat
			player.basegrace = thirdStat
			player.basewill = mainStat
			player.basearmor = player.level * 60
		end

		player.registry["stat_points"] = 0
		player.registry["sp_spent"] = 0
		player.registry["sp_spent_might"] = 0
		player.registry["sp_spent_grace"] = 0
		player.registry["sp_spent_will"] = 0
		player.registry["sp_spent_armor"] = 0
		--	player.basearmor = 0
		--	player.basemight = 1
		--	player.basegrace = 1
		--	player.basewill = 1
		if player.registry["bonus_stat_points"] == 0 then
			player.registry["total_stat_points"] = (player.level * 2)
		else
			player.registry["total_stat_points"] = (player.level * 2) + player.registry["bonus_stat_points"]
		end
		player:sendMinitext(
			"Your stats have been set to base values and your SP has been returned to you. Press F1 to spend your SP."
		)
		player:calcStat()
		player:sendStatus()
	end,
	gain = function(player)
		local num = 2

		player.registry["stat_points"] = player.registry["stat_points"] + num
		player.registry["total_stat_points"] = player.registry["total_stat_points"] + num
		player:sendMinitext("You gained " .. num .. " SP! Press F1 to spend SP and increase your stats.")
	end
}

--spend_sp.respec(Player(""))
