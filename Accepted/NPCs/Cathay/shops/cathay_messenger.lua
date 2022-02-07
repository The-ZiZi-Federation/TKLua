cathay_messenger = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local txt = ""

			-- Table Inserts -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			table.insert(opts, "Mailbox")
			table.insert(opts, "Leave")

			menu = player:menuString(name .. "How can I help you today?", opts)

			if menu == "Mailbox" then
				local item = player:getParcel()
				local optsPO = {"Send Parcel"}
				if item ~= false then
					txt = "What would you like to do?\n\nYou have a new parcel"
					table.insert(optsPO, "Receive Parcel")
				else
					txt = "What would you like to do?\n\nYou have no new parcels"
				end
				choice = player:menuString(name .. "" .. txt .. "", optsPO)
				if choice == "Send Parcel" then
					player:sendParcelTo(npc)
				elseif choice == "Receive Parcel" then
					player:receiveParcelFrom(npc)
				end
			end
		end
	)
}
