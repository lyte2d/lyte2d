--[[ (c) mg ]]

-- local API = _lyte_direct_api
local API = lyte

-------- lyte.audio ------------------

lyte.audio = lyte.audio or {}


local audio_md = getmetatable(lyte.audio) or {}

-- audio_md.__index = function(self, key)
--     local ret = nil
--     if key == "volume" then ret = API.get_mastervolume()
--     else print ("Unknown key in lyte.audio: " .. key)
--     end
--     return ret
-- end

lyte.audio.volume = API.get_mastervolume()

audio_md.__newindex = function(self, key, val)
    if key == "volume" then
        API.set_mastervolume(val)
        lyte.audio.volume = val
    else print ("Unknown key in lyte.audio: " .. key)
    end
end


setmetatable(lyte.audio, audio_md);


-------- lyte.window ------------------

lyte.window = lyte.window or {}


local window_md = getmetatable(lyte.window) or {}

window_md.__index = function(self, key)
    local ret = nil
    if key == "vsync" then ret = API.get_vsync()
    elseif key == "fullscreen" then ret = API.get_fullscreen()
    elseif key == "size" then ret = {width = API.get_windowwidth(), height = API.get_windowheight()};
    elseif key == "minsize" then print("lyte.window.minsize is write-only (begin: lyte alpha 0.2)")
    elseif key == "title" then print("lyte.window.title is write-only (begin: lyte alpha 0.2)")
    elseif key == "icon" then print("lyte.window.icon is write-only (begin: lyte alpha 0.2)")
    elseif key == "margin" then print("lyte.window.margin is write-only (begin: lyte alpha 0.2)")
    elseif key == "padding" then print("lyte.window.padding is write-only (begin: lyte alpha 0.2)")
    else print ("Unknown key in lyte.window: " .. key)
    end
    return ret
end

window_md.__newindex = function(self, key, val)
    if key == "vsync" then ret = API.set_vsync(val)
    elseif key == "fullscreen" then API.set_fullscreen(val)
    elseif key == "size" then
        local w = val.width or API.get_windowwidth()
        local h = val.height or API.get_windowheight()
        API.set_windowsize(w, h)
    elseif key == "minsize" then
        local w = val.width or API.get_windowwidth()
        local h = val.height or API.get_windowheight()
        API.set_windowminsize(w, h)
    elseif key == "title" then API.set_windowtitle(val)
    elseif key == "icon" then API.set_windowicon(val)
    elseif key == "margins" then
        local l = val.left or 0
        local r = val.right or 0
        local t = val.top or 0
        local b = val.bottom or 0
        API.set_margins(l, r, t, b);
    elseif key == "paddings" then
        local l = val.left or 0
        local r = val.right or 0
        local t = val.top or 0
        local b = val.bottom or 0
        API.set_paddings(l, r, t, b);
    else print ("Unknown key in lyte.window: " .. key)
    end
end


setmetatable(lyte.window, window_md)