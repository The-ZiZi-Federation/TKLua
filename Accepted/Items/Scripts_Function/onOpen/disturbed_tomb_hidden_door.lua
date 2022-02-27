disturbed_tomb_hidden_stairs = {

flipSwitches = function(player)

	local map = player.m
	local facingObj, facingX, facingY = getObjFacingXY(player,player.side)
	local leftObj, leftX, leftY = getLeftObjFacing(player,player.side)
	local rightObj, rightX, rightY = getRightObjFacing(player,player.side)
	local x, y = player.x, player.y
	local skull = 0
	
	local obj = {getObject(map, 32, 2),
				getObject(map, 33, 2),
				getObject(map, 34, 2),
				getObject(map, 35, 2),
				getObject(map, 36, 2),
				getObject(map, 37, 2),
				getObject(map, 38, 2)}
				
	for i = 1, #obj do
		if obj[i] == 16609 then
			skull = skull + 1
		end
	end

	if skull == 7 then
		disturbed_tomb_hidden_stairs.resetPuzzle()	
	end
	
	if facingObj == 16605 then
		setObject(map, facingX, facingY, 16609)
	elseif facingObj == 16609 then
		setObject(map, facingX, facingY, 16605)
	end
	
	if leftObj == 16605 then
		setObject(map, leftX, leftY, 16609)
	elseif leftObj == 16609 then
		setObject(map, leftX, leftY, 16605)
	end
	
	if rightObj == 16605 then
		setObject(map, rightX, rightY, 16609)
	elseif rightObj == 16609 then
		setObject(map, rightX, rightY, 16605)
	end

	disturbed_tomb_hidden_stairs.checkPuzzle()
	
end,


checkPuzzle = function()

	local map = 2100
	local skull = 0

	local obj = {getObject(map, 32, 2),
				getObject(map, 33, 2),
				getObject(map, 34, 2),
				getObject(map, 35, 2),
				getObject(map, 36, 2),
				getObject(map, 37, 2),
				getObject(map, 38, 2)}
	
	for i = 1, #obj do
		if obj[i] == 16609 then
			skull = skull + 1
		end
	end

	if skull == 7 then
		disturbed_tomb_hidden_stairs.revealStairs()
		--puzzle solved
	end

end,

revealStairs = function()
	
	local map = 2100
	
	setTile(map, 43, 12, 1713)

	setObject(map, 43, 12, 0)
	setObject(map, 44, 12, 13539)
	setObject(map, 45, 12, 13540)
	
	setPass(map, 43, 12, 0)
	setPass(map, 45, 12, 1)
	
	core:addNPC("disturbed_tomb_hidden_stairs", map, 43, 12, 1000, 300000, core.ID)
	
	broadcast(2100, "**A horrible scraping sound fills your ears**")
	
	core.gameRegistry["disturbed_tomb_hidden_stairs"] = os.time()+300

end,

resetPuzzle = function()

	local map = 2100
	
	setObject(map, 32, 2, 16605)
	setObject(map, 33, 2, 16609)
	setObject(map, 34, 2, 16605)
	setObject(map, 35, 2, 16609)
	setObject(map, 36, 2, 16605)
	setObject(map, 37, 2, 16609)
	setObject(map, 38, 2, 16605)
	

	setObject(map, 43, 12, 13539)
	setObject(map, 44, 12, 13540)
	setObject(map, 45, 12, 0)
	
	setTile(map, 43, 12, 4420)
	
	setPass(map, 43, 12, 1)
	setPass(map, 45, 12, 0)


end,

auto = function()
	
	local timer = core.gameRegistry["disturbed_tomb_hidden_stairs"]

	if timer > 0 and timer < os.time() then
		disturbed_tomb_hidden_stairs.resetPuzzle()
		core.gameRegistry["disturbed_tomb_hidden_stairs"] = 0
	end
	
end,

click = async(function(player, npc)

	local m = 2101
	local x = 1
	local y = 9

	if player.blType ~= BL_PC then return end
	
	player:warp(m, x, y)
	
end
),

endAction = function(npc)
	npc:delete()	
end
}