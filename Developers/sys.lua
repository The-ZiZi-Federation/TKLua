_errhandler = function(str)
	return debug.traceback(str)
end
minL = function(amount, limit)
	if amount < limit then
		return limit
	else
		return amount
	end
end
maxL = function(amount, limit)
	if (amount > limit) then
		return limit
	else
		return amount
	end
end

async = function(func)
	return function(player, ...)
		local args = {...}
		_async(
			player,
			function()
				func(player, unpack(args))
				_asyncDone(player)
			end
		)
	end
end

convertGraphic = function(value, class)
	if class == "monster" then
		return 128 * 256 + value
	elseif class == "item" then
		return 192 * 256 + value
	end

	return value
end

checkBoard = function(player)
	local del = player.registry["board" .. player.board .. "del"]
	local write = player.registry["board" .. player.board .. "write"]

	player.boardDel = del
	player.boardWrite = write
end

f1Block = NPC(F1_NPC)

instances = {}

advice = {
	"[INFO]: You can press 'o' on many objects to find items.",
	"[INFO]: Press 'B' to show Bulletin boards, & 'M' to show Mailbox.",
	"[INFO]: Have some extra gold to spend? Please visit the Hon Casino for a chance to win some serious gold.",
	"[INFO]: Press 'Crtl + R' to refresh your screen.",
	"[INFO]: You could sell your item by Vending System in the Market District.",
	"[INFO]: Any suggestions can be sent via Nmail to Peter or Jacob.",
	"[INFO]: Your legend is the history of your character from experiences to accomplishments and more.",
	"[INFO]: Press 'F1' to view Character Options, Quest Log, Cave Charts, Bestiary, and Spend SP.",
	"[INFO]: Be courteous and mindful to your fellow players and obey the laws.",
	"[INFO]: Specialization in your class will add new unique spells.",
	"[INFO]: Find a bug/error? Press 'b to open boards and post the issue on Bug Board.",
	"[INFO]: Need help? Send a whisper to '?' to request help from a Mentor."
}

core = NPC(4294967295)

second = realSecond()
minute = realMinute()
hour = realHour()
day = realDay()

f1Block = NPC(F1_NPC)

acPerArmor = 127 / 142462
armorPerAC = 142462 / 127

noHP = "Not Enough HP"
noMP = "Not Enough MP"
cant_do = "You cannot do that right now!"
already_cast = "Spell already cast!"
key = "intel2891"

getCurSeason = function()
	local season = "Fall"

	if curSeason() == 1 then
		return "Spring"
	end
	if curSeason() == 2 then
		return "Summer"
	end
	if curSeason() == 3 then
		return "Fall"
	end
	if curSeason() == 4 then
		return "Winter"
	end

	return season
end

secondsToClock = function(totalSeconds)
	local hours, minutes, seconds

	if totalSeconds == 0 then
		return "00:00:00"
	else
		hours = string.format("%02.f", math.floor(totalSeconds / 3600))
		minutes = string.format("%02.f", math.floor(totalSeconds / 60 - (hours * 60)))
		seconds = string.format("%02.f", math.floor(totalSeconds - hours * 3600 - minutes * 60))

		return hours .. ":" .. minutes .. ":" .. seconds
	end
end
