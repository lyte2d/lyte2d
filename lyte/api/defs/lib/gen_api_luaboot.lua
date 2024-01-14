require "lib.apidef"

local SPC = "    "
local SPC2 = SPC:rep(2)

local FILE_TOP = [=[-- generated

]=]


local function generate_api_luaboot(NS)
    out = FILE_TOP
    out = out .. "-- Lua API: " ..  NS.name .. "\n"
    out = out .. NS.name .. " = " .. NS.name .. " or {}\n\n"


    out = out .. "-- mapped functions\n"
    for _i, fn in ipairs(NS.functions) do
        if fn.mapto then
            out = out .. NS.name .. "." .. fn.name .. " =  " ..fn.mapto.namespace .. "." ..  fn.mapto.name .. "\n"
        end
    end
    out = out .. "\n"

    out = out .. "-- records \n"
    for _i, rec in ipairs(NS.records) do
        out = out .. NS.name .. "." .. rec.name .. " = {\n"
        out = out .. SPC .. "id=nil;\n"
        out = out .. SPC .. "__new=function(self, id) rawset(self, 'id', id) end;\n"
        -- fields: gets
        out = out .. SPC .. "__index=function(self, k)\n"
        for _i, f in ipairs(rec.fields) do
            if f.mapread then
                out = out .. SPC2 .. "if k=='" .. f.name .. "' then return " .. NS.name .. "." .. f.mapread.name .. "(self, k) end\n"
            end
        end
        -- non "meta" methods
        for _i, m in ipairs(rec.methods) do
            if m.name:sub(1,2) ~= "__" then
                out = out .. SPC2 .. "if k=='" .. m.name .. "' then return " .. NS.name .. "." ..  m.mapto.name .. " end\n"
            end
        end
        out = out .. SPC2 .. "return rawget(self, k)\n"
        out = out .. SPC .. "end;\n"
        -- fields: sets
        out = out .. SPC .. "__newindex=function(self, k, v)\n"
        local begin = true
        local if_mapwrite_exists = false
        for _i, f in ipairs(rec.fields) do
            if f.mapwrite then
                out = out .. SPC2
                if begin then
                    if_mapwrite_exists = true
                    out = out .. "if "
                    begin = false
                else
                    out = out .. "elseif "
                end
                out = out .. "k=='" .. f.name .. "' then " .. NS.name .. "." .. f.mapwrite.name .. "(self, v)\n"
            end
        end
        if if_mapwrite_exists then out = out .. SPC2 .. "end\n" end
        out = out .. SPC .. "end;\n"
        -- "meta" methods
        for _i, m in ipairs(rec.methods) do
            if m.name:sub(1,2) == "__" then
                out = out .. SPC .. m.name .. "=" .. NS.name .. "." .. m.mapto.name .. ";\n"
            end
        end
        out = out .. SPC .. "__tostring=function(self) return '(obj type = " .. NS.name .. "." .. rec.name .. ")' end;\n"
        out = out .. "}\n"
    end
    out = out .. "\n"

    out = out .. "-- lua 'wrapping' functions\n"
    for _i, fn in ipairs(NS.functions) do
        if fn.mapwrapto then
            -- out = out .. "-- " ..  NS.name .. "." .. fn.name .. " =  TBD (" .. fn.code .. ") \n"
            out = out ..  NS.name .. "." .. fn.name .. " = function("
            -- args
            for _j, a in ipairs(fn.args) do
                local arg_name = a.name
                if a.wrapped then arg_name = arg_name .. "_wrapped" end
                out = out .. arg_name
                if _j < #fn.args then out = out .. ", " end
            end
            out = out ..  ")\n"
            -- unwrap
            for _j, a in ipairs(fn.args) do
                if a.wrapped then
                    out = out .. SPC .. "local " ..  a.name .. " = " .. a.name .. "_wrapped.id\n"
                end
            end
            local ret_var_name = nil
            local ret_var_type = nil
            -- ret val or not
            if #fn.rets >= 1 then
                ret_var_name = fn.rets[1].name
                ret_var_type = NS.name .. "." .. fn.rets[1].type
                assert(ret_var_name)
                assert(ret_var_type)
                local wrap_fullname = fn.mapwrapto.namespace .. "." .. fn.mapwrapto.name
                out = out .. SPC .. "local " .. ret_var_name .. " = " .. wrap_fullname .. "("
            else
                local wrap_fullname = fn.mapwrapto.namespace .. "." .. fn.mapwrapto.name
                out = out .. SPC .. wrap_fullname .. "("
            end
            for _j, a in ipairs(fn.args) do
                out = out .. a.name
                if _j < #fn.args then out = out .. ", " end
            end
            out = out .. ")\n"
            if ret_var_name then
                out = out .. SPC .. "local _ret_val = "
                if not fn.rets[1].wrapped then
                    out = out .. ret_var_name
                else
                    out = out .. "classnew(" .. ret_var_type  ..", " .. ret_var_name ..")"
                end
                out = out .. "\n"
                out = out .. SPC .. "return _ret_val\n"
            end
            out = out .. "end\n"
        end
    end
    out = out .. "\n"

    out = out .. "-- manually handled functions in current namespace\n"
    for _i, fn in ipairs(NS.functions) do
        if fn.code then
            out = out ..  fn.namespace .. "." .. fn.name .. " = " .. fn.code
        end
    end
    out = out .. "\n"

    out = out .. "-- unhandled functions in current namespace\n"
    for _i, fn in ipairs(NS.functions) do
        if not fn.mapto and not fn.mapwrapto and not fn.code then
            out = out .. "-- " .. fn.name .. " [implementation: " .. fn.impl .. "]\n"
        end
    end
    out = out .. "\n"


    return out
end

return generate_api_luaboot
