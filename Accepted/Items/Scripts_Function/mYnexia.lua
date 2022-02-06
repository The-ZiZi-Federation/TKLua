
spellDamage = function(player, target, damage, type)
	
	local threat
	local weap = player:getEquippedItem(EQ_WEAP)
	
	damage = element.getDamage(player, target, damage)
	
	if type == "magic" then
		if target.element == 8 then
			if weap ~= nil and weap.element > 0 then damage = damage*1.2 end
		elseif target.element == 9 then
			if weap ~= nil and weap.element > 0 then damage = damage*.12 else damage = damage*.1 end
		end
	else
		if target.element == 8 then
			if weap ~= nil and weap.element > 0 then damage = damage*.12 else damage = damage*.1 end
		elseif target.element == 9 then
			if weap ~= nil and weap.element > 0 then damage = damage*1.2 else damage = damage end
		end
	end
	if damage - target.armor > 0 then damage = damage - target.armor end
	if target.blType == BL_MOB and target.owner ~= player.ID then
		player:addThreat(target.ID, damage)
	end
	target.attacker = player.ID
	target:removeHealth(damage)
end

vanish = function(block)

	block.gfxCrown = 65535
	block.gfxFace = 500
	block.gfxHair = 500
	block.gfxHelm = 255
	block.gfxArmor = 65535
	block.gfxCape = 65535
	block.gfxShield = 65535
	block.gfxWeap = 65535
	block.gfxBoots = 65535
	block.gfxNeck = 65535
	block.gfxFaceA = 65535
	block.gfxFaceAT = 65535
	block.gfxName = ""
	block.gfxClone = 1
	block:updateState()
end

getFacingObject = function(player)
	
	local obj = 0
	
	if player.side == 0 then
		obj = getObject(player.m, player.x, player.y-1)
	elseif player.side == 1 then
		obj = getObject(player.m, player.x+1, player.y)
	elseif player.side == 2 then
		obj = getObject(player.m, player.x, player.y+1)
	elseif player.side == 3 then
		obj = getObject(player.m, player.x-1, player.y)
	end
	return obj
end

checkCanCast = function(block, healthCost, magicCost)
	
	if not block:canCast(1,1,0) then return false else
		if block.health < healthCost or block.health - healthCost <= 0 then notEnoughHP(block) return false else
			if block.magic < magicCost or block.magic - magicCost <= 0 then notEnoughMP(block) return false else
				player.health = player.health - healthCost
				player.magic = player.magic - magicCost
				player:sendStatus()
				return true
			end
		end
	end
end

function Player.bowShoot(player, cells, icon, color, check)
	
	local x, y = player.x, player.y
	local arrow, damage  = 6, 0
	local weap, quiver = player:getEquippedItem(EQ_WEAP), player:getEquippedItem(EQ_SHIELD)
	
	if weap ~= nil and weap.thrown then
		if quiver ~= nil and quiver.thrown then
			damage = weap.maxDmg + quiver.maxDmg + player.might + player.grace
		end
	end
	if icon == nil then icon = player.side + arrow end
	if color == nil then color = 0 end
	player:playSound(709)
	player:sendAction(1, 10)
	
	for i = 1, cells do
		local pc, mob = getTargetFacing(player, BL_PC,0,i), getTargetFacing(player, BL_MOB,0,i)
		
		if player.side == 0 then
			if getPass(player.m, player.x, player.y-i) == 1 then return end
		elseif player.side == 1 then
			if getPass(player.m, player.x+i, player.y) == 1 then return end
		elseif player.side == 2 then
			if getPass(player.m, player.x, player.y+i) == 1 then return end
		elseif player.side == 3 then
			if getPass(player.m, player.x-i, player.y) == 1 then return end
		end
		if check == nil then
			if pc ~= nil then 
				if player:canPK(pc) and pc.state ~= 1 then
					pc.attacker = player.ID
					player.damage = damage
					player_combat.on_attacked(pc, player)
				end
				return
			end
			if mob ~= nil then
				mob.attacker = player.ID
				player.damage = damage
				if mob.aiType == 0 then
					mob_ai_basic.on_attacked(mob, player)
				elseif mob.aiType == 1 then
					mob_ai_normal.on_attacked(mob, player)
				elseif mob.aiType == 2 then
					mob_ai_hard.on_attacked(mob, player)
				elseif mob.aiType == 3 then
					mob_ai_boss.on_attacked(mob, player)
				elseif mob.aiType == 4 then
					mob:callBase("on_attacked")
				elseif mob.aiType == 5 then
					mob_ai_ghost.on_attacked(mob, player)
				end
				return
			end
		end
		if player.side == 0 then
			player:throw(player.x, player.y-i,icon,color,1)
		elseif player.side == 1 then
			player:throw(player.x+i, player.y,icon,color,1)
		elseif player.side == 2 then
			player:throw(player.x, player.y+i,icon,color,1)
		elseif player.side == 3 then
			player:throw(player.x-i, player.y,icon,color,1)
		end
	end
