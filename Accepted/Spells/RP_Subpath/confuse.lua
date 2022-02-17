confuse = {
	cast = function(player, target)
		local mob1 = core:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
		local mob2 = core:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
		local mob3 = core:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)
		local mob4 = core:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
		local mobT = getTargetFacing(target, BL_MOB)
		--Player(4):talk(0,"target: "..target.ID)
		--Player(4):talk(0,"owner: "..target.owner)

		if target.owner > 0 then
			player:sendMinitext("Cant confuse!")
			failureAnim(target)
			return
		end

		target:sendAnimation(1)

		if mobT ~= nil then
			confuse.castEffects(player, target)
			target.target = mobT.ID
		elseif #mob1 > 0 then
			confuse.castEffects(player, target)
			target.target = mob1[1].ID
		elseif #mob2 > 0 then
			confuse.castEffects(player, target)
			target.target = mob2[1].ID
		elseif #mob3 > 0 then
			confuse.castEffects(player, target)
			target.target = mob3[1].ID
		elseif #mob4 > 0 then
			confuse.castEffects(player, target)
			target.target = mob4[1].ID
		end
		--target:talk(2,"owner: "..target.owner)
		--target:talk(2,"target: "..target.target)
	end,
	while_cast = function(mob)
		mob:sendAnimation(1)
		mob.owner = mob.registry["owner"]
	end,
	uncast = function(mob)
		mob.owner = 0
		mob.registry["owner"] = 0
	end,
	castEffects = function(caster, block)
		local duration = 10000

		block:setDuration("confuse", duration)
		block.registry["owner"] = caster.ID
		block.owner = caster.ID
	end
}
