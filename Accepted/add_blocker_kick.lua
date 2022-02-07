add_blocker_kick = {
	cast = function(player)
		local t = {graphic = convertGraphic(1, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = {"Yes", "No"}

		--	menu = player:menuString("Hello. Add a blocker to this coordinate?\nMap: "..player.m.."  X: "..player.x.."  Y: "..player.y.."", opts)

		--	if menu == "Yes" then

		--id = tonumber(player:input("What is the NPC ID? (DON'T FUCK THIS UP!!!)"))
		local m, x, y = player.m, player.x, player.y
		local luasql = require "luasql.mysql"

		DBHOST = "localhost" or "127.0.0.1"
		DBNAME = "MornaTales"
		DBUSER = "root"
		DBPASS = "mr211988"

		env = assert(luasql.mysql())
		db_connection = env:connect(DBNAME, DBUSER, DBPASS, DBHOST)
		query =
			"INSERT INTO `NPCs` (`NpcIdentifier`, `NpcDescription`, `NpcType`, `NpcMapId`, `NpcX`, `NpcY`, `NpcTimer`, `NpcLook`, `NpcLookColor`, `NpcSex`, `NpcSide`, `NpcState`, `NpcFace`, `NpcFaceColor`, `NpcHair`, `NpcHairColor`, `NpcSkinColor`, `NpcIsChar`) VALUES ('door_blocker', 'Door Blocker', 2, " ..
			m .. ", " .. x .. ", " .. y .. ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)"
		check = db_connection:execute(query .. "")
		db_connection:close()
		env:close()

		player:talk(0, "Door Blocker Kick added at Map: " .. m .. "| X: " .. x .. "| Y: " .. y)
		player:popUp("Door Blocker Kick added at Map: " .. m .. "| X: " .. x .. "| Y: " .. y)
		--	end
	end
}
