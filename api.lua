
-- Given a playername looks for that players structure
--
-- Will return a new structure if the player doesn't exist (new being total=0, session=0)
playtime.get = function (player_name)
    local struct = playtime.store:get_string("pt_" .. player_name) or ""
    if struct ~= "" then
        return minetest.deserialize(struct)
    end
    -- User doesn't exist, let's make a new struct
    return {total=0, session=0}
end

playtime.set = function (player_name, struct)
    if struct == nil then
        -- Useful for initing players without a struct
        struct = {total=0, session=0}
    end
    playtime.store:set_string("pt_"..player_name, minetest.serialize(struct))
end

-- Given a timestamp forms a timestruct
--
-- A timestruct will have week, day, hour, minute and second
playtime.format = function (timestamp)
    local minutes = math.floor(timestamp / 60)
    timestamp = timestamp - (minutes * 60)
    local hours = math.floor(minutes / 60)
    minutes = minutes - (hours * 60)
    local days = math.floor(hours / 24)
    hours = hours - (days * 24)
    local weeks = math.floor(days / 7)
    days = days - (weeks * 7)

    return {week=weeks, day=days, hour=hours, minute=minutes, second=timestamp}
end

-- Short string format, given a timestruct
--
-- The short format for example:
-- Instead of "1 week, 3 day, 2 hour, 4 minute, 17 second"
-- Would be   "1w 3d 2h 4m 17s"
playtime.short_str_format = function(t)
    local result = ""
    if t.week ~= 0 then
        result = result .. t.week .. "w"
    end
    if t.day ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.day .. "d"
    end
    if t.hour ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.hour .. "h"
    end
    if t.minute ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.minute .. "m"
    end
    if t.second ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.second .. "s"
    end
    return result
end

-- Given a field name and a timevalue (assuming of that field)
--
-- Returns fieldname or fieldname + s for if timevalue is greater than 1
playtime.plural = function(timevalue, field_name)
    if timevalue > 1 then
        return field_name .. "s"
    end
    return field_name
end

-- String format, given a timestruct
--
-- Returns format in example: "1 week, 1 day, 1 hour, 2 minutes, 17 seconds"
playtime.str_format = function(t)
    local result = ""
    if t.week ~= 0 then
        result = result .. t.week .. " " .. playtime.plural(t.week, "week")
    end
    if t.day ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.day .. " " .. playtime.plural(t.day, "day")
    end
    if t.hour ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.hour .. " " .. playtime.plural(t.hour, "hour")
    end
    if t.minute ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.minute .. " " .. playtime.plural(t.minute, "minute")
    end
    if t.second ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.second .. " " .. playtime.plural(t.second, "second")
    end
    return result
end