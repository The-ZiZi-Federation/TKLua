

addWarp = {

cast = function(player, question)
	
	local type = tonumber(player.question)
	local path = "C:\Users\psikotic\Desktop\Start up nexus client\Main Folder\endOfNexusMaps\Accepted\warps.txt"
	local file = io.open(path, "a+")
	
	local add,text,new = "\n","","\n"
	local id = 0
	
	if type > 2 then
		player:msg(4, "Number 1 For insert 'From' coords", player.ID)
		player:msg(4, "Number 2 For insert 'To' coords", player.ID)
		player:msg(4, "---------------------------------", player.ID)
		player:sendAnimation(246)
	return else
		if file == nil then
			player:sendMinitext("Warps.txt file not found!")
		return else
			if type == 1 then text = "From"
				add = add..""..player.m..",	"..player.x..",	"..player.y..",	"..new
			elseif type == 2 then text = "To"
				add = add..""..player.m..",	"..player.x..",	"..player.y..""..new -- at end here, for next line.
			end
			if string.len(add) >= 1 then
				file:write(add)
				file:flush()
				if type == 1 then id = 228 elseif type == 2 then id = 235 end
				player:sendAnimationXY(id, player.x, player.y)
				player:msg(4, "[Warp Tool] Insert coordinate into warps.txt ("..add..") '"..text.."'", player.ID)
			end
		end
	end
end
}
-- dont know if it will works. kwkww
-- should there be a return key stroke

		
-- no. 
-- so , this is a spell with type = 1 (asking a question to player before it casted)
-- input num = 1 , the spell will insert coord on caster -> mapid,	x,	y,
-- input num = 2 , the spell will insert coord on caster -> mapid,	x,	y		--> whithout comma.
-- well, i still use a manual in working this. 
-- let try. you'll understand later.

-- we even not input data in magics eys