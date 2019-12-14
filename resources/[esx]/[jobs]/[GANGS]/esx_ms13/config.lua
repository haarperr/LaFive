Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.ms13Stations = {

  ms13 = {

    Blip = {
      Pos     = { x = 425.130, y = -979.558, z = 30.711 },
      Sprite  = 60,
      Display = 4,
      Scale   = 1.2,
      Colour  = 29,
    },

    AuthorizedWeapons = {
     -- { name = 'WEAPON_COMBATPISTOL',     price = 4000 },
     -- { name = 'WEAPON_ASSAULTSMG',       price = 15000 },
    --  { name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
--{ name = 'WEAPON_PUMPSHOTGUN',      price = 9000 },
  --    { name = 'WEAPON_STUNGUN',          price = 250 },
  --    { name = 'WEAPON_FLASHLIGHT',       price = 50 },
   --   { name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
  --    { name = 'WEAPON_FLAREGUN',         price = 3000 },
   --   { name = 'GADGET_PARACHUTE',        price = 2000 },
   --   { name = 'WEAPON_SNIPERRIFLE',      price = 50000 },
   --   { name = 'WEAPON_FIREWORK',         price = 5000 },
   --   { name = 'WEAPON_BZGAS',            price = 8000 },
   --   { name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
    --  { name = 'WEAPON_APPISTOL',         price = 12000 },
   --   { name = 'WEAPON_CARBINERIFLE',     price = 25000 },
   --   { name = 'WEAPON_HEAVYSNIPER',      price = 100000 },
   --   { name = 'WEAPON_FLARE',            price = 8000 },
   --   { name = 'WEAPON_SWITCHBLADE',      price = 500 },
	 -- { name = 'WEAPON_REVOLVER',         price = 6000 },
	 -- { name = 'WEAPON_POOLCUE',          price = 100 },
	 -- { name = 'WEAPON_GUSENBERG',        price = 17500 },
	  
    },

	  AuthorizedVehicles = {
		  { name = 'schafter3',  label = 'Véhicule Civil' },
      { name = 'mule3',      label = 'Camion de Transport' },
      { name = 'rumpo3',      label = 'Fourgonette Tout terrain' },
		  { name = 'burrito3',   label = 'Fourgonnette' },
      { name = 'mesa',       label = 'Tout-Terrain' },
      { name = 'xls2',       label = 'SUV Blindé' },
	  },

    Cloakrooms = {
      { x = 1398.263, y = 1156.974, z = 113.33 },
    },

    Armories = {
      { x = 1397.360, y = 1164.1, z = 113.33 },
    },

    Vehicles = {
      {
        Spawner    = { x = 1413.61, y = 1114.8, z = 113.84 },
        SpawnPoint = { x = 1409.797, y = 1118.51, z = 113.84 },
        Heading    = 89.12,
      }
    },
	
	Helicopters = {
      {
        Spawner    = { x = 2195.59, y = 53555.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 52555.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 1401.34, y = 1115.77, z = 113.86 },
      { x = 2421.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = 1400.5913, y = 1159.55, z = 113.33 }
    },

  },

}