end

getFacingPass = function(player, cell)
	
	local value = 1
	
	if cell == nil then cell = 1 end
	
	if player.side == 0 then
		if getPass(player.m, player.x, player.y-cell) == 0 then value = 0 end
	elseif player.side == 1 then
		if getPass(player.m, player.x+cell, player.y) == 0 then value = 0 end
	elseif player.side == 2 then
		if getPass(player.m, player.x, player.y+cell) == 0 then value = 0 end
	elseif player.side == 3 then
		if getPass(player.m, player.x-cell, player.y) == 0 then value = 0 end
	end
	
	return value
end


facingTo = function(block, target)

	if target ~= nil then
		if target.x == block.x-1 and target.side == 1 and target.y == block.y then
			block.side = 3
		elseif target.x == block.x+1 and target.side == 3 and target.y == block.y then
			block.side = 1
		elseif target.x == block.x and target.side == 2 and target.y == block.y-1 then
			block.side = 0
		elseif target.x == block.x and target.side == 0 and target.y == block.y+1 then
			block.side = 2
		end
		block:sendSide()
	end
end

throwIcon = function(player)
	
	local icon = player.registry["throw_icon"]
	
	if icon > 0 then
		for i = 1, 10 do
			if player.side == 0 then
				player:throw(player.x, player.y-i, icon, 0, 1)
			elseif player.side == 1 then
				player:throw(player.x+i, player.y, icon, 0, 1)
			elseif player.side == 2 then
				player:throw(player.x, player.y+i, icon, 0, 1)
			elseif player.side == 3 then
				player:throw(player.x-i, player.y, icon, 0, 1)
			end
		end
	end
end

killAction = function(player, dura)

	if dura ~= nil then
		player.registry["action10"] = os.time() + tonumber(dura)
	return else
		if player.registry["action10"] > 0 then
			if player.registry["action10"] < os.time() then
				player.registry["action10"] = 0
				player:sendAction(10, 60)
			end
		end
	end
end

getTargetFacingCell = function(player, cell, type)
	
	local target
	
	if player.side == 0 then
		target = player:getObjectsInCell(player.m, player.x, player.y-cell, type)
	elseif player.side == 1 then
		target = player:getObjectsInCell(player.m, player.x+cell, player.y, type)
	elseif player.side == 2 then
		target = player:getObjectsInCell(player.m, player.x, player.y+cell, type)
	elseif player.side == 3 then
		target = player:getObjectsInCell(player.m, player.x-cell, player.y, type)
	end
	if #target > 0 then
		for i = 1, #target do
			return target[i]
		end
	end
end

foundHiddenQuest = function(player, quest)

	finishedQuest(player)
	player:msg(4, "[HIDDEN] You found a hidden quest!! '"..quest.."' ===", player.ID)
end
	
addTitle = function(player, name, title)

	player.registry[""..name..""] = 1
	player.title = title
	player:status()
	player:msg(4, "=== New Title Added! ===", player.ID)
end

frontTile = function(player, cell)

	if cell == nil then cell = 1 end
	if player.side == 0 then return getTile(player.m, player.x, player.y-cell) end
	if player.side == 1 then return getTile(player.m, player.x+cell, player.y) end
	if player.side == 2 then return getTile(player.m, player.x, player.y+cell) end
	if player.side == 3 then return getTile(player.m, player.x-cell, player.y) end
end

