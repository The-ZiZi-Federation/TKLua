pray_lv4 = {
	on_learn = function(player)
		player.registry["learned_pray_lv4"] = 1
		player:removeSpell("pray_lv1")
		player:removeSpell("pray_lv2")
		player:removeSpell("pray_lv3")
	end,
	on_forget = function(player)
		player.registry["learned_pray_lv4"] = 0
	end,
	cast = function(player)
		local aether = 20000
		local duration = 3000

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if player.state ~= 1 then
			player:setAether("pray_lv4", aether)
			player:playSound(726)
			player:sendMinitext("You start to pray.")
			player:setDuration("pray_lv4", duration)
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
		player.magic = (player.maxMagic)
		player:sendStatus()
		player:updateState()
		player:calcStat()
		player:sendAction(10, 60)
		player:sendAnimation(107)
		player:playSound(67)
		player:sendMinitext("You feel more holy")
	end,
	requirements = function(player)
		local level = 110
		local item = {0, 8013, 8022, 8024}
		local amounts = {150000, 25, 15, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Upgrades your Pray spell, which recovers your mana.", txt}
		return level, item, amounts, desc
	end
}
