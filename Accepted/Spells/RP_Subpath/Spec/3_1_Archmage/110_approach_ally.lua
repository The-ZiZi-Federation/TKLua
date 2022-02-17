approach_ally = {
	on_learn = function(player)
		player.registry["learned_approach_ally"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_approach_ally"] = 0
	end,
	cast = function(player)
		local anim = 630
		local sound = 24
		local aether = 120000
		local magicCost = math.floor(player.maxMagic * 0.05)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		local closestMember
		local currentMember
		local groupMembers = player.group
		local destinationX
		local destinationY

		if #groupMembers > 1 then
			for i = 1, #groupMembers do
				currentMember = Player(groupMembers[i])
				if closestMember == nil then
					if groupMembers[i] ~= player.ID then
						closestMember = currentMember
					end
				else
					if groupMembers[i] ~= player.ID then
						if distance(player, currentMember) < distance(player, closestMember) then
							closestMember = currentMember
						end
					end
				end
			end
		end

		if distance(player, closestMember) > 8 then
			player:sendMinitext("Your allies are too far away!")
			return
		end
		--	Player(4):talk(0,"app "..closestMember.name)
		destinationX, destinationY = findOpenTileAround(closestMember)

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("approach_ally", aether)
		player:sendMinitext("You cast Approach Ally and teleport to " .. closestMember.name)
		player:warp(player.m, destinationX, destinationY)
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Approach ally brings you to the nearest group member", txt}
		return level, item, amounts, desc
	end
}
