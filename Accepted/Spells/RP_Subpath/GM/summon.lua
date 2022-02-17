summon = {
	on_learn = function(player)
		player.registry["learned_summon"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_summon"] = 0
	end,
	cast = function(player, question)
		local magicCost = 1000
		local q = string.lower(player.question)

		if not player:canCast(1, 1, 0) then
			return
		end

		if Player(q) ~= nil then
			pc = Player(q)
			if pc.registry["being_summon"] == 1 then
				pc:msg(4, "[GM]: " .. player.name .. " is trying to summon you", pc.ID)
				return
			end
			if player.gmLevel == 0 then
				if Player(q).registry["vending_open"] > 0 then
					anim(player)
					player:sendMinitext("You cannot summon them now")
					return
				end

				if Player(q).ID == 2 then
					player:sendAnimation(246)
					player:sendMinitext("You cannot do that")
					return
				end

				if player.m ~= Player(q).m then
					player:sendAnimation(246)
					player:sendMinitext("Target must in same map")
					return
				else
					if player.magic < magicCost then
						notEnoughMP(player)
						return
					end
					Player(q):warp(player.m, player.x, player.y)
					Player(q):sendAnimation(16)
					Player(q):sendMinitext("You are summoned by " .. player.name)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:setAether("summon", 30000)
				end
			else
				Player(q):warp(player.m, player.x, player.y)
				Player(q):sendAnimation(16)
				Player(q):sendMinitext("You are summoned by " .. player.name)
			end
		end
		player:sendMinitext("You cast summon")
		player:sendAction(6, 20)
	end
}