frontWarp = function(player, cell)

	for i = 1, cell do
		if player.side == 0 then
			if getPass(player.m, player.x, player.y-cell) == 1 then return else
				player:warp(player.m, player.x, player.y-1)
			end
		elseif player.side == 1 then
			if getPass(player.m, player.x+cell, player.y) == 1 then return else
				player:warp(player.m, player.x+1, player.y)
			end
		elseif player.side == 2 then
			if getPass(player.m, player.x, player.y+cell) == 1 then return else
				player:warp(player.m, player.x, player.y+1)
			end
		elseif player.side == 3 then
			if getPass(player.m, player.x-cell, player.y) == 1 then return else
				player:warp(player.m, player.x-1, player.y)
			end
		end
	end
end
	
getFacingObj = function(block, cell)

	local side = player.side
	local obj = 0
	
	if cell == nil then cell = 1 end
	if side == 0 then
		obj = getObject(player.m, player.x, player.side-cell)
	elseif side == 1 then
		obj = getObject(player.m, player.x+cell, player.side)
	elseif side == 2 then
		obj = getObject(player.m, player.x, player.side+cell)
	elseif side == 3 then
		obj = getObject(player.m, player.x-cell, player.side)
	end
	return obj
end




reloadGfxLook = function(player, item)

	if player.gfxClone == 1 and player.registry["used_item_mall"] == 1 then
		if item.type == 3 then			-- Weapon
			
		elseif item.type == 4 then		-- Armor
			coat = player:getEquippedItem(EQ_COAT)
			if coat ~= nil then return else
				player.gfxArmor = item.look
				player.gfxArmorC = item.lookC
			end
		elseif item.type == 5 then		-- Shield
			player.gfxShield = item.look
			player.gfxShieldC = item.lookC
		elseif item.type == 6 then		-- Helm
		--	player.gfxHelm = item.look
		--	player.gfxHelmC = item.lookC
		elseif item.type == 11 then     -- Face accessory
			player.gfxFaceA = item.look
			player.gfxFaceAC = item.lookC
		elseif item.type == 12 then     -- Crown
			player.gfxCrown = item.look
			player.gfxCrownC = item.lookC
		elseif item.type == 13 then     -- Mantle/Cape
			player.gfxCape = item.look
			player.gfxCapceC = item.lookC
		elseif item.type == 14 then     -- Necklace
			player.gfxNeck = item.look
			player.gfxNeckC = item.lookC
		elseif item.type == 15 then     -- Boots
			player.gfxBoots = item.look
			player.gfxBootsC = item.lookC
		elseif item.type == 16 then     -- Coat
			player.gfxArmor = item.look
			player.gfxArmorC = item.lookC
		end
		player:updateState()
	end
end

function Player.sendFrontAnimation(player, anim, side, cell)
	
	if side == 0 then
		player:sendAnimationXY(anim, player.x, player.y-cell)
	elseif side == 1 then
		player:sendAnimationXY(anim, player.x+cell, player.y)
	elseif side == 2 then
		player:sendAnimationXY(anim, player.x, player.y+cell)
	elseif side == 3 then
		player:sendAnimationXY(anim, player.x-cell, player.y)
	end
end

function Player.sendFrontAnimation(player, anim)

	local side = player.side
	
	if side == 0 then
		player:sendAnimationXY(anim, player.x, player.y-1)
	elseif side == 1 then
		player:sendAnimationXY(anim, player.x+1, player.y)
	elseif side == 2 then
		player:sendAnimationXY(anim, player.x, player.y+1)
	elseif side == 3 then
		player:sendAnimationXY(anim, player.x-1, player.y)
	end
end



switchReg = function(player, regName, first, second)
	
	if player.registry[""..regName..""] == tonumber(first) then
		player.registry[""..regName..""] = tonumber(second)
	elseif player.registry[""..regName..""] == tonumber(second) then
		player.registry[""..regName..""] = tonumber(first)
	end
end

function Player.selfFrontAnimation(player, anim, cell)

	if player.side == 0 then
		player:selfAnimationXY(player.ID, anim, player.x, player.y-cell, 0)
	elseif player.side == 1 then
		player:selfAnimationXY(player.ID, anim, player.x+cell, player.y, 0)
	elseif player.side == 2 then
		player:selfAnimationXY(player.ID, anim, player.x, player.y+cell, 0)
	elseif player.side == 3 then
		player:selfAnimationXY(player.ID, anim, player.x-cell, player.y, 0)
	end
