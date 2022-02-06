

element = {

getWeaponElement = function(player)
	
	local element = 0
	local var = {"[Fire]", "[Water]", "[Wood]", "[Metal]", "[Earth]", "[Light]", "[Dark]"}
	local weap = player:getEquippedItem(EQ_WEAP)
	
	if weap ~= nil then
		if string.match(weap.realName, "(.+) "..weap.name) ~= nil then
			str = string.match(weap.realName, "(.+) "..weap.name)
			for i = 1, #var do
				if str == var[i] then
					element = i
					break
				end
			end
		end
	end
	return element
end,

percentage = function(block, target)
	
	local x = ""
	local var = {}
	
	if target == 0 then
		if block == 0 then x = "100%" else x = "120%" end
	else
		if block == 1 then var = {"65%", "20%", "150%", "125%", "50%", "80%", "80%"} end
		if block == 2 then var = {"150%", "65%", "20%", "125%", "50%", "80%", "80%"} end
		if block == 3 then var = {"50%", "150%", "65%", "20%", "125%", "80%", "80%"} end
		if block == 4 then var = {"50%", "50%", "150%", "65%", "20%", "80%", "80%"} end
		if block == 5 then var = {"125%", "125%", "80%", "150%", "65%", "80%", "80%"} end
		if block == 6 then var = {"80%", "80%", "80%", "80%", "80%", "50%", "200%"} end
		if block == 7 then var = {"80%", "80%", "80%", "80%", "80%", "200%", "50%"} end
		if #var > 0 then x = var[target] end
	end
	return x
end,

getDamage = function(block, target, damage)
	
	local weap = block:getEquippedItem(EQ_WEAP)
	local d = math.ceil(damage)
	local var = {}
	
	if target ~= nil and weap ~= nil then
		if target.blType == BL_MOB then
			--target:sendAnimation(300)
			if target.element == 8 then
				d = d
			elseif target.element == 9 then
				if weap.element == 0 then d = d else d = d*1.2 end
			elseif target.element == 0 then
				if weap.element == 0 then d = d else d = d*1.2 end
			else
				if weap.element == 1 then var = {d*.65,d*.2,d*1.5,d*1.25,d*.5, d*.8,d*.8} end
				if weap.element == 2 then var = {d*1.5,d*.65,d*.2,d*1.25,d*.5, d*.8,d*.8} end
				if weap.element == 3 then var = {d*.5,d*1.5,d*.65,d*.2,d*1.25, d*.8,d*.8} end
				if weap.element == 4 then var = {d*.5,d*.5,d*1.5,d*.65,d*.2,d*.8,d*.8} end
				if weap.element == 5 then var = {d*1.25,d*1.25,d*.8,d*1.5,d*.65,d*.8,d*.8} end
				if weap.element == 6 then var = {d*.8,d*.8,d*.8,d*.8,d*.8,d*.5,d*2} end
				if weap.element == 7 then var = {d*.8,d*.8,d*.8,d*.8,d*.8,d*2,d*.5} end
				if #var > 0 then d = var[target.element] end
			end
			
	--		x, xx = "", ""
	--		if math.ceil(d) > math.ceil(damage) then
	--			x, xx = "+", format_number(math.ceil(d-damage))
	--		elseif math.ceil(d) < math.ceil(damage) then
	--			x, xx = "-", format_number(math.ceil(damage-d))
	--		end
	--		percentage = element.percentage(weap.element, target.element)
	--		block:talk(0, "["..element.name(weap.element).." vs "..element.name(target.element).."] -> "..format_number(math.ceil(damage)).." ["..x.." "..xx.."] = "..format_number(math.ceil(d)).." ("..percentage..")")
	--		block:talk(0, "["..element(weap.element).." vs "..element(target.element).."] -> dmg = "..format_number(math.ceil(damage)).." -> ["..format_number(math.ceil(d)).."]")
		end
	end
	return d
end,

name = function(num)

	if num == 0 then return "Neutral" end
	if num == 1 then return "Fire" end
	if num == 2 then return "Water" end
	if num == 3 then return "Wood" end
	if num == 4 then return "Metal" end
	if num == 5 then return "Earth" end
	if num == 6 then return "Light" end
	if num == 7 then return "Dark" end
	if num == 8 then return "Physical" end
	if num == 9 then return "Magical" end
end
}