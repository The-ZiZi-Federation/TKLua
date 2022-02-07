-------------------------------------------------------
--   Spell: Divine Favor
--   Class: Priest
--   Level: 5
--  Aether: N/A
--    Cost: 25% MP
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Will / Might / Grace Buff
-------------------------------------------------------
--    Desc: Divine Favor is a spell to increase your allies Might, Will and Grace
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 12/01/2016
-------------------------------------------------------
divine_favor = {
	on_learn = function(player)
		player.registry["learned_divine_favor"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_divine_favor"] = 0
	end,
	cast = function(player)
		local duration = 600000
		local magicCost = math.floor(player.maxMagic * 0.05)
		local divineFavorBonus = 0

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		for i = 1, #player.group do
			if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m) then
				if Player(player.group[i]):hasDuration("divine_favor") then
					Player(player.group[i]):setDuration("divine_favor", 0)
				end

				if Player(player.group[i]).level >= 15 and Player(player.group[i]).level <= 60 then
					divineFavorBonus = 1
				elseif Player(player.group[i]).level >= 61 and Player(player.group[i]).level <= 99 then
					divineFavorBonus = 2
				elseif Player(player.group[i]).level >= 100 and Player(player.group[i]).level <= 124 then
					divineFavorBonus = 3
				elseif Player(player.group[i]).level >= 125 and Player(player.group[i]).level <= 149 then
					divineFavorBonus = 4
				elseif Player(player.group[i]).level >= 150 and Player(player.group[i]).level <= 174 then
					divineFavorBonus = 5
				elseif Player(player.group[i]).level >= 175 and Player(player.group[i]).level <= 199 then
					divineFavorBonus = 6
				elseif Player(player.group[i]).level >= 200 and Player(player.group[i]).level <= 224 then
					divineFavorBonus = 7
				elseif Player(player.group[i]).level >= 225 and Player(player.group[i]).level <= 249 then
					divineFavorBonus = 8
				elseif Player(player.group[i]).level >= 250 and Player(player.group[i]).level <= 252 then
					divineFavorBonus = 9
				elseif Player(player.group[i]).level >= 253 then
					divineFavorBonus = 10
				end

				Player(player.group[i]).registry["divine_favor_bonus"] = divineFavorBonus

				Player(player.group[i]):sendAnimation(98, 0)
				Player(player.group[i]):setDuration("divine_favor", duration)
				Player(player.group[i]):calcStat()
				Player(player.group[i]):sendMinitext(player.name .. " has Bestowed upon you a Divine Favor")
			end
		end
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:playSound(112)
		player:sendStatus()
	end,
	recast = function(player)
		local divineFavorBonus = player.registry["divine_favor_bonus"]

		player.might = player.might + divineFavorBonus
		player.will = player.will + divineFavorBonus
		player.grace = player.grace + divineFavorBonus
	end,
	uncast = function(player)
		player:calcStat()
		player.registry["divine_favor_bonus"] = 0
	end,
	requirements = function(player)
		local level = 15
		local item = {0, 53, 50, 51}
		local amounts = {500, 5, 20, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Divine Favor is a spell to increase your ally's Might, Will, and Grace!", txt}
		return level, item, amounts, desc
	end
}
