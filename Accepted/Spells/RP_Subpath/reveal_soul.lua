reveal_soul = {
	on_learn = function(player)
		player.registry["learned_reveal_soul"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_reveal_soul"] = 0
	end,
	cast = function(player, target)
		local magicCost = 0
		local aether = 604800000
		local sound = 106
		local color = 0

		if target.registry["fate_q_5"] == 1 then --white
			color = 1
		elseif target.registry["fate_q_5"] == 2 then -- purple
			color = 29
		elseif target.registry["fate_q_5"] == 3 then --pink
			color = 184
		elseif target.registry["fate_q_5"] == 4 then --red
			color = 21
		elseif target.registry["fate_q_5"] == 5 then --orange
			color = 10
		elseif target.registry["fate_q_5"] == 6 then --yellow
			color = 20
		elseif target.registry["fate_q_5"] == 7 then --green
			color = 22
		elseif target.registry["fate_q_5"] == 8 then --blue
			color = 24
		elseif target.registry["fate_q_5"] == 9 then --brown
			color = 2
		elseif target.registry["fate_q_5"] == 10 then --black
			color = 0
		end

		local anim = 297

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target ~= nil then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:calcStat()
			player:sendStatus()
			player:sendMinitext("You cast Reveal Soul.")
			player:playSound(sound)
			target:sendAnimation(anim)
			target.hairColor = color
			target:updateState()
			player:setAether("reveal_soul", aether)
			reveal_soul.addLegends(player, target)
			if target.blType == BL_PC and target.ID ~= player.ID then
				target:sendMinitext(player.name .. " reveals your soul.")
			end
		end
	end,
	addLegends = function(player, target)
		local reg = player.registry["souls_revealed"]

		--	finishedQuest(player)
		if player:hasLegend("souls_revealed") then
			player:removeLegendbyName("souls_revealed")
		end

		if reg > 0 then
			player.registry["souls_revealed"] = player.registry["souls_revealed"] + 1
			player:addLegend("Has revealed " .. player.registry["souls_revealed"] .. " souls", "souls_revealed", 156, 144)
		else
			player.registry["souls_revealed"] = 1
			player:addLegend("Has revealed 1 soul", "souls_revealed", 156, 144)
		end

		target:addLegend("Soul revealed by " .. player.name .. " " .. curT(), "soul_revealed", 156, 144)
	end,
	requirements = function(player)
		local level = 0
		local item = {0}
		local amounts = {25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Reveal Soul is a spell that changes a target's hair to match their soul.", txt}
		return level, item, amounts, desc
	end
}
