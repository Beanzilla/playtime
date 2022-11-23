
-- Long format
minetest.register_chatcommand("playtime", {
    privs = {
        shout = true
    },
    description = "Displays you, or a given playername's total playtime. (In a long format)",
    func = function(name, param)
        if param == "" then
            param = name
        end
        --[[if minetest.get_player_by_name(param) == nil then
            return false, "Player not found."
        end]]
        local struct = playtime.get(param)
        if struct.session == 0 and struct.total == 0 then
            return false, "Player not found."
        end
        -- Nice long format
        return true, playtime.str_format(playtime.format(struct.total))
    end,
})

-- Short format
minetest.register_chatcommand("pt", {
    privs = {
        shout = true
    },
    description = "Displays you, or a given playername's total playtime. (In a short format)",
    func = function(name, param)
        if param == "" then
            param = name
        end
        --[[if minetest.get_player_by_name(param) == nil then
            return false, "Player not found."
        end]]
        local struct = playtime.get(param)
        if struct.session == 0 and struct.total == 0 then
            return false, "Player not found."
        end
        -- Nice short format
        return true, playtime.short_str_format(playtime.format(struct.total))
    end,
})