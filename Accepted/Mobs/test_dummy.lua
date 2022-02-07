testing_box = {
	on_attacked = function(mob, attacker) --
		--[[
	mob:talk(0,"yname: "..mob.yname)
	mob:talk(0,"name: "..mob.name)
	mob:talk(0,"common: "..mob.commonScript)
	mob:talk(0,"ID: "..mob.ID)
	mob:talk(0,"MobID: "..mob.mobID)
	mob:talk(0,"Behavior: "..mob.behavior)
	mob:talk(0,"AI: "..mob.aiType)
--	mob:talk(0,"ischar: "..mob.ischar)
--	mob:talk(0,"isnpc: "..mob.isNPC)
	mob:talk(0,"look: "..mob.look)
	mob:talk(0,"lookcc: "..mob.lookColor)
	mob:talk(0,"exp: "..mob.experience)
	mob:talk(0,"Vita: "..mob.health)
	mob:talk(0,"Mana: "..mob.magic)
	mob:talk(0,"hit: "..mob.hit)
	mob:talk(0,"dam: "..mob.damage)
	mob:talk(0,"level: "..mob.level)
	mob:talk(0,"mark: "..mob.mark)
	mob:talk(0,"mindam: "..mob.minDam)
	mob:talk(0,"maxdam: "..mob.maxDam)
	mob:talk(0,"move: "..mob.baseMove)
	mob:talk(0,"attack: "..mob.baseAttack)
	mob:talk(0,"spawntime: "..mob.spawnTime)
	
	mob:talk(0,"might: "..mob.might)
	mob:talk(0,"grace: "..mob.grace)
	mob:talk(0,"will: "..mob.will)
--	mob:talk(0,"wisdom: "..mob.wis)
--	mob:talk(0,"con: "..mob.con)
	mob:talk(0,"protection: "..mob.protection)
	mob:talk(0,"armor: "..mob.armor)
--	mob:talk(0,"sound: "..mob.sound)
--	mob:talk(0,"sex: "..mob.sex)
--	mob:talk(0,"face: "..mob.face)
--	mob:talk(0,"facecolor: "..mob.faceColor)
--	mob:talk(0,"hair: "..mob.hair)
--	mob:talk(0,"haircolor: "..mob.hairColor)
--	mob:talk(0,"skincolor: "..mob.skinColor)
	mob:talk(0,"state: "..mob.state)
	mob:talk(0,"element: "..mob.element)
	mob:talk(0,"physical: "..mob.physical)
	mob:talk(0,"magical: "..mob.magical)
	--mob:talk(0,": "..mob.sound)
]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end
}

testing_dummy = {
	move = function(mob)
		local armor = mob.armor
		local armorPhysReduction = round((armor / (armor + 510)), 2) -- gives a max of 66% absorb at 999 points

		local will = mob.will
		local willMagReduction = round((will / (will + 1000)), 2)
		--mob:talk(2, "Armor: "..armor.." Will: "..will)
		--mob:talk(2, "Armor: "..armor.." Phys % Redx: "..armorPhysReduction.." Will: "..will.." Mag % Redx: "..willMagReduction.."")
		if mob.side ~= 2 then
			mob.side = 2
			mob:sendSide()
		end
	end,
	on_attacked = function(mob, attacker)
		local weap = attacker:getEquippedItem(0)
		local weapID = weap.id

		local rand = math.random(1, 3)
		 --
		--[[	
	if rand == 1 then
		mob:talk(2, "FLARE!!!....")
		flare.cast(mob, attacker)
		return
	end
	if rand == 2 then
		mob:talk(2, "SNOWSTORM!!!....")
		snowstorm.cast(mob, attacker)
		return
	end
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end
}

big_bat = {
	on_attacked = function(mob, attacker)
		local rand = math.random(1, 4)
		mob:talk(2, "Rand: " .. rand)
		--	if rand == 1 then
		--	--	flare.cast(mob, attacker)
		--		return
		--	end
		mob_ai_basic.on_attacked(mob, attacker)
	end
}
