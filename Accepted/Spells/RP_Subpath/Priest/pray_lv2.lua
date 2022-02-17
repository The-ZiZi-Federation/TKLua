pray_lv2 = {
	on_learn = function(player)
		player.registry["learned_pray_lv2"] = 1
		player:removeSpell("pray_lv1")
		player:removeSpell("pray_lv3")
		player:removeSpell("pray_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_pray_lv2"] = 0
	end,
	cast = function(player)
		local aether = 15000
		local duration = 2000

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if player.state ~= 1 then
			player:setAether("pray_lv2", aether)
			player:playSound(726)
			player:sendMinitext("You start to pray.")
			player:setDuration("pray_lv2", duration)
			player.paralyzed = true
		else
			player:sendMinitext("You can't pray if you're dead")
		end
	end,
	while_cast = function(player)
		player.paralyzed = true
		player:sendAction(6, 400)
		player:sendAnimation(133)
	end,
	uncast = function(player)
		player.paralyzed = false
		player.magic = player.magic + (player.maxMagic * .75)
		player:sendStatus()
		player:updateState()
		player:calcStat()
		player:sendAction(10, 60)
		player:sendAnimation(107)
		player:playSound(67)
		player:sendMinitext("You feel more holy")
	end,
	requirements = function(player)
		local level = 58
		local item = {0, 294, 295}
		local amounts = {2500, 25, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Upgrades your Pray spell, which recovers your mana!", txt}
		return level, item, amounts, desc
	end
}
