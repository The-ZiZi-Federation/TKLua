custom_mob = {
	getType = function(num)
		if num == 0 then
			return "Passive"
		end
		if num == 1 then
			return "Aggressive"
		end
		if num == 2 then
			return "Stationary"
		end
	end,
	cast = function(player)
		player:sendAction(6, 20)
		player:freeAsync()
		custom_mob.click(player, core)
	end,
	click = async(
		function(player, npc)
			player.npcGraphic = 0
			player.npcColor = 0
			player.dialogType = 0

			local target = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
			local health, minDam, maxDam, xp, total, look =
				player.registry["custom_mob_health"],
				player.registry["custom_mob_min"],
				player.registry["custom_mob_max"],
				player.registry["custom_mob_exp"],
				player.registry["custom_mob_total"],
				player.registry["custom_mob_look"]
			local hp, dam1, dam2, xp2, amount = 0, 0, 0, 0, 0
			local id = 2000023

			if total == 0 then
				player.registry["custom_mob_total"] = 1
			end
			if health == 0 then
				player.registry["custom_mob_health"] = 1
			end
			if minDam == 0 then
				player.registry["custom_mob_min"] = 1
			end
			if maxDam == 0 then
				player.registry["custom_mob_max"] = 1
			end
			if xp == 0 then
				player.registry["custom_mob_exp"] = 1
			end
			if look == 0 then
				player.registry["custom_mob_look"] = 1
			end

			local opts = {}
			table.insert(opts, "Type       : " .. custom_mob.getType(player.registry["custom_mob_type"]))
			table.insert(opts, "Look       : " .. player.registry["custom_mob_look"])
			table.insert(opts, "Health     : " .. player.registry["custom_mob_health"])
			table.insert(opts, "minDamage  : " .. player.registry["custom_mob_min"])
			table.insert(opts, "maxDamage  : " .. player.registry["custom_mob_max"])
			table.insert(opts, "Experience : " .. player.registry["custom_mob_exp"])
			table.insert(opts, "Total      : " .. player.registry["custom_mob_total"])
			table.insert(opts, "Spawn it!")

			menu = player:menuString("Input mob's status", opts)

			if menu == "Look       : " .. player.registry["custom_mob_look"] then
				custom_mob.change(player, npc, "Look")
				return
			elseif menu == "Health     : " .. player.registry["custom_mob_health"] then
				custom_mob.change(player, npc, "Health")
				return
			elseif menu == "minDamage  : " .. player.registry["custom_mob_min"] then
				custom_mob.change(player, npc, "minDam")
				return
			elseif menu == "maxDamage  : " .. player.registry["custom_mob_max"] then
				custom_mob.change(player, npc, "maxDam")
				return
			elseif menu == "Experience : " .. player.registry["custom_mob_exp"] then
				custom_mob.change(player, npc, "Exp")
				return
			elseif menu == "Total      : " .. player.registry["custom_mob_total"] then
				custom_mob.change(player, npc, "Total")
				return
			elseif menu == "Type       : " .. custom_mob.getType(player.registry["custom_mob_type"]) then
				type = player:menuSeq("<b>[Custom Mob]\n\nMobs Type to spawn", {"Passive", "Aggressive", "Stationary"}, {})
				player.registry["custom_mob_type"] = type - 1
				player:freeAsync()
				custom_mob.click(player, npc)
				return
			elseif menu == "Spawn it!" then
				if player.registry["custom_mob_total"] > 0 then
					player:spawn(id, player.x, player.y, total)

					local mob = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)

					if #mob > 0 then
						for i = 1, #mob do
							if mob[i].mobID == id then
								mob[i].look = player.registry["custom_mob_look"]
								mob[i].maxHealth = player.registry["custom_mob_health"]
								mob[i].health = mob[i].maxHealth
								mob[i].minDam = player.registry["custom_mob_min"]
								mob[i].maxDam = player.registry["custom_mob_max"]
								mob[i].aiType = player.registry["custom_mob_type"]
								player:refresh()
								mob[i]:talk(2, "HP: " .. mob[i].maxHealth .. ", minDam:" .. mob[i].minDam .. ", maxDam:" .. mob[i].maxDam .. "")
							end
						end
					end
				end
				return
			end
		end
	),
	change = function(player, npc, type)
		local type = string.lower(type)

		if type == "total" then
			input = math.abs(math.floor(player:input("How many mob you want to spawn?")))
			if input > 0 then
				player.registry["custom_mob_total"] = input
				player:sendMinitext("Done!")
				player:freeAsync()
				custom_mob.click(player, npc)
			end
			return
		else
			input = math.abs(math.floor(player:input("" .. type .. " : ")))
			if input ~= nil then
				if type == "look" then
					player.registry["custom_mob_look"] = input
				elseif type == "health" then
					player.registry["custom_mob_health"] = input
				elseif type == "mindam" then
					player.registry["custom_mob_min"] = input
				elseif type == "maxdam" then
					player.registry["custom_mob_max"] = input
				elseif type == "exp" then
					player.registry["custom_mob_exp"] = input
				elseif type == "amount" then
					player.registry["custom_mob_total"] = input
				end
				player:sendMinitext("" .. type .. ": " .. format_number(input))
				player:freeAsync()
				custom_mob.click(player, npc)
			end
		end
	end
}
