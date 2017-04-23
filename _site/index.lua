#!/usr/local/bin/lua

function a(tab, fun)
    for k, v in pairs(tab) do
        print(fun(k, v))
    end



end

tab = {key1 = "val1", key2 = "val2" }

a(tab, function(key, val)
    return key .. '==' .. val
end)
