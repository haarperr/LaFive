Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = true
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50
Config.Locale                     = 'fr'

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

  ShopEntering = {
    Pos   = { x = -32.957, y = -1112.16, z = 24.622 },
    Size  = { x = 2.5, y = 2.5, z = 1.0 },
    Type  = -1,
  },


  ShopImport = {
    Pos   = { x = 2241.41, y = 2876.021, z = 48.422 },
    Size  = { x = 7.5, y = 7.5, z = 1.0 },
    Type  = -1,
  },
  ShopImport2 = {
    Pos   = { x = 2240.31, y = 2892.38, z = 48.422 },
    Size  = { x = 5.5, y = 5.5, z = 1.0 },
    Type  = -1,
  },

  ShopInside = {
 --   Pos     = { x = -44.987, y = -1098.021, z = 25.422 },
    Pos     = { x = 1101.66, y = -3147.05, z = -38.85 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading =  142.7,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -28.637, y = -1085.691, z = 25.565 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 330.0,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = {
    Pos   = { x = -44.630, y = -1080.738, z = 25.683 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },

}
