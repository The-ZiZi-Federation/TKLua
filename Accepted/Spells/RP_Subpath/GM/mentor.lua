mentor = {
	on_learn = function(player)
		player.registry["learned_mentor"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_mentor"] = 0
	end,
	cast = function(player, target)
		local pwsPlayer = player.baseHealth + player.baseMagic * 2
		local pwsTarget = target.baseHealth + target.baseMagic * 2

		if target.blType == BL_PC then
			if target.ID == player.ID then
				anim(player)
				player:sendMinitext("You can't mentor yourself!")
				return
			end
			if target.registry["mentor_npc_timer"] >= os.time() then
				player:sendAnimation(246)
				player:sendMinitext("Target is busy!")
				return
			end
			if target.groupID == player.groupID then
				if target.level > player.level then
					player:sendAnimation(246)
					player:sendMinitext("Target stronger than you!")
					return
				else
					if target.registry["mentor_by"] > 0 then
						player:sendAnimation(246)
						player:sendMinitext("Target has mentored by " .. Player(target.registry["mentor_by"]).name .. ".")
						return
					else
						if target.level == 99 and player.level == 99 then
							if pwsTarget > 2000000 then
								player:sendAnimation(246)
								player:sendMinitext("Target's pws has reached over 2 Million!")
								return
							else
								if pwsTarget > pwsPlayer then
									player:sendAnimation(246)
									player:sendMinitext("Target stronger than you!")
									return
								else
									player:playSound(3)
									player:sendAction(6, 20)
									target.registry["mentor_npc"] = player.ID
									target.registry["mentor_npc_timer"] = os.time() + 5
									npc_mentor.click(target, npc)
								end
							end
						end
					end
				end
			else
				player:sendAnimaton(246)
				player:sendMinitext("Target must in same group!")
			end
		end
	end,
	requirements = function(player)
		txt = "- 1000 Chesnut \n"
		txt = txt .. "- 5000 Coins \n"

		local level = 60
		local item = {43, 0}
		local amounts = {1000, 5000}
		local desc = {
			"Be a teacher for target, your student will get bonus hunt exp",
			"To learn this spell you must to sacriface\n" .. txt .. ""
		}
		return level, item, amounts, desc
	end
}

npc_mentor = {
	click = async(
		function(player, npc)
			local pc = Player(player.registry["mentor_npc"])
			gfxClone(pc, npc)
			player.npcGrapic = 0
			player.npcColor = 0
			player.dialogType = 2

			if pc ~= nil then
				menu = player:menuString(pc.name .. " want you to be her/him student.", {"Accept", "Decline"})
				if menu == "Accept" then
					player.registry["mentor_by"] = pc.ID
					pc:msg(4, "[Mentor]: " .. player.name .. " become your student now! Please teach him/her well.", pc.ID)
					player:msg(4, "[Mentor]: " .. pc.name .. " is your Teacher now!", player.ID)
				else
					pc:msg(4, "[Mentor]: " .. player.name .. " has refused your request!", pc.ID)
				end
			end
		end
	)
}
