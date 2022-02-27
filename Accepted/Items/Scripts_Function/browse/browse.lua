

--------- Browse Face acc 2 ------------------------------------------------------------------------------------

faceacc = {

browse = function(player, cmd)

	if cmd == "face2" or cmd == "nface2" or cmd == "pface2" then
		if cmd == "nface2" then
			if player.faceAccessoryTwo >= 46 then
				player:sendMinitext("You reached the maximal number of FaceAccTwo's look #46")
			return else
				player.faceAccessoryTwo = player.faceAccessoryTwo + 1
			end
		elseif cmd == "pface2" then
			if player.faceAccessoryTwo <= 0 then
				player:sendMinitext("You at the last of FaceAccTwo's look #0")
			return else
				player.faceAccessoryTwo = player.faceAccessoryTwo - 1
			end
		end
		player:sendMinitext("FaceAccTwo : "..player.faceAccessoryTwo)
	elseif cmd == "face2c" or cmd == "nface2c" or cmd == "pface2c" then
		if cmd == "nface2c" then
			player.faceAccessoryTwoColor = player.faceAccessoryTwoColor + 1
		elseif cmd == "pface2c" then
			if player.faceAccessoryTwoColor <= 0 then
				player:sendMinitext("You at the last of FaceAccTwo's color #0")
			return else
				player.faceAccessoryTwoColor = player.faceAccessoryTwoColor - 1
			end
		end
		player:sendMinitext("FaceAccTwoC : "..player.faceAccessoryTwoColor)
	end
	player:updateState()
end
}
--------- Browse Object ----------------------------------------------------------------------------------------

object = {

setFacingObject = function(player, set, obj)
	
	local o
	local side = player.side
	
	if set == "set" then
		if side == 0 then
			setObject(player.m, player.x, player.y - 1, obj)
			o = getObject(player.m, player.x, player.y - 1)
		elseif side == 1 then
			setObject(player.m, player.x + 1, player.y, obj)
			o = getObject(player.m, player.x + 1, player.y)
		elseif side == 2 then
			setObject(player.m, player.x, player.y + 1, obj)
			o = getObject(player.m, player.x, player.y + 1)
		elseif side == 3 then
			setObject(player.m, player.x - 1, player.y, obj)
			o = getObject(player.m, player.x - 1, player.y)
		end
		player:sendMinitext("Object #: "..o)
		return
	elseif set == "del" then
		if side == 0 then
			setObject(player.m, player.x, player.y - 1, 0)
		elseif side == 1 then
			setObject(player.m, player.x + 1, player.y, 0)
		elseif side == 2 then
			setObject(player.m, player.x, player.y + 1, 0)
		elseif side == 3 then
			setObject(player.m, player.x - 1, player.y, 0)
		end
	end
end,

getObject = function(player)
	
	local o
	local side = player.side
	
	if side == 0 then
		o = getObject(player.m, player.x, player.y - 1)
	elseif side == 1 then
		o = getObject(player.m, player.x + 1, player.y)
	elseif side == 2 then
		o = getObject(player.m, player.x, player.y + 1)
	elseif side == 3 then
		o = getObject(player.m, player.x - 1, player.y)
	end
	
	return player:talk(0, "Object #: "..o)
end,


next_prev = function(player, type)
	
	local p = player
	local o
	if player.side == 0 then
		o = getObject(p.m, p.x, p.y-1)
	elseif player.side == 1 then
		o = getObject(p.m, p.x+1, p.y)
	elseif player.side == 2 then
		o = getObject(p.m, p.x, p.y+1)
	elseif player.side == 3 then
		o = getObject(p.m, p.x-1, p.y)
	end
	if type == "next" and o == 18527 then player:sendMinitext("You are at the last object : 18527") return end
	if type == "prev" and o == 0 then player:sendMinitext("You are at the first object: 0") return end
	if player.side == 0 then
		if type == "next" then
			setObject(p.m, p.x, p.y-1, o+1)
		elseif type == "prev" then
			setObject(p.m, p.x, p.y-1, o-1)
		end
	elseif player.side == 1 then
		if type == "next" then
			setObject(p.m, p.x+1, p.y, o+1)
		elseif type == "prev" then
			setObject(p.m, p.x+1, p.y, o-1)
		end
	elseif player.side == 2 then
		if type == "next" then
			setObject(p.m, p.x, p.y+1, o+1)
		elseif type == "prev" then
			setObject(p.m, p.x, p.y+1, o-1)
		end
	elseif player.side == 3 then
		if type == "next" then
			setObject(p.m, p.x-1, p.y, o+1)
		elseif type == "prev" then
			setObject(p.m, p.x-1, p.y, o-1)
		end
	end
	player:sendMinitext("Obj : "..o)
	return
end
}