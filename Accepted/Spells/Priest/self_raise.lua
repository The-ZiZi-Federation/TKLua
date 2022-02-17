--Priest self raise
self_raise = {
	on_learn = function(player)
		player.registry["learned_self_raise"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_self_raise"] = 0
	end,
	cast = function(player)
		local sound = 17
		local anim = 96
		local aether = 1800000
		local magicCost = (player.maxMagic * 0.6)
		if magicCost > 1000000 then
			magicCost = 1000000
		end

		if (player.magic < magicCost) then
			notEnoughMP(player)
			return
		end

		if player.state == 1 then
			player:sendAction(6, 20)
			player:sendAnimation(anim)
			player:playSound(sound)
			player.state = 0
			player:updateState()
			player.health = player.maxHealth * 0.05
			player:sendStatus()
			player:sendMinitext("You will yourself back to life!")
			player:setAether("self_raise", aether)
		else
			player:sendMinitext("Want me to kill you to make this work?")
		end
	end,
	requirements = function(player)
		local level = 90
		local item = {0, 424, 423}
		local amounts = {100000, 10, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Bring yourself back to the land of the living.", txt}
		return level, item, amounts, desc
	end
}
