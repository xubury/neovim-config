local fn = vim.fn

local u = {}

if fn.has("win32") > 0 then
    u.num_of_processers = vim.env.NUMBER_OF_PROCESSORS
elseif fn.has("unix") > 0 then
    u.num_of_processers = tonumber(vim.fn.system("nproc"))
end
function u.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. u.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return u