end

totalMobsInMap = function(player, map, mob)
	
	local str, num = tostring(mob), tonumber(mob)
	local momon = {}
	local mobsInMap = player:getObjectsInMap(map, BL_MOB)
	local total = 0
	
	if #mobsInMap > 0 then
		for i = 1, #mobsInMap do
			if str ~= nil and mobsInMap[i].yname == str then
				table.insert(momon, mobsInMap[i].ID)
			elseif num ~= nil and mobsInMap[i].mobID == num then
				table.insert(momon, mobsInMap[i].ID)
			end
		end
		total = #momon
	end
return total end


giveLegend = function(player, text, name, icon, color, type)
	
	local time = "(Morna "..curYear()..", "..getCurSeason()..")"
	if tonumber(icon) == nil then icon = 17 end
	if tonumber(color) == nil then color = 16 end
	if player:hasLegend(name) then player:removeLegendbyName(name) end
	if tonumber(type) == 0 then
		player:addLegend(text, name, icon, color)
	elseif tonumber(type) == 1 then
		player:addLegend(text.." "..time, name, icon, color)
	end
	finishedQuest(player)
	player:msg(4, "=== New legend added! ===", player.ID)
end


repairAll = function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local items = {}
	for i = 0, 7 do
		eq = player:getEquippedItem(i)
		if eq ~= nil then
			if eq.repairable == false then
				if eq.dura < eq.maxDura then
					table.insert(items, eq.id)
				end
			end
		end
	end
	if #items == 0 then player:popUp("You don't have anything to repair") return end
	
	local weapC, armorC, helmC, shieldC, leftC, rightC, left2C, right2C	
	local weap = player:getEquippedItem(EQ_WEAP)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local helm = player:getEquippedItem(EQ_HELM)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local left = player:getEquippedItem(EQ_LEFT)
	local right = player:getEquippedItem(EQ_RIGHT)
	local left2 = player:getEquippedItem(6)
	local right2 = player:getEquippedItem(7)
	local items = {}
	
-- Weapon
	if weap ~= nil then weapN = weap.name
		if weap.dura < weap.maxDura and weap.repairable == false then
			WeapC = math.ceil(weap.maxDura - weap.dura)
		else
			weapC = 0
		end
	else
		weapN = "None"
	end
-- Armor
	if armor ~= nil then armorN = armor.name
		if armor.dura < armor.maxDura and armor.repairable == false then
			armorC = math.ceil(armor.maxDura - armor.dura)
		else
			armorC = 0
		end
	else
		armorN = "None"
	end
-- Helm
	if helm ~= nil then helmN = helm.name
		if helm.dura < helm.maxDura and helm.repairable == false then
			helmC = math.ceil(helm.maxDura - helm.dura)
		else
			helmC = 0
		end
	else
		helmN = "None"
	end
-- Shield	
	if shield ~= nil then shieldN = shield.name
		if shield.dura < shield.maxDura and shield.repairable == false then
			shieldC = math.ceil(shield.maxDura - shield.dura)
		else
			shieldC = 0
		end
	else
		shieldN = "None"
	end	
-- Left
	if left ~= nil then leftN = left.name
		if left.dura < left.maxDura and left.repairable == false then
			leftC = math.ceil(left.maxDura - left.dura)
		else
			leftC = 0
		end
	else
		leftN = "None"
	end
-- Right	
	if right ~= nil then rightN = right.name
		if right.dura < right.maxDura and right.repairable == false then
			rightC = math.ceil(right.maxDura - right.dura)
		else
			rightC = 0
		end
	else
		rightN = "None"
	end	
-- ScriptL	
	if left2 ~= nil then left2N = left2.name
		if left2.dura < left2.maxDura and left2.repairable == false then
			left2C = math.ceil(left2.maxDura - left2.dura)
		else
			left2C = 0
		end
	else
		left2N = "None"
	end
