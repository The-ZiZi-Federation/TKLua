soothe = {
	on_learn = function(player)
		player.registry["learned_soothe"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_soothe"] = 0
	end,
	cast = function(player)
		local heal = 50
		local magicCost = 3

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(5)
		player:playSound(708)
		addHealth(player, heal)
		player:sendMinitext("You cast Soothe")
	end,
	requirements = function(player)
		txt = "- 70 Chesnut \n"
		txt = txt .. "- 30 Coins \n"

		local level = 10
		local item = {43, 0}
		local amounts = {70, 30}
		local desc = {"Heal a very small of  health", "To learn this spell you must to sacriface\n" .. txt .. ""}
		return level, item, amounts, desc
	end
}
