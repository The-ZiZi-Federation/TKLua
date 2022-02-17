rest_lv4 = {
	on_learn = function(player)
		player.registry["learned_rest_lv4"] = 1
		player:removeSpell("rest_lv1")
		player:removeSpell("rest_lv2")
		player:removeSpell("rest_lv3")
		player:removeSpell("rest_lv5")
	end,
	on_forget = function(player)
		player.registry["learned_rest_lv4"] = 0
	end,
	cast = function(player)
		local aether = 17000
		local duration = 2500

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if player.state ~= 1 then
			player:setAether("rest_lv4", aether)
			player:playSound(84)
			player:sendMinitext("You start to Rest.")
			player:setDuration("rest_lv4", duration)
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
		player.magic = player.magic + (player.maxMagic * .9)
		player:sendStatus()
		player:updateState()
		player:calcStat()
		player:sendAction(10, 60)
		player:sendAnimation(117)
		player:playSound(67)
		player:sendMinitext("You feel well rested")
	end,
	requirements = function(player)
		local level = 110
		local item = {0, 8011, 8021}
		local amounts = {150000, 25, 20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Rest for a moment and regain even more Mana!\n\nReplaces Rest Lv3", txt}
		return level, item, amounts, desc
	end
}
