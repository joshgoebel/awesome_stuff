local posix = require("posix")
local awful = require("awful")



local my_state_file = awful.util.get_cache_dir() .. "/wm_state"

local function save_state()
	local params = {}

  -- for some reason ipairs does not work on screen
	for s in screen do
    local i = s.index
		local tags = s.tags
		local td = {}
		for i, t in ipairs(tags) do
			td[i] = {
				layout = table.indexof(awful.layout.layouts, 
					t.layout),
				selected = t.selected
			}
		end
		local sd = {
	--		layout = table.indexof(mytags.layout)
			tags = td,
			geo = s.geometry,
			selected_tags = s.selected_tags,
			selected_tag = s.selected_tag
		}
		params[i] = sd 
	end

	table.save(params, my_state_file)
end


local function restore_state()
	if posix.stat(my_state_file) == nil then return end

	local params = table.load(my_state_file)
	--os.remove(my_state_file)
	for j, sd in ipairs(params) do
		local s = screen[j]
		if (not s) then return end
		awful.tag.viewnone(s)
		for i, td in ipairs(sd.tags) do
			local t = s.tags[i]
			if (not t) then return end
			
			t.layout = awful.layout.layouts[td.layout]
		        if td.selected then 
				awful.tag.viewtoggle(t)
			end
		end
	end
end


awesome.connect_signal("startup", function()
	restore_state()
end)

awesome.connect_signal("exit", function()
	save_state()
end)
