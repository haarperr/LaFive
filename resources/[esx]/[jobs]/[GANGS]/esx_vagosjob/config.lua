Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 23
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.GangStations = {

  Gang = {

    AuthorizedWeapons = {
     -- { name = 'WEAPON_COMBATPISTOL',     price = 30000 },
    --  { name = 'WEAPON_ASSAULTSMG',       price = 1125000 },
  --    { name = 'WEAPON_ASSAULTRIFLE',     price = 1500000 },
--{ name = 'WEAPON_SAWNOFFSHOTGUN',      price = 60000 },
	 -- { name = 'WEAPON_BAT'		,        price = 3000 },
      --{ name = 'WEAPON_SNIPERRIFLE',      price = 2200000 },
    --  { name = 'WEAPON_APPISTOL',         price = 70000 },
    --  { name = 'WEAPON_CARBINERIFLE',     price = 100000 },
     --{ name = 'WEAPON_HEAVYSNIPER',      price = 2000000 },
    },

	  AuthorizedVehicles = {
		  { name = 'bmx',  label = 'BMX' },
		  { name = 'Blazer',    label = 'Quad' },
      { name = 'buccaneer',   label = 'Voiture' },
      { name = 'manchez',   label = 'Moto' },
	  },

    Cloakrooms = {
      --{ x = 144.57633972168, y = -2203.7377929688, z = 3.6880254745483},
    },

    Armories = {
      { x = 476.2292, y = -1900.22, z = 24.96},
    },

    Vehicles = {
      {
        Spawner    = { x = 465.35, y = -1889.11, z = 25.1 },
        SpawnPoint = { x = 465.08, y = -1885.1, z = 25.1 },
        Heading    = 292.05,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 1132323.30500793457, y = -3109.3337402344, z = 5.0060696601868 },
        SpawnPoint = { x = 112.94457244873, y = -3102.5942382813, z = 5.0050659179688 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 311.07218719482, y = -2026.8431768798825, z = 19.548830413818 },
      
    },

    BossActions = {
      { x = 361.32, y = -2041.53, z = 24.59 },
    },

  },

}
