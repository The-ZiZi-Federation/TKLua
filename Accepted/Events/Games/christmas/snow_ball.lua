snow_ball = {
	pick = function(player)
		local tile = {
			30451,
			30478,
			30474,
			30479,
			30483,
			30477,
			30475,
			30482,
			30480,
			30476,
			30481,
			30473,
			30471,
			30484,
			30472,
			30485,
			30470,
			30538,
			30380,
			30449
		}

		for i = 1, #tile do
			if getTile(player.m, player.x, player.y) == tile[i] then
				if player.registry["pick_snow"] == 0 then
					if player.gfxClone == 0 then
						clone.equip(player, player)
					else
						clone.gfx(player, player)
					end
					player.gfxWeap = 276
					player.gfxWeapC = 17
					player.gfxClone = 1
					player.registry["pick_snow"] = 1
					player:updateState()
				end
			end
		end
	end
}
