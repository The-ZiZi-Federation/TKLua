setWeapon = function(player, look, lookColor, icon, iconColor)
	local weapon = player:getEquippedItem(EQ_WEAP)
	if weapon == nil then
		return
	end
	--player:talk(0,"Weapon Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	weapon.customLook = look
	weapon.customLookColor = lookColor
	weapon.customIcon = icon
	weapon.customIconColor = iconColor
	player:msg(0, "Weapon Skin set", player.ID)
	player:updateState()
end

setShield = function(player, look, lookColor, icon, iconColor)
	local shield = player:getEquippedItem(EQ_SHIELD)
	if shield == nil then
		return
	end
	--player:talk(0,"Shield Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	shield.customLook = look
	shield.customLookColor = lookColor
	shield.customIcon = icon
	shield.customIconColor = iconColor
	player:msg(0, "Shield Skin set", player.ID)
	player:updateState()
end

setArmor = function(player, look, lookColor, icon, iconColor)
	local armor = player:getEquippedItem(EQ_ARMOR)
	if armor == nil then
		return
	end
	--player:talk(0,"Shield Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	armor.customLook = look
	armor.customLookColor = lookColor
	armor.customIcon = icon
	armor.customIconColor = iconColor
	player:msg(0, "Armor Skin set", player.ID)
	player:updateState()
end

setHelm = function(player, look, lookColor, icon, iconColor)
	local helm = player:getEquippedItem(EQ_HELM)
	if helm == nil then
		return
	end
	--player:talk(0,"Shield Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	helm.customLook = look
	helm.customLookColor = lookColor
	helm.customIcon = icon
	helm.customIconColor = iconColor
	player:msg(0, "Helm Skin set", player.ID)
	player:updateState()
end

setCrown = function(player, look, lookColor, icon, iconColor)
	local crown = player:getEquippedItem(EQ_CROWN)
	if crown == nil then
		return
	end
	--player:talk(0,"Shield Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	crown.customLook = look
	crown.customLookColor = lookColor
	crown.customIcon = icon
	crown.customIconColor = iconColor
	player:msg(0, "Crown Skin set", player.ID)
	player:updateState()
end

setBoots = function(player, look, lookColor, icon, iconColor)
	local boots = player:getEquippedItem(EQ_BOOTS)
	if boots == nil then
		return
	end
	--player:talk(0,"Boots Look: "..look.." Color: "..lookColor.." Icon: "..icon.." Color: "..iconColor)
	boots.customLook = look
	boots.customLookColor = lookColor
	boots.customIcon = icon
	boots.customIconColor = iconColor
	player:msg(0, "Boot Skin set", player.ID)
	player:updateState()
end
