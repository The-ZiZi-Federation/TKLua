

change_stats = {

cast = function(player, target)

	local type = player.registry["change_stats_type"]

	if target.ID == player.ID then
		player:freeAsync()
		change_stats.click(player, core)
	return else
		if target.blType == BL_MOB then
			if type == 1 then
				
				target:talk(0, "Def : ")
			elseif type == 2 then
				
				target:talk(0, "Level : ")
			elseif type == 3 then
				
				target:talk(0, "Might : ")
			elseif type == 4 then
				
				target:talk(0, "Will : ")
			elseif type == 5 then
				
				target:talk(0, "Grace : ")
			elseif type == 6 then
				
				target:talk(0, "Wisdom : ")
			elseif type == 7 then
				
				target:talk(0, "Con : ")
			elseif type == 8 then
				
				target:talk(0, "Protection : ")
			elseif type == 9 then
				
				target:talk(0, "Armor : ")
			end
		end
	end
end,

click = async(function(player, npc)
	
	local type = ""
	local statstype = ""
	local name = "<b>[Change Status]\n\n"
	if player.gfxClone == 0 then clone.equip(player, npc) else clone.gfx(player, npc) end
	npc.gfxClone = 1
	player.lastClick = npc.ID
	player.dialogType = 2
	
	local opts = {"Def", "Level", "Might", "Will", "Grace", "Wisdom", "Con", "Protection", "Armor"}
	
	if player.registry["change_statsType"] == 0 then statstype = "Increase" else statstype = "Decrease" end
	if player.registry["change_stats_type"] == 0 then type = "None" else type = opts[player.registry["change_stats_type"]].."" end	
	
	local opsi = {}
	table.insert(opsi, "Amount           : "..player.registry["change_stats_amount"])
	table.insert(opsi, "Spell Type       : "..statstype)
	table.insert(opsi, "Status to change : "..type)
	
	menu = player:menuString(name.."", opsi)
	
	if menu == "Amount           : "..player.registry["change_stats_amount"] then
		input = tonumber(math.ceil(player:input(name.."How much "..type.." you want to change?")))
		if input > 0 then
			player.registry["change_stats_amount"] = input
			change_stats.click(player, npc)
		end
	elseif menu == "Spell Type       : "..statstype then
		if player.registry["change_statsType"] == 0 then
			player.registry["change_statsType"] = 1
		else
			player.registry["change_statsType"] = 0
		end
		change_stats.click(player, npc)
	elseif menu == "Status to change : "..type then
		menu2 = player:menuSeq(name.."Status Type: "..type, opts, {})
		player.registry["change_stats_type"] = menu2
		player:popUp("Stats to increase : "..opts[menu])
	end
end)
}