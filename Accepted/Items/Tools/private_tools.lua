private_tools = {

click = function(player, npc)

	if player.gfxClone == 0 then clone.equip(player, npc) else clone.gfx(player, npc) end
	player.lastClick = npc.ID
	player.dialogType = 2
	
	local name, txt = "<b>[Status ON]\n\n", ""
	local opts = {}
	
	if player.registry["can_be_push"] == 0 then    table.insert(opts, "Push       : ON") else table.insert(opts, "Push       : OFF") end
	if player.registry["click_by"]  == 0 then      table.insert(opts, "Click      : ON") else table.insert(opts, "Click      : OFF") end
	if player.registry["being_summon"] == 0 then   table.insert(opts, "Summon     : ON") else table.insert(opts, "Summon     : OFF") end
	if player.registry["being_approach"] == 0 then table.insert(opts, "Approach   : ON") else table.insert(opts, "Approach   : OFF") end	
	if player.registry["immortal"] == 0 then       table.insert(opts, "Immortality: ON") else table.insert(opts, "Immortality: OFF") end

	if player.registry["click_by"] == 1 then       txt = txt.."- Click\n"       end
	if player.registry["being_approach"] == 1 then txt = txt.."- Approach\n"    end
	if player.registry["being_summon"] == 1 then   txt = txt.."- Summon\n"      end
	if player.registry["can_be_push"] == 1 then    txt = txt.."- Push\n"        end
	if player.registry["immortal"] == 1 then       txt = txt.."- Immortality\n" end

	-- if player.registry["click_by"] == 0 then       txt =      "Click       : OFF \n" else txt =      "Click       : ON \n" end
	-- if player.registry["being_approach"] == 0 then txt = txt.."Approach    : OFF \n" else txt = txt.."Approach    : ON \n" end
	-- if player.registry["being_summon"] == 0 then   txt = txt.."Summon      : OFF \n" else txt = txt.."Summon      : ON \n" end
	-- if player.registry["can_be_push"] == 0 then    txt = txt.."Push        : OFF \n" else txt = txt.."Push        : ON \n" end	
	-- if player.registry["immortal"] == 0 then       txt = txt.."Immortality : OFF \n" else txt = txt.."Immortality : ON \n" end
	
	menu = player:menuSeq(name..""..txt, opts, {})
	
	if menu ~= nil then
		if menu == 1 then
			switchReg(player, "can_be_push", 0, 1)
		elseif menu == 2 then
			switchReg(player, "click_by", 0, 1)
		elseif menu == 3 then
			switchReg(player, "being_summon", 0, 1)
		elseif menu == 4 then
			switchReg(player, "being_approach", 0, 1)
		elseif menu == 5 then
			switchReg(player, "immortal", 0, 1)
		end
		private_tools.click(player, npc)
	end
end
}