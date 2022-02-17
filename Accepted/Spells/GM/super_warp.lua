super_warp = {
    cast = function(player)
        local t = {graphic = convertGraphic(1, "monster")}
        player.npcGraphic = t.graphic
        player.npcColor = t.color
        player.dialogType = 0
        local spellName = "<b>[Super Warp!]\n\n"
        local mapList = {}

        player:sendMinitext("Super WARP!!")

        local m, x, y = player.m, player.x, player.y
        local luasql = require "luasql.mysql"

        env = assert(luasql.mysql())
        db_connection =
            env:connect(database_opts.DBNAME, database_opts.DBUSER, database_opts.DBPASS, database_opts.DBHOST)
        query = "SELECT MapId, MapName FROM Test.Maps;"

        cursor, errorString = db_connection:execute(query .. "")
        row = cursor:fetch({}, "a")
        while row do
            table.insert(mapList, row)
        end
        db_connection:close()
        env:close()

        local choice = player:menuString(spellName .. "Where to Boss?", mapList)
        player:sendMinitext(choice)
    end
}
