
kill = {

cast = function(player, target)

	if target ~= nil then
		target:removeHealth(target.health)
	end
end
}

