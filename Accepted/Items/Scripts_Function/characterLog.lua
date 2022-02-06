function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

characterLog = {

bossKillLog = function(boss, player)

	local items = player:getObjectsInCell(boss.m, boss.x, boss.y, BL_ITEM)
	local names = {}
	local dir, text = "../rtklua/History/logs/boss_kills/boss_kill_log_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")

	if #items > 0 then
		for i = 1, #items do
			table.insert(names, items[i].name)
		end
	end

	text = text.."<"..os.date().."> ["..boss.name.."] killed by ["..player.name.."] | @"..player.mapTitle.." ("..player.m..") | Floor items: "..table.concat(names, ", ").."\n"

	file:write(text.."")
	file:flush()	


end,

divineLightDailyTotal = function()

	local amount = core.gameRegistry["divine_light_lapis_daily"]

	local dir, text = "../rtklua/History/logs/divine_light/divineLightLog_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date("%m.%d.%Y").."> Total Lapis Lazuli spent on Divine Light: "..amount.."\n"
	
	file:write(text.."")
	file:flush()

end,

divineLight = function(player, amount)

	local dir, text = "../rtklua/History/logs/divine_light/divineLightLog_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date().."> "..player.name.."("..player.ID..") spent "..amount.." Lapis Lazuli on Divine Light | @"..player.mapTitle.." ("..player.m..")\n"
	
	file:write(text.."")
	file:flush()

end,

localChat = function(player, speech)

	local dir, text = "../rtklua/History/logs/chatlogs/chatLog_full_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date().."> "..player.name.."("..player.ID.."): '"..speech.."' | @"..player.mapTitle.." ("..player.m..")\n"
	
	file:write(text.."")
	file:flush()

end,


gmSpeechWrite = function(player, speech)

	local dir, text = "../rtklua/History/logs/gm_character_chat/chatLog_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date().."> "..player.name.."("..player.ID.."): '"..speech.."' | @"..player.mapTitle.." ("..player.m..")\n"
	
--	text = text.."Date & Time     : "..os.date().."\n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Speech		: "..speech.."\n\n"

	file:write(text.."")
	file:flush()

end,


speechWrite = function(player, speech)

	local dir, text = "../rtklua/History/logs/chatlogs/chatLog_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."Date & Time     : "..os.date().."\n"
	text = text.."Map		: "..player.mapTitle.."\n"
	text = text.."Speech		: "..speech.."\n\n"

	file:write(text.."")
	file:flush()

end,

xpWrite = function(player, xp)

	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text =       "==== [EXP Gain] ==================================================================\n"
	text = text.."Date & Time     : "..os.date().."\n"
	text = text.."Map		: "..player.mapTitle.."\n"
	text = text.."EXP Gain	: "..xp.."\n"
	text = text.."Total EXP	: "..player.exp.."\n\n"
	
	file:write(text.."")
	file:flush()

end,

spellDamageLog = function(player, target, damage)
	local dir, text = "../rtklua/History/logs/spell_log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text =       "-[Damage Out]-\n"
	text = text.."Date & Time     : "..os.date().."\n"
	text = text.."Target Name     : "..target.name.."\n"
	text = text.."Spell Damage    : "..damage.."\n\n"

	file:write(text.."")
	file:flush()
end,

swingDamageLog = function(player, target, damage)

	local dir, text = "../rtklua/History/logs/swing_log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text =       "-[Damage Out]-\n"
	text = text.."Date & Time     : "..os.date().."\n"
	text = text.."Target Name     : "..target.name.."\n"
	text = text.."Target Armor    : "..target.armor.."\n"
	text = text.."Swing Damage    : "..damage.."\n\n"

	file:write(text.."")
	file:flush()
end,


addGoldWrite = function(player, money)

	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date().."> ADDED GOLD: "..format_number(money).."  TOTAL GOLD: "..player.money.." | @"..player.mapTitle.." ("..player.m..")\n"
	
--	text =       "==== [Add Gold] ==================================================================\n"
--	text = text.."<"..os.date().."> \n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Gold Added	: "..format_number(money).."\n"
--	text = text.."Total Gold	: "..player.money.."\n\n"

	file:write(text.."")
	file:flush()

end,

