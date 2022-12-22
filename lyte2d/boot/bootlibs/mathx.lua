--[[ (c) mg ]]


local mathx = {}

function mathx.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

return mathx