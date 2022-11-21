
local interval = 0.0
minetest.register_globalstep(function(dtime)
    interval = interval + dtime
    if interval > 1.0 then -- Occur ever second
        -- Collect online players
        for idx, player in ipairs(minetest.get_connected_players()) do
            local pname = player:get_player_name()
            local struct = playtime.get(pname)
            struct.total = struct.total + math.floor(interval/1.0)
            struct.session = struct.session + math.floor(interval/1.0)
            playtime.set(pname, struct)
        end
        interval = 0.0
    end
end)

-- Hook on login event to reset session time
minetest.register_on_joinplayer(function(player, laston)
    local pname = player:get_player_name()
    local struct = playtime.get(pname)
    struct.session = 0
    playtime.set(pname, struct)
end)
