extendedTools = {
	menu = function(player, npc)
		local name = "<b>[GM - Extended Tools]\n\n"
		player.dialogType = 2
		local opts = {}
		table.insert(opts, "Remote Control")
		table.insert(opts, "Snoop Chat")

		menu = player:menuString(name .. "These options are availbale on several GM only! Please use it wisely", opts)

		if menu == "Remote Control" then
			extendedTools.remote(player, npc)
		elseif menu == "Snoop Chat" then
			snoop.menu(player, npc, target)
		end
	end,
	remote = function(player, npc)
		local opts = {}
		table.insert(opts, "Move")
	end
}
