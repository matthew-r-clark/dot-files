MERGE_TABLES = function (default, custom)
  local merged = {}
  for k, v in pairs(default) do
    if type(v) == 'table' then
      merged[k] = MERGE_TABLES(v, custom[k])
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
