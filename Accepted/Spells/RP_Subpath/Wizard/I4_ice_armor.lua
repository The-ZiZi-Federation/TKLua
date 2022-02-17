ice_armor = {
	on_learn = function(player)
		player.registry["ice_armor"] = 1
	end,
	on_forget = function(player)
		player.registry["ice_armor"] = 0
	end,
	cast = function(player, target)
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local magicCost = 1000
		local duration = 30000
		local aether = 120000
		local anim = 99
		local sound = 45

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if target:hasDuration("ice_armor") then
			alreadyCast(player)
			return
		end
		if target.blType == BL_MOB or target.state == 1 then
			invalidTarget(player)
			return
		end

		if target.blType == BL_PC then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:setAether("ice_armor", aether)
			player:sendStatus()
			player:playSound(sound)
			player:sendMinitext("You cast Ice Armor")
			target:sendAnimation(anim)
			target:setDuration("ice_armor", duration)
			target:calcStat()
			target:sendMinitext(player.name .. " cast Ice Armor on you")
		end
	end,
	on_takedamage_while_cast = function(player, attacker)
		local r = math.random(1, 1000)

		if attacker.blType == BL_MOB then
			if r <= 250 then
				if not attacker:hasDuration("slow") then
					if checkResist(player, attacker, "slow") == 1 then
						return
					end
					attacker:setDuration("slow", 6000)
					attacker:sendAnimation(52)
				end
			end
		end
	end,
	uncast = function(player)
		player:sendMinitext("Your Ice Armor fades away")
	end,
	requirements = function(player)
		local level = 72
		local item = {0, 6050, 51}
		local amounts = {3500, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Ice Armor is a spell that can slow enemies who hit you!", txt}
		return level, item, amounts, desc
	end
}
