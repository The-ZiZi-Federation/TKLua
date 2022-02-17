lupus_jailer = {
	click = async(
		function(player, npc)
			local name = "<b>[JAIL GUARD]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			if player.registry["jailed"] >= 1 then
				table.insert(opts, "Why am I here?")
			end

			menu =
				player:menuString(name .. "Well La-di-da. Hey Big Shot! Landed yourself in quite the mess. Haven't you?", opts)

			if menu == "Why am I here?" then
				player:dialogSeq(
					{
						t,
						name .. "You are here because you acted, in some manner, like an Ass Hat!",
						name .. "Now I have to smell your Dirty, Good for Nothing, Self until your time has passed?"
					},
					1
				)
				duration = 3600000
				player:setDuration("jailed_for_botting", duration)
			end
		end
	)
}