removeGoldWrite = function(player, money)


	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	
	text = text.."<"..os.date().."> REMOVED GOLD: "..format_number(money).."  TOTAL GOLD: "..player.money.." | @"..player.mapTitle.." ("..player.m..")\n"
	
--	text =       "==== [Remove Gold] ==================================================================\n"
--	text = text.."Date & Time     : "..os.date().."\n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Gold Removed	: "..format_number(money).."\n"
--	text = text.."Total Gold	: "..player.money.."\n\n"

	file:write(text.."")
	file:flush()

end,

levelUpWrite = function(player, level)

	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	text = text.."<"..os.date().."> LEVELED UP TO: "..player.level.." | @"..player.mapTitle.." ("..player.m..")\n"
	
--	text =       "==== [Level Up] ==================================================================\n"
--	text = text.."Date & Time     : "..os.date().."\n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Level		: "..player.level.."\n\n"
	
	file:write(text.."")
	file:flush()
end,


pickUpWrite = function(player, item, amount)

	local pickup = ""

	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")
	
	if player.pickUpType == 0 then
		pickup = "Comma"
	elseif player.pickUpType == 1 then
		pickup = "Shift + Comma"
	elseif player.pickUpType == 3 then
		pickup = "Ctrl + Comma"
	end

	text = text.."<"..os.date().."> PICKED UP: "..amount.." "..item.name.." | @"..player.mapTitle.." ("..player.m..") | "..pickup.."\n"
	
--	text =       "==== [Item Pick Up] ==================================================================\n"
--	text = text.."Date & Time     : "..os.date().."\n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Pickup Type	: "..pickup.."\n"
--	text = text.."Item		: "..item.name.."\n"
--	text = text.."Amount		: "..amount.."\n\n"	

	file:write(text.."")
	file:flush()	


end,

dropWrite = function(player, item)

	local dir, text = "../rtklua/History/logs/log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")

	text = text.."<"..os.date().."> DROPPED: "..item.amount.." "..item.name.." | @"..player.mapTitle.." ("..player.m..")\n"
	
--	text =       "==== [Item Drop] ==================================================================\n"
--	text = text.."Date & Time     : "..os.date().."\n"
--	text = text.."Map		: "..player.mapTitle.."\n"
--	text = text.."Item		: "..item.name.."\n\n"

	file:write(text.."")
	file:flush()	


end,


deathPileLog = function(player)


	local dir, text = "../rtklua/History/logs/death/deathpile_log_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")

	text =       "\n==== [Death Pile] ==================================================================\n"
	text = text.."Player      : "..player.name.." (ID: "..player.ID..")\n"
	text = text.."Date & Time : "..os.date().."\n"
	text = text.."Location    : "..player.mapTitle.." ("..player.m..") | X: "..player.x.." Y: "..player.y.."\n"
	text = text.."Items       : \n"
	text = characterLog.getDeathPileItems(player, text)

	file:write(text.."")
	file:flush()	


end,

getDeathPileItems = function(player, text)

	local m, x, y = player.m, player.x, player.y

	local deathPile = player:getObjectsInCell(m, x, y, BL_ITEM)
	
	if #deathPile > 0 then
		for i = 1, #deathPile do
			if deathPile[i].cursed == player.ID then
				text = text..""..i..": "..deathPile[i].name.." ("..deathPile[i].amount..")\n"
			end
		end
	end
	
	return text

end,


lapisLogs = function(player, item, amount)

	local dir, text = "../rtklua/History/logs/lapis/lapis_log_"..player.name.."_"..os.date("%m.%d.%Y")..".txt", ""
	local file = io.open(dir, "a+")

	text =       "==== [Lapis Purchase] ==================================================================\n"
	text = text.."Date & Time     : "..os.date().."\n"
	text = text.."Map             : "..player.mapTitle.."\n"
	text = text.."Item            : "..item.name.."\n"
	text = text.."Amount          : "..amount.."\n"
	text = text.."Cost            : "..item.price.."\n"
	text = text.."Beginning Lapis : "..player.registry["last_lapis"].."\n"
	text = text.."Remaining Lapis : "..player.lapis.."\n\n"


	file:write(text.."")
	file:flush()	


end
}