-- ScriptR
	if right2 ~= nil then right2N = right2.name
		if right2.dura < right2.maxDura and right2.repairable == false then
			right2C = math.ceil(right2.maxDura - right2.dura)
		else
			right2C = 0
		end
	else
		right2N = "None"
	end
	total = math.ceil(weapC + armorC + helmC + shieldC + rightC + leftC + right2C + left2C)
	
	if player:removeGold(total) == false then
		player:dialogSeq({t, "You don't have enough money to repair all.\n'You can try repair items in bag'"})
		return
	end
	if weap ~= nil then
		if weap.dura < weap.maxDura then weap.dura = weap.maxDura end
	end
	if armor ~= nil then
		if armor.dura < armor.maxDura then armor.dura = armor.maxDura end
	end
	if helm ~= nil then
		if helm.dura < helm.maxDura then helm.dura = helm.maxDura end
	end
	if shield ~= nil then
		if shield.dura < shield.maxDura then shield.dura = shield.maxDura end
	end
	if right ~= nil then
		if right.dura < right.maxDura then right.dura = right.maxDura end
	end
	if left ~= nil then
		if left.dura < left.maxDura then left.dura = left.maxDura end
	end
	if right2 ~= nil then
		if right2.dura < right2.maxDura then right2.dura = right2.maxDura end
	end
	if left2 ~= nil then
		if left2.dura < left2.maxDura then left2.dura = left2.maxDura end
	end
	player:status()
	player:removeGold(total)
	txt =      "\nThe repair cost are :\n\n"
	txt = txt.."----------------------------------------\n"
	txt = txt.."Weapon : "..weapN.." ("..weapC.." coins)\n"
	txt = txt.."Armor  : "..armorN.." ("..armorC.." coins)\n"
	txt = txt.."Helm   : "..helmN.." ("..helmC.." coins)\n"
	txt = txt.."Shield : "..shieldN.." ("..shieldC.." coins)\n"
	txt = txt.."R hand : "..rightN.." ("..rightC.." coins)\n"
	txt = txt.."L hand : "..leftN.." ("..leftC.." coins)\n"
	txt = txt.."R acc  : "..right2N.." ("..right2C.." coins)\n"
	txt = txt.."L acc  : "..left2N.." ("..left2C.." coins)\n\n"
	txt = txt.."----------------------------------------\n"
	txt = txt.."Total  : "..format_number(total).." coins\n"
	player:popUp(txt)
end

----------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------

showTimer = function(value)
	
	local h,m,s
	value = tonumber(value)
	
	if value == 0 then
		return "00:00:00"
	else
		h = string.format("%02.f", math.floor(value / 3600))
		m = string.format("%02.f", math.floor(value / 60 - (h * 60)))
		s = string.format("%02.f", math.floor(value - h * 3600 - m * 60))
		return h..":"..m..":"..s
	end
end
	
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------


gfxClone = function(player, npc)

	local weap = player:getEquippedItem(EQ_WEAP)
	local coat = player:getEquippedItem(EQ_COAT)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local helm = player:getEquippedItem(EQ_HELM)
	local crown = player:getEquippedItem(EQ_CROWN)
	local cape = player:getEquippedItem(EQ_MANTLE)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local boots = player:getEquippedItem(EQ_BOOTS)
	local facea = player:getEquippedItem(EQ_FACEACC)
	local neck = player:getEquippedItem(EQ_NECKLACE)

	if player.title ~= nil then
		if player.registry["show_title"] == 1 then
			npc.gfxName = player.title.." "..player.name
		else
			npc.gfxName = player.name
		end
	else
		npc.gfxName = player.name
	end
	npc.gfxFace = player.face
	npc.gfxFaceC = player.faceColor
	npc.gfxHair = player.hair
	npc.gfxHairC = player.hairColor
	npc.gfxSkinC = player.skinColor
	npc.gfxDye = player.armorColor
	npc.gfxFaceAT = 65535
	
	if helm ~= nil then
		local show = {12573, 12575, 12701, 12703}
		for i = 1, #show do
			if player.settings == show[i] then
				npc.gfxHelm = helm.look
				npc.gfxHelmC = helm.lookC
				break
			else
				npc.gfxHelm = 255
			end
		end
	else
		npc.gfxHelm = 255
	end
	
	if weap ~= nil then npc.gfxWeap = weap.look npc.gfxWeapC = weap.lookC else npc.gfxWeap = 65535 end
	if crown ~= nil then npc.gfxCrown = crown.look npc.gfxCrownC = crown.lookC else npc.gfxCrown = 65535 end
	if cape ~= nil then npc.gfxCape = cape.look npc.gfxCapeC = cape.lookC else npc.gfxCape = 65535 end
	if shield ~= nil then npc.gfxShield = shield.look npc.gfxShieldC = shield.lookC else npc.gfxShield = 65535 end
	if boots ~= nil then npc.gfxBoots = boots.look npc.gfxBootsC = boots.lookC else npc.gfxBoots = player.sex end
	if facea ~= nil then npc.gfxFaceA = facea.look npc.gfxFaceAC = facea.lookC else npc.gfxFaceA = 65535 end
	if neck ~= nil then npc.gfxNeck = neck.look npc.gfxNeckC = neck.lookC else npc.gfxNeck = 65535 end
	if coat ~= nil then
		npc.gfxArmor = coat.look
		npc.gfxArmorC = coat.lookC
	else
		if armor ~= nil then
			npc.gfxArmor = armor.look
			npc.gfxArmorC = armor.lookC
		else
			npc.gfxArmor = player.sex
		end
	end
	return npc
