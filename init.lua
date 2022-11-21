
playtime = {
    VERSION = "v1.0",
    store = minetest.get_mod_storage(),
    huds = {}, -- playername, hud id (Used to show current session and total time)
}

if minetest.get_modpath("default") ~= nil then
    playtime.gamemode = "MTG"
elseif minetest.get_modpath("mcl_core") ~= nil then
    playtime.gamemode = "MCL"
elseif minetest.get_modpath("nc_core") ~= nil then
    playtime.gamemode = "NC"
else
    playtime.gamemode = "???"
end

playtime.log = function(msg)
    if type(msg) == "table" then
        msg = minetest.serialize(msg)
    end
    minetest.log("action", "[playtime] " .. msg)
end

playtime.dofile = function(fname)
    local modpath = minetest.get_modpath("playtime")
    dofile(modpath .. DIR_DELIM .. fname .. ".lua")
end

playtime.log("Version: " .. playtime.VERSION)

playtime.dofile("api")
playtime.dofile("routine")
playtime.dofile("chat_cmd")

playtime.log("Ready.")
