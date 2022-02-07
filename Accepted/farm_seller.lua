script_tester_old = {
	click = async(
		function(player, npc)
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = {"Yes", "No"}

			menu = player:menuString("Hello. Are you interested in owning a farm?", opts)

			if menu == "Yes" then
				local id = 60000 + player.id
				local name = player.name

				local luasql = require "luasql.mysql"

				DBHOST = "localhost" or "127.0.0.1"
				DBNAME = "MornaTales"
				DBUSER = "root"
				DBPASS = "mr211988"

				env = assert(luasql.mysql())
				db_connection = env:connect(DBNAME, DBUSER, DBPASS, DBHOST)
				query =
					"INSERT INTO `Maps` (`MapId`, `MapName`, `MapBGM`, `MapPvP`, `MapSpells`, `MapLight`, `MapWeather`, `MapSweepTime`, `MapChat`, `MapGhosts`, `MapRegion`, `MapIndoor`, `MapWarpout`, `MapBind`, `MapFile`, `MapAfk`, `MapSpecial`) VALUES (" ..
					id ..
						", '" .. name .. "''s Farm', 0, 0, 0, 0, 0, 1800000, 0, 0, 201, 0, 0, 0, 'end/farm_lands/first_farm.map', 0, 0)"
				check = db_connection:execute(query .. "")
				db_connection:close()
				env:close()
				player:popUp("Farm has been created!")
			end
		end
	)
}
