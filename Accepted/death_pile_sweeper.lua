death_pile_sweeper = {
	--player:addNPC("death_pile_sweeper", m, x, y, 1000, 60000, player.ID)

	action = function(npc, owner)
		--owner:talk(0,""..npc.look)
		--npc.look = npc.look + 1
	end,
	endAction = function(npc, owner)
		local m, x, y = npc.m, npc.x, npc.y

		deathPile = npc:getObjectsInCell(m, x, y, BL_ITEM)

		for i = 1, #deathPile do
			if deathPile[i].cursed == owner.ID then
				deathPile[i].cursed = 0
			end
		end
		npc:delete()
		--Player(4):talk(0,"curse removed")
	end
}

--[[

sweep = function(npc)
has to summon npc with owner id of player id. 
timer of 15 minutes
at end of timer it checks map for all items owned by owner id.
All items found get curse = 0 on their items.
end action for all this good shit then it deletes itself.

What happens if the same player dies multiple times in a map, can this npc know
that it needs to set another timer or will it remove curse on all items

or does npc need a clause that says in the thing where it adds the npc it checks if one is already there
then it sends the npc a new timer protecting all of the owners items until this new timer 
wipes the curse and deletes itself...

I dunno, Arby's pretty cool.
]] --
