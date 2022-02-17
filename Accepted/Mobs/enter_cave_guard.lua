enter_cave_guard = {
	click = async(
		function(player, npc)
			local name
			local level, req, text = player.level, npc.look, npc.lookColor
			local mob = npc:getObjectsInMap(npc.m, BL_MOB)

			if #mob > 0 then
				for i = 1, #mob do
					if mob[i].mobID == 10000 then
						anim(player)
						pushBack(player)
						name = "<b>[" .. npc.name .. "]\n\n"

						if text == 1 then
							txt = "A powerful force repels you. You cannot enter while the guardian lives.\n"
						end

						player:popUp(name .. "" .. txt)
					end
				end
			end
		end
	)
}
