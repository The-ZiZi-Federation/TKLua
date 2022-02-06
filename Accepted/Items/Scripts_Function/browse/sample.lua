
sample = {

click = async(function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.lastClick = npc.ID
	player.dialogType = 2

	local opts = {}
	--table.insert(opts, "Action")
	table.insert(opts, "Change GFX Look")
	table.insert(opts, "Remote Control")
	table.insert(opts, "Reset GFX Look")
	
	menu = player:menuString("<b>["..npc.name.."]\n\nWhat to do?", opts)
	
	if menu == "Action" then
		sample.actionn(player, npc)
	elseif menu == "Remote Control" then
		sample.control(player, npc)
	elseif menu == "Change GFX Look" then
		sample.change(player, npc)
	elseif menu == "Reset GFX Look" then
		sample.reset(player, npc)
	end
end),

action = function(player, npc)

	if npc.gfxClone == 0 then
		gfx.equip(npc, npc)
		npc.gfxClone = 1
		npc:updateState()
		return
	end
end,

control = function(player, npc)

	local opts = {"Up", "Right", "Left", "Down"}
	menu = player:menuString("<b>["..npc.name.."]\n\nMove to?", opts)
	
	if menu ~= nil then
		if menu == "Up" then
			npc.side = 0
		elseif menu == "Right" then
			npc.side = 1
		elseif menu == "Left" then
			npc.side = 3
		elseif menu == "Down" then
			npc.side = 2
		end
		npc:sendSide()
		npc:move()
		sample.control(player, npc)
	end
end,
	
change = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.lastClick = npc.ID
	player.dialogType = 2
	
	local opts = {}
	table.insert(opts, "Face       : "..npc.gfxFace)
	table.insert(opts, "Hair       : "..npc.gfxHair)
	table.insert(opts, "Skin       : "..npc.gfxSkinC)
	table.insert(opts, "Armor      : "..npc.gfxArmor)
	table.insert(opts, "Weapon     : "..npc.gfxWeap)
	table.insert(opts, "Shield     : "..npc.gfxShield)
	table.insert(opts, "Helm       : "..npc.gfxHelm)
	table.insert(opts, "Crown      : "..npc.gfxCrown)
	table.insert(opts, "Cape       : "..npc.gfxCape)
	table.insert(opts, "Face acc 1 : "..npc.gfxFaceA)
	table.insert(opts, "Face acc 2 : "..npc.gfxFaceAT)
	table.insert(opts, "Boots      : "..npc.gfxBoots)
	table.insert(opts, "Neck       : "..npc.gfxNeck)

	menu = player:menuString("<b>["..npc.name.."]\n\n", opts)
	
	if menu == "Face       : "..npc.gfxFace then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "face")
	elseif menu == "Hair       : "..npc.gfxHair then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "hair")
	elseif menu == "Skin       : "..npc.gfxSkinC then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "skin")
	elseif menu == "Armor      : "..npc.gfxArmor then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "armor")
	elseif menu == "Weapon     : "..npc.gfxWeap then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "weapon")
	elseif menu == "Shield     : "..npc.gfxShield then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "shield")
	elseif menu == "Helm       : "..npc.gfxHelm then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "helm")
	elseif menu == "Crown      : "..npc.gfxCrown then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "crown")
	elseif menu == "Cape       : "..npc.gfxCape then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "cape")
	elseif menu == "Face acc 1 : "..npc.gfxFaceA then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "facea")
	elseif menu == "Face acc 2 : "..npc.gfxFaceAT then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "faceat")
	elseif menu == "Boots      : "..npc.gfxBoots then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "boots")
	elseif menu == "Neck       : "..npc.gfxNeck then 
		sample.input(player, npc, "<b>"..menu.."\n\nChange to?", "neck")
	end
end,

input = function(player, npc, text, type)
	
	local type = string.lower(type)
	
	if type == nil then return false else
		num = tonumber(math.abs(math.floor(player:input(text..""))))
		if num <= 0 or num > 65535 then val = 65535 else
			if type == "face" then
				if num <= 200 then num = 200 end
				npc.gfxFace = num
			end
			if type == "hair" then npc.gfxHair = num end
			if type == "skin" then npc.gfxSkinC = num end 
			if type == "armor" then npc.gfxArmor = num end
			if type == "weapon" then npc.gfxWeap = num end
			if type == "shield" then npc.gfxShield = num end
			if type == "helm" then npc.gfxHelm = num end
			if type == "crown" then npc.gfxCrown = num end
			if type == "cape" then npc.gfxCape = num end
			if type == "facea" then npc.gfxFaceA = num end
			if type == "faceat" then npc.gfxFaceAT = num end
			if type == "boots" then npc.gfxBoots = num end
			if type == "neck" then npc.gfxNeck = num end
		end
		npc:updateState()
		sample.change(player, npc)
		player:sendMinitext("Done!!")
	end
end,

reset = function(player, npc)

	npc.gfxFace = 200
	npc.gfxHair = npc.hair
	npc.gfxWeap = 65535
	npc.gfxArmor = npc.sex
	npc.gfxCrown = 65535
	npc.gfxHelm = 255
	npc.gfxCape = 65535
	npc.gfxShield = 65535
	npc.gfxBoots = npc.sex
	npc.gfxSkinC = 0
	npc.gfxFaceA = 65535
	npc.gfxFaceAT = 65535
	npc.gfxNeck = 65535
	npc.gfxClone = 1
	npc:updateState()
	npc:sendAnimation(16)
	npc:talk(2, "RESET DONE!")
	player:freeAsync()
	sample.click(player, npc)
end,

browseGFX = function(player, npc, type)
	
	if type == "face" then
		if npc.gfxFace <= 200 then
			player:msg(4, "Minimum "..type.." number #"..npc.gfxFace)

		elseif npc.gfxFace > 238 then
			player:msg(4, "Maximum "..type.." number #"..npc.gfxFace)
		end
	end
	if type == "hair" then
		if npc.gfxHair == 152 then
			npc.gfxHair = 0
		elseif npc.gfxHair < 0 then
			npc.gfxHair = 151
		end
	end
	if type == "armor" then
		if npc.gfxArmor <= 0 then
			npc.gfxArmor = 10355
		elseif npc.gfxArmor == 350 then 
			npc.gfxArmor = 10000
		elseif npc.gfxArmor == 10356 then
			npc.gfxArmor = 0
		end
	end
	if type == "weapon" then
		if npc.gfxWeap == 386 then
			npc.gfxWeap = 10000
		elseif npc.gfxWeap < 10000 then
			npc.gfxWeap = 0
		elseif npc.gfxWeap > 10122 then
			npc.gfxWeap = 65535
		end
	end
	
	if type == "skin" then
		npc.gfxSkinC = 0
	end
	
	if type == "shield" then npc.gfxShield = num end
	if type == "helm" then npc.gfxHelm = num end
	if type == "crown" then npc.gfxCrown = num end
	if type == "cape" then npc.gfxCape = num end
	if type == "facea" then npc.gfxFaceA = num end
	if type == "faceat" then npc.gfxFaceAT = num end
	if type == "boots" then npc.gfxBoots = num end
	if type == "neck" then npc.gfxNeck = num end
end
}