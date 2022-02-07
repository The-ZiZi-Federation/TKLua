mobile_shop = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		mobile_shop.summon(player)
	end,
	summon = function(player)
		player:addNPC("mobile_shop", player.m, player.x, player.y, 1000, 10000, player.ID, "Mobile Shop")
	end,
	action = function(block, owner)
		block:sendAnimationXY(364, block.x, block.y)
	end,
	endAction = function(block, owner)
		block:delete()
	end,
	--click = async(function(player, npc)
	--
	--	player:freeAsync()
	--	mobile_shop.click(player, npc)
	--
	--end

	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(305, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local offenseName
			local defenseName

			local options = {}

			table.insert(options, "Buy Weapons")
			table.insert(options, "Sell Weapons")

			table.insert(options, "Buy Advanced Weapons")
			table.insert(options, "Sell Advanced Weapons")

			table.insert(options, "Buy Armor")
			table.insert(options, "Sell Armor")

			table.insert(options, "Buy Advanced Armors")
			table.insert(options, "Sell Advanced Armors")

			table.insert(options, "Buy Clothing")
			table.insert(options, "Sell Clothing")

			table.insert(options, "Buy Advanced Clothing")
			table.insert(options, "Sell Advanced Clothing")

			table.insert(options, "Buy Footwear")
			table.insert(options, "Sell Footwear")

			table.insert(options, "Buy Food")
			table.insert(options, "Sell Food")

			menu = player:menuString(name .. "I am traveling merchant. I buy and sell many goods.", options)

			if menu == "Buy Weapons" then
				weapon_smith.buy(player)
			elseif menu == "Sell Weapons" then
				weapon_smith.sell(player)
			elseif menu == "Buy Advanced Weapons" then
				cathay_weapon_shop.buy(player)
			elseif menu == "Sell Advanced Weapons" then
				cathay_weapon_shop.sell(player)
			elseif menu == "Buy Armor" then
				armor_smith.buy(player)
			elseif menu == "Sell Armor" then
				armor_smith.sell(player)
			elseif menu == "Buy Advanced Armors" then
				cathay_armor_shop.buy(player)
			elseif menu == "Sell Advanced Armors" then
				cathay_armor_shop.sell(player)
			elseif menu == "Buy Clothing" then
				finery_shop.buy(player)
			elseif menu == "Sell Clothing" then
				finery_shop.sell(player)
			elseif menu == "Buy Advanced Clothing" then
				cathay_finery_shop.buy(player)
			elseif menu == "Sell Advanced Clothing" then
				cathay_finery_shop.sell(player)
			elseif menu == "Buy Footwear" then
				cathay_shoe_shop.buy(player)
			elseif menu == "Sell Footwear" then
				cathay_shoe_shop.sell(player)
			elseif menu == "Buy Food" then
				chef_shop.buy(player)
			elseif menu == "Sell Food" then
				chef_shop.sell(player)
			end
		end
	)
}
