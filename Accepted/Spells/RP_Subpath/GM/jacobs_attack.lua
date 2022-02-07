jacobs_attack = {
	cast = function(player, target)
		if target.blType == BL_MOB then
			target:sendAnimation(153)
			player:sendMinitext("You kill your target")
			target.attacker = player.ID
			target:removeHealthExtend(999999999, 1, 1, 1, 1, 0)
		else
			player:sendMinitext("This attack can't be used to harm players!")
		end
	end
}