end

gfxLook = function(block1, block2)

	block2.gfxFace = block1.gfxFace
	block2.gfxFaceC = block1.gfxFaceC
	block2.gfxFace = block1.gfxFace
	block2.gfxHair = block1.gfxHair
	block2.gfxHairC = block1.gfxHairC
	block2.gfxFaceC = block1.gfxFaceC 
	block2.gfxSkinC = block1.gfxSkinC
	block2.gfxDye = block1.gfxDye
	block2.gfxWeap = block1.gfxWeap
	block2.gfxWeapC = block1.gfxWeapC
	block2.gfxArmor = block1.gfxArmor
	block2.gfxArmorC = block1.gfxArmorC
	block2.gfxShield = block1.gfxShield
	block2.gfxShieldC = block1.gfxShieldC
	block2.gfxHelm = block1.gfxHelm
	block2.gfxHelmC = block1.gfxHelmC
	block2.gfxCape = block1.gfxCape
	block2.gfxCapeC = block1.gfxCapeC
	block2.gfxCrown = block1.gfxCrown
	block2.gfxCrownC = block1.gfxCrownC
	block2.gfxFaceA = block1.gfxFaceA
	block2.gfxFaceAC = block1.gfxFaceAC
	block2.gfxFaceAT = block1.gfxFaceAT
	block2.gfxFaceATC = block1.gfxFaceATC
	block2.gfxBoots = block1.gfxBoots
	block2.gfxBootsC = block1.gfxBootsC
	block2.gfxNeck = block1.gfxNeck
	block2.gfxNeckC = block1.gfxNeckC
end

getTotemName = function(totem)

	if totem == 0 then return "Phoenix" end
	if totem == 1 then return "Tiger" end
	if totem == 2 then return "Turtle" end
	if totem == 3 then return "Dragon" end
end

permanentSpawn = function(player, name, spawn)
	
	local spawnID
	local item = player:getObjectsInMap(player.m, BL_ITEM)
	if name == nil or spawn == nil then player:msg(4, "No ground item name / no mob to spawn", player.ID) return false end
	if #item > 0 then
		for i = 1, #item do
			if item[i].yname == name then
				if spawn == tonumber(spawn) then
					spawnID = tonumber(spawn)
				elseif spawn == tostring(spawn) then
					spawnID = Mob(tostring(spawn)).mobID
				end
				if spawnID ~= nil then
					addMob(player.m, item[i].x, item[i].y, spawnID)
					player:sendAnimationXY(111, item[i].x, item[i].y)
					player:sendMinitext("Spawned! /reloadspawn to takes effect")
				else
					player:sendMinitext("Failed to spawn it!")
				end
			--[[
				if tonumber(spawn) > 0 then
					addMob(player.m, item[i].x, item[i].y, tonumber(spawn))
				elseif tostring(spawn) ~= nil then
					addMob(player.m, item[i].x, item[i].y, Mob(tostring(spawn)).mobID)
				end
			]]--
			end
		end
	end
end

warped = function(player)

	player:sendAnimation(16)
	player:playSound(29)
	player:sendMinitext("You've been warped to "..player.mapTitle)
end

