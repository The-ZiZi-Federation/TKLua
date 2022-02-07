xmasLegendFix = {
	removeLegend = function(player)
		if player:hasLegend("xmasgood2016") then
			player:removeLegendbyName("xmasgood2016")
			player.registry["removed_xmas_legend_1"] = 1
		elseif player:hasLegend("xmasevil2016") then
			player:removeLegendbyName("xmasevil2016")
			player.registry["removed_xmas_legend_2"] = 1
		elseif player:hasLegend("xmasneutral2016") then
			player:removeLegendbyName("xmasneutral2016")
			player.registry["removed_xmas_legend_3"] = 1
		end
	end,
	readdLegend = function(player)
		if player.registry["removed_xmas_legend_1"] == 1 then
			player:addLegend("Helped Ernest Save Christmas", "xmasgood2016", 211, 15)
			player.registry["removed_xmas_legend_1"] = 0
		elseif player.registry["removed_xmas_legend_2"] == 1 then
			player:addLegend("Worked Against Ernest to Snuff Out the Magic of Christmas", "xmasevil2016", 211, 12)
			player.registry["removed_xmas_legend_2"] = 0
		elseif player.registry["removed_xmas_legend_3"] == 1 then
			player:addLegend("Stole a Present from Santa's Magic Sack", "xmasneutral2016", 211, 9)
			player.registry["removed_xmas_legend_3"] = 0
		end
	end
}
