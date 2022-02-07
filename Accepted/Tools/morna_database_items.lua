morna_database_items = {
	click = function(player, npc)
		local name = "<b>[Database Items]\n\n"
		if player.gfxClone == 0 then
			clone.equip(player, npc)
		else
			clone.gfx(player, npc)
		end
		player.lastClick = npc.ID
		player.dialogType = 2

		local category = {}
		local items = {}
		local opts = {}
		table.insert(opts, "Start")
		table.insert(opts, "Fighter")
		table.insert(opts, "Scoundrel")
		table.insert(opts, "Wizard")
		table.insert(opts, "Priest")

		menu = player:menuString(name .. "Which item do you want to browse?", opts)

		if menu ~= nil then
			table.insert(category, "Potions")
			table.insert(category, "Start")
			table.insert(category, "Game")
			table.insert(category, "Craft")
			table.insert(category, "Weapon")
			table.insert(category, "Armor")
			table.insert(category, "Shield")
			table.insert(category, "Helmet")
			table.insert(category, "Hand Items")
			table.insert(category, "Boots")
			table.insert(category, "Cape")
			table.insert(category, "Sub Acc")
			table.insert(category, "Others")
			table.insert(category, "Spec")
			table.insert(category, "Spec Quest")
			table.insert(category, "Helper")

			categoryMenu = player:menuString("<b>[" .. menu .. "]\n\nSelect items category.", category)

			if categoryMenu ~= nil then
				items = morna_database_items.getMornaItems(menu, categoryMenu)

				if #items > 0 then
					player:buyExtend("<b>[" .. menu .. "]\n\n" .. categoryMenu, items)
				end
			end
		end
	end,
	getMornaItems = function(type, category)
		local type, category = string.lower(type), string.lower(category)
		local x, y, t = 0, 0, 100

		local id, name, icon = {}, {}, {}

		if category == "potions" then
			x, y, t = 124, 133, 0
		elseif category == "start" then
			x, y, t = 202, 439, 0
		elseif category == "game" then
			x, y, t = 700, 778, 0
		elseif category == "craft" then
			x, y, t = 800, 838, 0
		elseif category == "weapon" then
			t = 3
			if type == "fighter" then
				x, y = 16001, 16011
			elseif type == "scoundrel" then
				x, y = 17001, 17010
			elseif type == "wizard" then
				x, y = 18001, 18010
			elseif type == "priest" then
				x, y = 19101, 19010
			end
		elseif category == "armor" then
			t = 4
			if type == "fighter" then
				x, y = 16101, 16136
			elseif type == "scoundrel" then
				x, y = 17101, 17136
			elseif type == "wizard" then
				x, y = 18101, 18136
			elseif type == "priest" then
				x, y = 19101, 19136
			end
		elseif category == "shield" then
			t = 5
			if type == "fighter" then
				x, y = 16201, 16210
			elseif type == "scoundrel" then
				x, y = 17201, 17210
			elseif type == "wizard" then
				x, y = 18201, 18210
			elseif type == "priest" then
				x, y = 19201, 19210
			end
		elseif category == "helmet" then
			t = 6
			if type == "fighter" then
				x, y = 16301, 16310
			elseif type == "scoundrel" then
				x, y = 17301, 17310
			elseif type == "wizard" then
				x, y = 18301, 18310
			elseif type == "priest" then
				x, y = 19301, 19310
			end
		elseif category == "hand items" then
			t = 7
			if type == "fighter" then
				x, y = 16401, 16410
			elseif type == "scoundrel" then
				x, y = 17401, 17410
			elseif type == "wizard" then
				x, y = 18401, 18410
			elseif type == "priest" then
				x, y = 19401, 19410
			end
		elseif category == "sub acc" then
			t = 9
			if type == "fighter" then
				x, y = 16501, 16510
			elseif type == "scoundrel" then
				x, y = 17501, 17510
			elseif type == "wizard" then
				x, y = 18501, 18510
			elseif type == "priest" then
				x, y = 19501, 19510
			end
		elseif category == "cape" then
			t = 9
			if type == "fighter" then
				x, y = 16601, 16610
			elseif type == "scoundrel" then
				x, y = 17601, 17610
			elseif type == "wizard" then
				x, y = 18601, 18610
			elseif type == "priest" then
				x, y = 19601, 19610
			end
		elseif category == "boots" then
			t = 15
			if type == "fighter" then
				x, y = 16701, 16710
			elseif type == "scoundrel" then
				x, y = 17701, 17710
			elseif type == "wizard" then
				x, y = 18701, 18710
			elseif type == "priest" then
				x, y = 19701, 19710
			end
		elseif category == "others" then
			t = 18
			if type == "fighter" then
				x, y = 16801, 16810
			elseif type == "scoundrel" then
				x, y = 17801, 17810
			elseif type == "wizard" then
				x, y = 18801, 18810
			elseif type == "priest" then
				x, y = 19801, 19810
			end
		elseif category == "spec" then
			x, y = 2000, 2115, 0
		elseif category == "spec quest" then
			x, y = 2401, 2416, 0
		elseif category == "helper" then
			x, y = 100001, 100100, 0
		end

		if x > 0 and y > 0 then
			for i = x, y do
				if Item(i).icon > 0 and Item(i).type == t then
					if Item(i).yname ~= nil and Item(i).name ~= nil then
						table.insert(id, i)
						table.insert(name, Item(i).name)
						table.insert(icon, Item(i).icon - 49152)
					end
				end
			end
		end

		return id
	end
}
