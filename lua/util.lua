local fn = vim.fn

local u = {}

function u.dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. u.dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function u.get_color(group, attr)
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

return u
