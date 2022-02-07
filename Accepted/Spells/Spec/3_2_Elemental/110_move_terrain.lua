move_terrain = {
	on_learn = function(player)
		player.registry["learned_move_terrain"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_move_terrain"] = 0
	end,
	cast = function(player, target)
		local pm, px, py = player.m, player.x, player.y
		local tm, tx, ty = target.m, target.x, target.y
		local anim = 156
		local sound = 59
		local aether = 120000
		local magicCost = math.floor(player.maxMagic * 0.025)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target.blType ~= BL_MOB or target.owner > 0 then
			invalidTarget(player)
			return
		end
		if distance(player, target) > 8 then
			player:sendMinitext("Your target is too far away!")
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("move_terrain", aether)

		player:sendAnimationXY(anim, px, py)
		player:warp(tm, tx, ty)
		target:sendAnimationXY(anim, tx, ty)
		target:warp(pm, px, py)
		player:sendMinitext("You cast Move Terrain and switch places with " .. target.name)
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Move the Earth and swap positions with an enemy.", txt}
		return level, item, amounts, desc
	end
}
