---@meta _
---@diagnostic disable

local mods = rom.mods

---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()

_PLUGIN = _PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'game-import'
import_as_fallback(game)

---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]
---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'config'
config = chalk.auto 'config.lua'
public.config = config

local function on_ready()
    if config.enabled == false then return end
    
    import 'scripts/sjson.lua'
    import 'localize.lua'
    import 'lang/en.lua'
    import 'lang/fr.lua'
    import 'lang/ptBR.lua'
    import 'lang/zhCN.lua'
    import 'scripts/JowdayDPS.Main.lua'
    import 'scripts/JowdayDPS.Data.lua'
end

local function on_reload()

end

-- this allows us to limit certain functions to not be reloaded.
local loader = reload.auto_single()

-- this runs only when modutil and the game's lua is ready
modutil.on_ready_final(function()
	loader.load(on_ready, on_reload)
end)