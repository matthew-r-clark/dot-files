local function logger(...)
    local args = {...}
    local file = io.open('./logger.txt', 'a')

    if file~=nil then
        file:write(unpack(args))
    end

    io.close(file);
end

local function getTimestamp()
    return os.date("%Y-%m-%d %H:%M:%S") .. '  '
end

return {
    error = function (...)
        local args = {...}
        logger('\n', getTimestamp(), 'ERROR: ', unpack(args))
    end,
    warn = function (...)
        local args = {...}
        logger('\n', getTimestamp(), 'WARN: ', unpack(args))
    end,
    info = function (...)
        local args = {...}
        logger('\n', getTimestamp(), 'INFO: ', unpack(args))
    end,
    debug = function (...)
        local args = {...}
        logger('\n', getTimestamp(), 'DEBUG: ', unpack(args))
    end,
}
