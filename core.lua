--- STEAMODDED HEADER
--- MOD_NAME: PDUBMod
--- MOD_ID: PDUBMod
--- MOD_AUTHOR: Jonah Falder
--- MOD_DESCRIPTION: hi
--- PREFIX: pdub
----------------------------------------------------------
----------- MOD CODE -------------------------------------

--  --

if not PDUBModMod then
	PDUBMod = {}
end
local global = {}

-- code borrowed (& modified) from NeatoJokers by LauraOnline!!

SMODS.current_mod.description_loc_vars = function()
	return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.4, shadow = true }
end


local creditspage = {
       "Jonah Falder - Most of the work",
       "Shoutout to the Cryptid Mod Discord for help"
    }

SMODS.current_mod.extra_tabs = function() --Credits tab
    local scale = 0.5
    return {
        label = "Credits",
        tab_definition_function = function()
        return {
            n = G.UIT.ROOT,
            config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
            },
            nodes = {
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "By Jonah Falder",
                    shadow = false,
                    scale = scale*2,
                    colour = G.C.PURPLE
                    }
                }
                }
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Some art assets by",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                },
                }
            },
            {
                n = G.UIT.R,
                config = {
                    padding = 0,
                    align = "cm"
                },
                nodes = {
                    {
                    n = G.UIT.T,
                    config = {
                        text = "Lisnovski, Blake Andrews, violxiv",
                        shadow = false,
                        scale = scale,
                        colour = G.C.MONEY
                    }
                    },
                }
                },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Code contributions by",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                },
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Nova_422, Sciman101",
                    shadow = false,
                    scale = scale,
                    colour = G.C.GREEN
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Music from",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "The Cyber Grind - meganeko / Buy Somethin' Will Ya - Earthbound / Game Corner - Pokemon Emerald",
                    shadow = false,
                    scale = scale*0.75,
                    colour = G.C.RED
                    }
                }
                } 
            },
			{
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Special thanks:",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Burssty & HexaCryonic for playtesting & the Cryptid Discord for help!",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.BLUE
                    }
                }
                } 
            }
            }
        }
        end
    }
end




local mod_path = "" .. SMODS.current_mod.path
PDUBMod.path = mod_path
PDUBMod_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
	post_trigger = true,
}

-- effect manager for particles etc

G.effectmanager = {}




-- pdubmod joker pool
SMODS.ObjectType({
	key = "pdubmodaddition",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})




--Load item files
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[PDUBMOD] Loading lua file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load lib files
local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
	print("[PDUBMOD] Loading lib file " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Localization file
local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
	print("[PDUBMOD] Loading localization file " .. file)
	local f, err = SMODS.load_file("localization/" .. file)
	if err then
		error(err) 
	end
	f()
end





--Load misc stuff so i only hook things once
--local hook = love.load
--function love.load()
--	hook()
--		local full_path = (Yahimod.path 
--		.."assets/" 
--		.. G.SETTINGS.GRAPHICS.texture_scaling 
--		.. "x/"
--		.. "horse.png")
--	file_data = assert(NFS.newFileData(full_path),("Epic fail"))
--	Yahimod.horsepngimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
--	Yahimod.horsepng = assert(love.graphics.newImage(Yahimod.horsepngimagedata),("Epic fail 3"))
--
--end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------
