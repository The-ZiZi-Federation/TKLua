duel_request = {

click = function(player, npc)
	
	local sender = Player(player.registry["duel_req_from"])
	
	if sender == nil then
		if player:hasDuration("duel_request") then player:setDuration("duel_request", 0) end
	return else
		if player.m == sender.m then
			if sender.gfxClone == 0 then
				clone.equip(sender, npc)
			else
				clone.gfx(sender, npc)
			end
			npc.gfxClone = 1
			player.lastClick = npc.ID
			player.dialogType = 2
			local opts = {sender.name.."'s Info", "Accept", "Decline"}
			menu = player:menuString("<b>[Duel]\n\nYou have a duel request from "..sender.name.."!\n\nChoose your decision", opts)
			
			if menu ~= nil then
				if not player:hasDuration("duel_request") then
					player:msg(4, "[DUEL] This request is expired!", player.ID)
				return else
					if menu == sender.name.."'s Info" then
						characterInfo(player, sender)
					elseif menu == "Accept" then
						duel_request.accept(player, sender)
					elseif menu == "Decline" then
						player:setDuration("duel_request", 0)
					end
				end
			end
		end
	end
end,

while_cast_slow = function(player) end,
uncast = function(player)

	local sender = Player(player.registry["duel_req_from"])
	
	if sender ~= nil then
		sender:sendAnimation(246)
		player:msg(4, "[DUEL] "..player.name.." has decline your request !", sender.ID)
	end
end
}