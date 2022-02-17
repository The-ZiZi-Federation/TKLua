-- Priest first Set it forget it heal. Lv1

healing_aura = {
	on_learn = function(player)
		player.registry["learned_healing_aura"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_healing_aura"] = 0
	end,
	cast = function(player)
		local duration = 15000
		local magicCost = ((player.level * 15) + (player.maxMagic / 15))
		local aether = 45000
		local sound = 19

		------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		---------------------------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		---------------------------------------------------
		player:setAether("healing_aura", aether)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		----------------------------------------------------------
		for i = 1, #player.group do
			if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m) then
				if distanceSquare(player, Player(player.group[i]), 8) then
					if Player(player.group[i]):hasDuration("healing_aura") then
						Player(player.group[i]):setDuration("healing_aura", 0)
						Player(player.group[i]):sendStatus()
						Player(player.group[i]):sendAnimation(132, 0)
						Player(player.group[i]).registry["healing_aura"] = player.ID
						Player(player.group[i]):setDuration("healing_aura", duration)
						if Player(player.group[i]).ID ~= player.ID then
							Player(player.group[i]):sendMinitext("You are in " .. player.name .. "'s Healing Aura")
						else
							Player(player.group[i]):sendMinitext("You cast Healing Aura")
						end
					else
						--	player:sendMinitext("Cast Healing Aura 2")
						Player(player.group[i]):sendStatus()
						Player(player.group[i]):sendAnimation(132, 0)
						Player(player.group[i]).registry["healing_aura"] = player.ID
						Player(player.group[i]):setDuration("healing_aura", duration)
						if Player(player.group[i]).ID ~= player.ID then
							Player(player.group[i]):sendMinitext("You are in " .. player.name .. "'s Healing Aura")
						else
							Player(player.group[i]):sendMinitext("You cast Healing Aura")
						end
					end
				end
			end
		end
	end,
	while_cast = function(player)
		local user = Player(player.registry["healing_aura"])

		local healAmount = (player.level * 3) + (player.maxHealth / 25)
		local duration = player:getDuration("healing_aura")
		local timeLeft
		local anim = 132
		local currentPlayer

		if player.state == 1 or player.health <= 0 then
			return
		end

		player:sendAnimation(anim)
		player:addHealth(healAmount)
		--		player:sendStatus()
	end,
	uncast = function(player)
		--if player.m == 3999 then player:talk(0,""..player.name.." uncast")	end
		player.registry["healing_aura"] = 0
		--	player:sendMinitext("You are no longer in a Healing Aura")
		--	player:calcStat()
	end,
	requirements = function(player)
		local level = 34
		local item = {0, 293, 388}
		local amounts = {700, 1, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Nearby group members are bathed in a holy aura that restores health over time.", txt}
		return level, item, amounts, desc
	end
}
