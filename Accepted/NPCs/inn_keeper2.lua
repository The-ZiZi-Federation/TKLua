inn_keeper2 = {
	on_spawn = function(mob)
		mob.side = 2
		mob:sendSide()
	end,
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local total, max, txt = player.registry["wardrobe_total"], player.registry["max_wardrobe"], ""
			local buy = {}

			if player.registry["bank_pin"] == 0 then
				register_bankPin.click(player, npc)
				return
			else
				local opts = {}
				table.insert(opts, "Storage")
				table.insert(opts, "Bank")
				table.insert(opts, "Take a nap")
				table.insert(opts, "Change Bank Pin")
				table.insert(opts, "Exit")

				menu = player:menuString(name .. "How can I help you?", opts)

				if menu == "Storage" then
					inn_keeper2.f1click(player, npc)
				elseif menu == "Bank" then
					inn_keeper2.click2(player, npc)
				elseif menu == "Buy Supplies" then
					player:buyExtend(name .. "What do you wish to buy?", buy)
				elseif menu == "Change Bank Pin" then
					change_pin(player, npc)
				elseif menu == "Mail Box" then
					local item = player:getParcel()
					local optsPO = {"Send Parcel"}
					if item ~= false then
						txt = "You have a pending parcel"
						table.insert(optsPO, "Receive Parcel")
					end
					choice = player:menuString("<b>[Mail Box]\n\n" .. txt .. "", optsPO)
					if choice == "Send Parcel" then
						player:sendParcelTo(npc)
					elseif choice == "Receive Parcel" then
						player:receiveParcelFrom(npc)
					end
				elseif menu == "Take a nap" then
					player:dialogSeq(
						{t, name .. "You can borrow one of our beds for a nap. This will restore your Health and Mana."},
						1
					)
					local nap =
						player:menuString(
						name .. "Would you like to spend " .. (player.level * 10) .. " coins for a nice rest?",
						{"Yes", "No"}
					)
					if (nap == "Yes") then
						if (player:removeGold(player.level * 10)) then
							if player.m == 1018 then -- drunk duck
								player:warp(player.m, 10, 4)
							elseif player.m == 1016 then -- three tree
								player:warp(player.m, 8, 4)
							elseif player.m == 4045 then -- seymours inn
								player:warp(player.m, 7, 5)
							elseif player.m == 4050 then -- one door inn
								player:warp(player.m, 6, 9)
							end
							power_nap.cast(player)
						end
					end
				end
			end
		end
	),
	click2 = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		if player.registry["bank_pin"] > 0 then
			menu = player:menuString(name .. "How can I help you?", {"Deposit Money", "Withdraw Money"})
			if menu == "Deposit Money" then
				player:bankAddMoney()
			elseif menu == "Withdraw Money" then
				if player.registry["bank_access"] < os.time() then
					input = player:input("Please Enter your Pin number :")
					if math.abs(tonumber(input)) == player.registry["bank_pin"] then
						player.registry["bank_access"] = os.time() + 40
						player:bankWithdrawMoney()
					else
						player:popUp("Incorrect PIN number!")
					end
				elseif player.registry["bank_access"] >= os.time() then
					player:bankWithdrawMoney()
				end
			end
		else
			register_bankPin.click(player, npc)
		end
	end,
	f1click = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		menu = player:menuString(name .. "How can I help you?", {"Deposit item", "Withdraw item", "Exit"})
		if menu == "Deposit item" then
			player:showBankAdd()
		elseif menu == "Withdraw item" then
			if player.registry["bank_access"] < os.time() then
				input = player:input("Please Enter your Pin number :")
				if math.abs(tonumber(input)) == player.registry["bank_pin"] then
					player.registry["bank_access"] = os.time() + 40
					player:showBank("What do you want to withdraw?")
				else
					player:popUp("Incorrect PIN number!")
				end
			elseif player.registry["bank_access"] >= os.time() then
				player:showBank("What do you want to withdraw?")
			end
		end
	end
}
