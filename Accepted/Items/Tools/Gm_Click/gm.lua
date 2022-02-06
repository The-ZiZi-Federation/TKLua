gm = {

snoopChat = function(player, text)
	
	local god = Player(2)
	
	if player.ID ~= 2 then
		god:talk(0, god.name..": "..text)
	end
end,

createPIN = async(function(player)
	
	local name = "<b>[GM Security]\n\n"
	
	if player.registry["gm_pin"] == 0 then
		first = math.abs(tonumber(math.floor(player:input(name.."Enter your new PIN:\n\n<b>NOTE:\nDo not use number 'zero' (0) as the first digit!"))))
		if first > 0 then
			if string.len(first) ~= 6 then
				player:dialogSeq({t, name.."ERROR!\n\nPIN must in 6 digits of number and do not use zero(0) as the first digit!"},1)
				player:freeAsync()
				gm.createPIN(player)
			return else
				confirm = math.abs(tonumber(math.floor(player:input(name.."Retype your PIN for confirmation:"))))
				if confirm == first then
					menu = player:menuString(name.."You're about to use '"..confirm.."' as your GM PIN?", {"Confirm PIN", "Let me retype", "Exit"})
					if menu == "Let me retype" then
						player:freeAsync()
						gm.createPIN(player)
					return elseif menu == "Exit" then return nil elseif menu == "Confirm PIN" then
						player.registry["gm_pin"] = confirm
						player:sendStatus()
						player:dialogSeq({t, name.."GM PIN created!\n<b>GM PIN: "..player.registry["gm_pin"].."\n\nPlease do not to forget this PIN, or your character will NEVER be promoted to BECOME A GM again forever!"})
					end
				end
			end
		end
	end
end),

firstLogin = async(function(player)
	
	local t = {graphic = convertGraphic(654, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local nama, name = player.name, "<b>[GM Security]\n\n"
	if player.ID == 2 then nama = "Peter" end
	if player.ID == 4 then nama = "Jacob" end
	
	local pin = player.registry["security_code"]

	if pin == 0 then
		player:dialogSeq({t, name.."Welcome back Mr."..nama.."!,\n\nYou are login a GM character!\nTo avoid a hacker in order to using the GM commands, from now you will be ask to enter a 'GM PIN' for every login.",
						name.."This will proof that if you are the owner of this GM character! Of course if you failed or entered a wrong PIN, then your character will no longer have the GM Powers and access to it! (Command & GM Tools)",
						name.."Because this is the first time you do login since we are decided to use this security system for any GMs, then you must to create a new 'GM PIN' for your character ("..player.name..")"}, 1)
		player:freeAsync()
		gm.createPIN(player)
	end
end)
}