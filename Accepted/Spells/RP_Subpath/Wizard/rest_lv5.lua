rest_lv5 = {
	on_learn = function(player)
		player.registry["learned_rest_lv5"] = 1
		player:removeSpell("rest_lv1")
		player:removeSpell("rest_lv2")
		player:removeSpell("rest_lv3")
		player:removeSpell("rest_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_rest_lv5"] = 0
	end,
	cast = function(player)
		local aether = 20000
		local duration = 3000

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if player.state ~= 1 then
			player:setAether("rest_lv5", aether)
			player:playSound(84)
			player:sendMinitext("You start to Rest.")
			player:setDuration("rest_lv5", duration)
			player.paralyzed = true
		else
			player:sendMinitext("You can't rest if you're dead")
		end
	end,
	while_cast = function(player)
		player.paralyzed = true
		player:sendAction(16, 400)
		player:sendAnimation(133)
	end,
	uncast = function(player)
		player:unlock()
		player.paralyzed = false
		player.magic = player.maxMagic
		player:sendStatus()
		player:updateState()
		player:calcStat()
		player:sendAction(10, 60)
		player:sendAnimation(117)
		player:playSound(67)
		player:sendMinitext("You feel well rested")
	end,
	requirements = function(player)
		local level = 200
		local item = {0}
		local amounts = {250000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Rest for a moment and regain even more Mana!\n\nReplaces Rest Lv4", txt}
		return level, item, amounts, desc
	end
}