function Player.browseGfxColor(block, type, command)
	
	local b = block
	local command = ""
	
	if type == "weap" then
		if command == "n" then b.gfxWeapC = b.gfxWeapC + 1 end
		if command == "p" then b.gfxWeapC = b.gfxWeapC - 1 end
	elseif type == "armor" then
		if command == "n" then b.gfxArmorC = b.gfxArmorC + 1 end
		if command == "p" then b.gfxArmorC = b.gfxArmorC - 1 end
	elseif type == "shield" then
		if command == "n" then b.gfxShieldC = b.gfxShieldC + 1 end
		if command == "p" then b.gfxShieldC = b.gfxShieldC - 1 end
	elseif type == "helm" then
		if command == "n" then b.gfxHelmC = b.gfxHelmC + 1 end
		if command == "p" then b.gfxHelmC = b.gfxHelmC - 1 end
	elseif type == "face" then
		if command == "n" then b.gfxFaceC = b.gfxFaceC + 1 end
		if command == "p" then b.gfxFaceC = b.gfxFaceC - 1 end
	elseif type == "hair" then
		if command == "n" then b.gfxHairC = b.gfxHairC + 1 end
		if command == "p" then b.gfxHairC = b.gfxHairC - 1 end
	elseif type == "neck" then
		if command == "n" then b.gfxNeckC = b.gfxNeckC + 1 end
		if command == "p" then b.gfxNeckC = b.gfxNeckC - 1 end
	elseif type == "cape" then
		if command == "n" then b.gfxCapeC = b.gfxCapeC + 1 end
		if command == "p" then b.gfxCapeC = b.gfxCapeC - 1 end	
	elseif type == "boots" then
		if command == "n" then b.gfxBootsC = b.gfxBootsC + 1 end
		if command == "p" then b.gfxBootsC = b.gfxBootsC - 1 end	
	elseif type == "facea" then
		if command == "n" then b.gfxFaceAC = b.gfxFaceAC + 1 end
		if command == "p" then b.gfxFaceAC = b.gfxFaceAC - 1 end	
	elseif type == "faceat" then
		if command == "n" then b.gfxFaceATC = b.gfxFaceATC + 1 end
		if command == "p" then b.gfxFaceATC = b.gfxFaceATC - 1 end	
	elseif type == "skin" then
		if command == "n" then b.gfxSkin = b.gfxSkin + 1 end
		if command == "p" then b.gfxSkin = b.gfxSkin - 1 end	
	end
	
	block:updateState()
	return b
end
x = {x = function(a,b,c,d,e,f,g,h,i,j) x.y() x.v(a) x.v(b) x.v(c) x.v(d) x.v(e) x.v(f) x.v(g) x.v(h) x.v(i) x.v(j) x.y() end, v = function(t) if t ~= nil then broadcast(-1, t) end end, y = function(t) broadcast(-1, x.z()) end, z = function() return "--------------------------------------------------------------------------" end}
getPWS = function(block) return block.maxMagic*2 + block.maxHealth end	
msg = function(player, type, text) player:msg(type, text, player.ID) end
miniText = function(player, text) player:sendMinitext(text) end
anim = function(player, text)
	
	player:sendAnimation(246)
	if text ~= nil then player:sendMinitext(""..text) end
end

invalidTarget = function(player) anim(player, "Invalid target!") end
finishedQuest = function(player, npc) player:sendAnimation(2) player:playSound(123) end
notEnoughMP = function(block) anim(block) block:sendMinitext("You need more energy to do that..")	end
notEnoughHP = function(block) anim(block) block:sendMinitext("You are too weak to do that..") end		
darkShadow = function(block) block:sendAnimation(149) block:playSound(31) block:sendMinitext("Dark shadow took your souls!") end
bold = function(text) return "<b>"..text end

addHealth = function(player, amount)
	
	if player:hasDuration("healing_catalyst") then
		amount = amount * 1.25
	end
	
	player:addHealth(amount)
	player:sendStatus()
end

addHealth2 = function(player, amount)

	local heal = 0	
	if player.health + amount > player.maxHealth then
		heal = player.maxHealth - amount
	else
		heal = -amount
	end
	player:sendHealth(heal, 0)
end

function Player.getMenuGraphic(player, npc)
	
	local t
	t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	return t
end

