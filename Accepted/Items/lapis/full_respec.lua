full_respec = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			player:removeItemSlot(player.invSlot, 1)

			player.registry["stat_points"] = 0
			player.registry["sp_spent"] = 0
			player.registry["sp_spent_might"] = 0
			player.registry["sp_spent_grace"] = 0
			player.registry["sp_spent_will"] = 0
			player.registry["sp_spent_armor"] = 0
			player.basearmor = 0
			player.basemight = 1
			player.basegrace = 1
			player.basewill = 1
			if player.registry["bonus_stat_points"] == 0 then
				player.registry["total_stat_points"] = player.level
			else
				player.registry["total_stat_points"] = player.level + player.registry["bonus_stat_points"]
			end
			player:sendMinitext("Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!")
			player:popUp("Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!")
			player:msg(
				4,
				"Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!",
				player.ID
			)
			player:calcStat()
			player:sendStatus()
		end
	end,
	respecPlayer = function(player)
		player.registry["stat_points"] = 0
		player.registry["sp_spent"] = 0
		player.registry["sp_spent_might"] = 0
		player.registry["sp_spent_grace"] = 0
		player.registry["sp_spent_will"] = 0
		player.registry["sp_spent_armor"] = 0
		player.basearmor = 0
		player.basemight = 1
		player.basegrace = 1
		player.basewill = 1
		if player.registry["bonus_stat_points"] == 0 then
			player.registry["total_stat_points"] = player.level
		else
			player.registry["total_stat_points"] = player.level + player.registry["bonus_stat_points"]
		end
		player:sendMinitext("Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!")
		player:popUp("Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!")
		player:msg(
			4,
			"Your base stats have been reset, your SP has been returned to you. Press F1 to spend your SP!",
			player.ID
		)
		player:calcStat()
		player:sendStatus()
	end
}
