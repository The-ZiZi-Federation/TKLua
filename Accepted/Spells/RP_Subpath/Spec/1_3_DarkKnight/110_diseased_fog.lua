diseased_fog = {
	on_learn = function(player)
		player.registry["learned_diseased_fog"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_diseased_fog"] = 0
	end,
	cast = function(player)
		local mob = player:getObjectsInArea(BL_MOB)
		local pc = player:getObjectsInArea(BL_PC)

		local targets = {}
		local magicCost = 15000
		local duration = 8000
		local aether = 30000
		local anim = 139
		local sound = 715

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if #mob > 0 then
			for i = 1, #mob do
				if distanceSquare(player, mob[i], 1) then
					table.insert(targets, mob[i])
				end
			end
		end

		if #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(player, pc[i], 1) then
					if player:canPK(pc[i]) then
						table.insert(targets, pc[i])
					end
				end
			end
		end

		if #targets > 0 then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:playSound(sound)
			player:sendStatus()
			player:sendMinitext("You cast Diseased Fog.")
			player:setAether("diseased_fog", aether)
			for i = 1, #targets do
				targets[i]:sendAnimation(anim)
				targets[i]:setDuration("diseased_fog", duration)
				targets[i]:calcStat()
			end
		end
	end,
	recast = function(player)
		player.deduction = 1.1
		player.hit = player.hit - 1
	end,
	while_cast = function(block)
		local anim = 453

		if block.blType == BL_MOB then
			block.newMove = block.baseMove + 250
			block.newAttack = block.baseAttack + 250
		elseif block.blType == BL_PC then
			block.speed = 160
			--block.attackSpeed = 40
			block:updateState()
		end
		block:sendAnimation(anim)
	end,
	uncast = function(block)
		if block.blType == BL_MOB then
			block.newMove = block.baseMove
			block.newAttack = block.baseAttack
		elseif block.blType == BL_PC then
			block.speed = 80
			--block.attackSpeed = 20
			block:updateState()
		end
		block:calcStat()
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Spread a diseased fog to slow your enemies and reduce their armor and accuracy.", txt}
		return level, item, amounts, desc
	end
}
