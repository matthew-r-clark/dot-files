local function merge_tables(default, custom)
  local merged = {}
  for k, v in pairs(default) do
    if type(v) == 'table' then
      merged[k] = merge_tables(v, custom[k])
    else
      merged[k] = custom[k] or v
    end
  end

  for k, v in pairs(custom) do
    if merged[k] == nil then
      merged[k] = v
    end
  end

  return merged
end

local function serialize_table(val, name, skipnewlines, depth)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    if name then tmp = tmp .. name .. " = " end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        for k, v in pairs(val) do
            tmp =  tmp .. serialize_table(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
        end

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end

return {
    merge_tables = merge_tables,
    serialize_table = serialize_table,
}
