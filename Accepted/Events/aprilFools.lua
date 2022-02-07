aprilFools = {
	login = async(
		function(player, npc)
			local name = "<b>[MornaTK GM Team]\n\n"
			local t = {graphic = convertGraphic(1439, "monster"), color = 0}

			player:dialogSeq(
				{t, name .. "We hope you will all join us on our One-Year Anniversary Relaunch, coming April 11th!"},
				1
			)
		end
	)
}

--[[
	player:dialogSeq({t, name.."Welcome to MornaTK Beta 2.0!",
						name.."Is what I might be saying if it wasn't April Fool's Day.\nHowever...",
						name.."We hope you will all join us on our One-Year Anniversary Relaunch, coming April 11th!",
						name.."Relaunch Date will commence with sporadic Divine Light EXP bonus throughout the day."}, 1)
]] --
