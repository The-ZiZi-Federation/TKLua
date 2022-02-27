minigame_running_check = function()


if (core.gameRegistry["bomber_war_playing"] == 1 or core.gameRegistry["bomber_war_start"] ~= 0) then return true end

if (core.gameRegistry["beach_war_open"] == 1 or core.gameRegistry["beach_war_started"] == 1 or core.gameRegistry["beach_war_start_time"] ~= 0) then return true end

if (core.gameRegistry["elixir_war_open"] == 1 or core.gameRegistry["elixir_war_started"] == 1 or core.gameRegistry["elixir_war_start_time"] ~= 0) then return true end

if (core.gameRegistry["freeze_war_open"] == 1 or core.gameRegistry["freeze_war_started"] == 1 or core.gameRegistry["freeze_war_start_time"] ~= 0) then return true end

if (core.gameRegistry["sumo_war"] == 1 or core.gameRegistry["sumo_war_playing"] == 1 or core.gameRegistry["sumo_war_start"] ~= 0) then return true end



end