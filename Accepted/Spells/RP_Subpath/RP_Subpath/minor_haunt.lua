minor_haunt = {
	on_learn = function(player)
		player.registry["learned_minor_haunt"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_minor_haunt"] = 0
	end,
	cast = function(player, target)
		local magicCost = 0
		local aether = 0
		local sound = 106

		local animations = {
			--		88,  --eyes
			--		96,  --ghost portal
			111, --black ghost
			145, --b+w snakes
			--		149, --demon spirit
			--		198, --shadow dragon
			291, --swirling ghosts
			294, --blue ghost swirl
			--		353, --white spirit face
			--		354, --black spirit face
			--		408, --falling skulls
			--		409, --falling bones
			503, --green ghost swirl
			--		547, --evil tree
			548, --swirling skulls
			--		549, --swirling white snakes
			550, --spooky spirit
			551, --spinning purple ghost skulls
			593, --spooky ghost girl walking behind you
			594, --spooky ghost girl standing behind you
			628 --finger of death
		}

		local randomAnim = animations[math.random(#animations)]

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target ~= nil then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:calcStat()
			player:sendStatus()
			player:sendMinitext("You cast Minor Haunt.")
			player:playSound(sound)
			target:sendAnimation(randomAnim)
			player:setAether("minor_haunt", aether)
			if target.blType == BL_PC and target.ID ~= player.ID then
				target:sendMinitext(player.name .. " sends a spirit to haunt you.")
			end
		end
	end,
	requirements = function(player)
		local level = 0
		local item = {0}
		local amounts = {25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Minor Haunt is a spell that sends a spirit to haunt your target.", txt}
		return level, item, amounts, desc
	end
}
