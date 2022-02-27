enter_cave = {

click = async(function(player, npc)
	
	local name
	local level, req, text = player.level, npc.look, npc.lookColor

	if level < req then
		anim(player)
		pushBack(player)
		
		name = "<b>["..npc.name.."]\n\n"
		
		if text == 0 or text == 1 then
			txt = "You get chills and goosebumps just standing near the door. You know you shouldn't be here.\n"
			
		elseif text == 2 then
			txt = "You see wild animals far away. You realize you are much weaker than them.\n"
		elseif text == 3 then
			txt = "Your lack of knowledge about this place prevents your body from going further.\n"
		elseif text == 4 then
			txt = "You see creatures inside, they seem to be stronger than you.\n"
		elseif text == 5 then
			txt = "The creatures inside make a threatening growl.\n\nThey're not intimidated by your presence. You should leave for your own safety.\n"
		elseif text == 6 then
			txt = "Your conscious gets the better of you. You know that you are too weak to face whatever is inside.\n"
		elseif text == 7 then
			txt = "A powerful force repels you. You cannot enter while the guardian lives.\n"
		end
		
		player:popUp(name..""..txt)
	end
end)
}