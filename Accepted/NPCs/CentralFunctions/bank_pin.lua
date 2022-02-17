register_bankPin = {
	click = function(player, npc)
		local t = {graphic = convertGraphic(809, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		pin1 = player:input("<b>[Create PIN]\n\nEnter your new PIN(6 digits):\n\n\nNote:\n0 (Zero) is not allowed!")
		if tonumber(pin1) ~= nil and string.len(tonumber(pin1)) == 6 and tonumber(pin1) > 0 then
			pin2 = player:input("<b>[PIN Confirmation]\n\nRetype PIN for confirmation: ")
			if tonumber(pin2) == tonumber(pin1) then
				ok = player:menuString("<b>[Bank PIN]\n\nYour Bank PIN : \n<b>" .. tonumber(pin2) .. "\nConfirm?", {"Yes", "No"})
				if ok == "Yes" then
					--player:warp(1015, 5, 4)	--Jadespear
					--player:sendAnimation(16)
					--player:playSound(29)
					npc:sendAction(1, 20)
					player.registry["bank_pin"] = tonumber(pin2)
					player:dialogSeq(
						{
							"<b>[Bank PIN]\n\nBank PIN created! Don't to forget it!\n\nYour PIN : " ..
								player.registry["bank_pin"] .. "\n\n\n\n<b>      Welcome to Morna "
						},
						1
					)
				else
					register_bankPin.click(player, npc)
				end
			else
				player:dialogSeq({t, "<b>[PIN Confirmation]\n\nPIN confirmation failed! (did not match)!"}, 1)
				register_bankPin.click(player, npc)
			end
		else
			player:dialogSeq({t, "<b>[Bank PIN]\n\nPIN must contains 6 digits number!\n\n\nNote:\n0 (Zero) is not allowed!"}, 1)
			register_bankPin.click(player, npc)
		end
	end
}

change_pin = function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local oldpin = player.registry["bank_pin"]

	if oldpin > 0 then
		old = player:input("Enter Old Bank Pin:")
		if tonumber(old) == oldpin then
			new = player:input("Enter New Pin:")
			if tonumber(new) > 0 and string.len(tonumber(new)) == 6 then
				acc = player:input("Enter once again to confirm:")
				if tonumber(acc) == tonumber(new) then
					player.registry["bank_pin"] = tonumber(new)
					player:dialogSeq(
						{
							"<b>[Bank]\n\nChange Pin Success! Don't to forget it!\n\nYour PIN : " ..
								oldpin .. "\n\n\n\n<b>      Welcome to Morna "
						},
						1
					)
				else
					player:dialogSeq({t, "<b>[Bank]\n\nPin not match! Failed to change Bank PIN"}, 1)
				end
			else
				player:dialogSeq({t, "<b>[Bank PIN]\n\nPIN must contains 6 digits number!\n\n\nNote:\n0 (Zero) is not allowed!"})
			end
		else
			player:dialogSeq({t, "<b>[Bank]\n\nWrong PIN!"}, 1)
		end
	end
end
