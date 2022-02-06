duraloss = {

attack = function(player, attacker)

	local amount = math.random(1, 10)
	
	local weap = player:getEquippedItem(EQ_WEAP)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local helm = player:getEquippedItem(EQ_HELM)
	local left = player:getEquippedItem(EQ_LEFT)
	local right = player:getEquippedItem(EQ_RIGHT)
	local subleft = player:getEquippedItem(EQ_SUBLEFT)
	local subright = player:getEquippedItem(EQ_SUBRIGHT)
	local necklace = player:getEquippedItem(EQ_NECKLACE)
--	local cape = player:getEquippedItem(EQ_MANTLE)
	local boots = player:getEquippedItem(EQ_BOOTS)
		
	if weap ~= nil then
		player:deductDura(0, amount)
	end
	
	if armor ~= nil then
		player:deductDura(1, amount)
	end
	
	if shield ~= nil then
		player:deductDura(2, amount)
	end
	
	if helm ~= nil then
		player:deductDura(3, amount)
	end
	
	if left ~= nil then
		player:deductDura(4, amount)
	end
	
	if right ~= nil then
		player:deductDura(5, amount)
	end
	
	if subleft ~= nil then
		player:deductDura(6, amount)
	end
	
	if subright ~= nil then
		player:deductDura(7, amount)
	end

	if necklace ~= nil then
		player:deductDura(11, amount)
	end
	
--	if cape ~= nil then
--		player:deductDura(EQ_MANTLE, amount)
--	end
	
	if boots ~= nil then
		player:deductDura(EQ_BOOTS, amount)
	end
end
}