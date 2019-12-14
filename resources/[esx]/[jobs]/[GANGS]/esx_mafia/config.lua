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

Config.MafiaStations = {

  Mafia = {

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
		  { name = 'btype',      label = 'Roosevelt' },
		  { name = 'sandking',   label = '4X4' },
		  { name = 'mule3',      label = 'Camion de Transport' },
		  { name = 'guardian',   label = 'Grand 4x4' },
		  { name = 'burrito3',   label = 'Fourgonnette' },
		  { name = 'mesa',       label = 'Tout-Terrain' },
	  },

    Cloakrooms = {
      { x = 9.283, y = 528.914, z = 169.635 },
    },

    Armories = {
      { x = -34.050, y = 347.867, z = 113.0 },
    },

    Vehicles = {
      {
        Spawner    = { x = -77.52, y = 364.15, z = 111.447 },
        SpawnPoint = { x = -82.937, y = 348.63, z = 111.44 },
        Heading    = 333.0,
      }
    },
	
	Helicopters = {
      {
        Spawner    = { x = 2550.312, y = 53555.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 52555.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -88.514, y = 365.69, z = 111.46 },
      { x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = -61.013, y = 360.4197, z = 112.06 }
    },

  },

}