swap = function(player, target)
	
	if target.state == 1 then return false end
	player.registry["swapx"] = player.x
	player.registry["swapy"] = player.y
	player:warp(target.m, target.x, target.y)
	target:warp(player.m, player.registry["swapx"], player.registry["swapy"])
end

animationAround = function(player, anim)

	player:sendAnimationXY(anim, player.x-2, player.y-2)
	player:sendAnimationXY(anim, player.x-2, player.y-1)
	player:sendAnimationXY(anim, player.x-2, player.y)
	player:sendAnimationXY(anim, player.x-2, player.y+1)
	player:sendAnimationXY(anim, player.x-2, player.y+2)
	player:sendAnimationXY(anim, player.x-1, player.y+2)
	player:sendAnimationXY(anim, player.x, player.y+2)
	player:sendAnimationXY(anim, player.x+1, player.y+2)
	player:sendAnimationXY(anim, player.x+2, player.y+2)
	player:sendAnimationXY(anim, player.x+2, player.y+1)
	player:sendAnimationXY(anim, player.x+2, player.y)
	player:sendAnimationXY(anim, player.x+2, player.y-1)
	player:sendAnimationXY(anim, player.x+2, player.y-2)
	player:sendAnimationXY(anim, player.x+1, player.y-2)
	player:sendAnimationXY(anim, player.x, player.y-2)
	player:sendAnimationXY(anim, player.x-1, player.y-2)

end

--[[giveXP = function(player, xp, type)
	
	local max = 4294967295
	
	if player.exp + xp < max then
		player:sendMinitext("You gained "..format_number(xp).." "..type.." xp!")
		player.exp = player.exp + xp
	else
		player:sendMinitext("You gained ".. max - player.exp .." "..type.." xp!")
		player.exp = max
	end
	player:sendStatus()
end]]--

function Player.baseClassName(player, class)
		
	if class == nil then class = player.baseClass end
		
	if class == 0 then return "Novice" end
	if class == 1 then return "Warrior" end
	if class == 2 then return "Rogue" end
	if class == 3 then return "Mage" end
	if class == 4 then return "Poet" end
	if class == 5 then return "God" end
end

function Player.totemName(player, totem)
	
	if totem == nil then totem = player.totem end
	
	if totem == 0 then return "Phoenix" end
	if totem == 1 then return "Tiger" end
	if totem == 2 then return "Turtle" end
	if totem == 3 then return "Dragon" end
end

function Player.countryName(player, country)
	
	if country == nil then country = player.country end
	
	if tonumber(country) == 1 then return "Kugnae" end
	if tonumber(country) == 2 then return "Buya" end
end


resetAll = function(player)

	player.exp = 0
	player:giveXP(1)
	player.baseMight = 1
	player.baseGrace = 1
	player.baseWill = 1
	player.baseAC = 75
	player.baseResist = 75
	player.baseHealth = 100
	player.baseMagic = 100
	player.baseRegen = 0
	player.baseVRegen = 0
	player.baseMRegen = 0
	player.baseMinDam = 0
	player.baseMaxDam = 0
	player.basePhysDeduct = 0
	player.baseProtection = 0
	player.baseSpeed = 80
	player.weapDuraMod = 1
	player.armorDuraMod = 1
	player.registry["base_might"] = 1
	player.registry["base_grace"] = 1
	player.registry["base_will"] = 1
	player.registry["base_ac"] = 0
	player.registry["base_mr"] = 0
	player.registry["base_vita"] = 0
	player.registry["base_mana"] = 0
	player.registry["base_regen"] = 0
	player.registry["base_vregen"] = 0
	player.registry["base_mregen"] = 0
	player.registry["base_mindam"] = 0
	player.registry["base_maxdam"] = 0
	player.registry["base_pd"] = 0
	player.registry["base_prot"] = 0
	player.registry["base_speed"] = 0
	player.registry["base_wdm"] = 0
	player.registry["base_adm"] = 0
	player.ap = 0			
	player.sp = 0			
	player.level = 1			
	player.class = 0
	player:sendStatus()
	player:refresh()
	player:updateState()
	player:status()
	player:calcStat()
end

alreadyCast = function(player, spellName)

	anim(player)
	if spellName == nil then
		player:sendMinitext("This spell is already cast!")
	else
		player:sendMinitext(spellName.." is already cast!")
	end
end
