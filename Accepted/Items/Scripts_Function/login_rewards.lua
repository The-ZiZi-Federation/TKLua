login_rewards = {
click = async(function(player,npc)
	
	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID
	local rewardGold = player.level*50

	if player.registry["login_rewards_timer"] == 0 then
		player.registry["login_rewards"] = 1
		player:leveledEXP("daily")
		--player:giveXP(rewardEXP)
		player:addGold(rewardGold)
		player.registry["login_rewards_timer"] = os.time() + 86400
		player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)


	elseif player.registry["login_rewards_timer"] > 0 and player.registry["login_rewards_timer"] < os.time() then
		if player.registry["login_rewards"] == 0 then 

			player.registry["login_rewards"] = 1
			player:leveledEXP("daily")
			player:addGold(rewardGold)
			player.registry["login_rewards_timer"] = os.time() + 86400
			player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)

		elseif player.registry["login_rewards"] == 30 then
			if player.registry["login_rewards_timer"] > 0 and player.registry["login_rewards_timer"] < os.time() then
				player.registry["login_rewards"] = player.registry["login_rewards"] + 1
				--player:giveXP(rewardEXP*2)
				player:leveledEXP("daily")
				player:addGold(rewardGold*2)
				player.registry["login_rewards_timer"] = os.time() + 86400
				player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)
			else
				player:dialogSeq({"Come back tomorrow for more rewards!"}, 1)
			end

		elseif player.registry["login_rewards"] == 60 then
			if player.registry["login_rewards_timer"] > 0 and player.registry["login_rewards_timer"] < os.time() then
				player.registry["login_rewards"] = player.registry["login_rewards"] + 1
				--player:giveXP(rewardEXP*3)
				player:leveledEXP("daily")
				player:addGold(rewardGold*3)
				player.registry["login_rewards_timer"] = os.time() + 86400
				player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)
			else
				player:dialogSeq({"Come back tomorrow for more rewards!"}, 1)
			end

		elseif player.registry["login_rewards"] == 90 then
		 	if player.registry["login_rewards_timer"] > 0 and player.registry["login_rewards_timer"] < os.time() then
				player.registry["login_rewards"] = player.registry["login_rewards"] + 1
				--player:giveXP(rewardEXP*4)
				player:leveledEXP("daily")
				player:addGold(rewardGold*4)
				player.registry["login_rewards_timer"] = os.time() + 86400
				player.registry["login_rewards"] = 0
				player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)

			else
				player:dialogSeq({"Come back tomorrow for more rewards!"}, 1)
			end
		else

			if player.registry["login_rewards_timer"] > 0 and player.registry["login_rewards_timer"] < os.time() then

				player.registry["login_rewards"] = player.registry["login_rewards"] + 1
				--player:giveXP(rewardEXP)
				player:leveledEXP("daily")
				player:addGold(rewardGold)
				player.registry["login_rewards_timer"] = os.time() + 86400
				player:dialogSeq({"Login Rewards: Day "..player.registry["login_rewards"].."\n\nEnjoy some Experience and "..(rewardGold).." Coins\n\nThanks for playing!"}, 1)
			else
				player:dialogSeq({"Come back tomorrow for more rewards!"}, 1)
			end

		end
	elseif player.registry["login_rewards_timer"] > os.time() then
		player:sendMinitext("You have already received a login reward today. Come back tomorrow for more rewards!")

	end
end
)
}