Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
Config.EnablePlayerManagement     = true -- enables the actual moto dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = true
Config.EnableOwnedMotos           = true
Config.EnableSocietyOwnedMotos    = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 20
Config.Locale                     = 'fr'

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = { x = 486.9577, y = 6605.0200, z = 27.3043 },
		Size  = { x = 1.5, y = 1.5, z = 0.1 },
		Type  = 1
	},

	ShopInside = {
		Pos     = { x = 507.9487, y = 6573.06986, z = 26.31727 },
		Size    = { x = 1.5, y = 1.5, z = 0.1 },
		Heading = -20.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = 493.6531, y = 6595.8271, z = 27.3044 },
		Size    = { x = 1.5, y = 1.5, z = 0.1 },
		Heading = 330.0,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = 490.1651, y = 6605.2670, z = 27.3044 },
		Size  = { x = 1.5, y = 1.5, z = 0.1 },
		Type  = -1
	},

	GiveBackMoto = {
		Pos   = { x = 496.6520, y = 6579.9653, z = 27.3043 },
		Size  = { x = 3.0, y = 3.0, z = 0.1 },
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	--[[ResellMoto = {
		Pos   = { x = -52.630, y = -1078.738, z = 25.683 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}--]]

}

