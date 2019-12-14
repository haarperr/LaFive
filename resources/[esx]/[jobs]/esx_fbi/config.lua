Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerSizeDel              = { x = 5.0, y = 5.0, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.MarkerColorDel             = { r = 204, g = 50, b = 50 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.FibStations = {

  FIB = {

    Blip = {
      Pos     = {x = 104.53714752197,y = -744.36810302734,z = 44.754749298096 },
      Sprite  = 88,
      Display = 4,
      Scale   = 1.0,
      Colour  = 5,
    },

    AuthorizedWeapons = {
    
    {name = 'WEAPON_NIGHTSTICK'},
    {name = 'WEAPON_COMBATPISTOL'},
    {name = 'WEAPON_PISTOL50'},
    {name = 'WEAPON_SMG'},
    {name = 'WEAPON_CARBINERIFLE'},
    {name = 'WEAPON_STUNGUN'}
    
    },

    AuthorizedVehicles = {
	  {name = 'fbi2', label = 'Suv FIB'},
	  {name = 'fbi', label = 'Buffalo FIB'}, 
    {name = 'riot', label = 'Camion Blindé'},
 
    },
	
	AuthorizedVehicles1 = {
    --{name = 'frogger2' , label = 'Hélico'},
    --{name = 'annihilator' , label = 'annihilator'}
	},

    Cloakrooms = {
      {x = 132.09106445313,y = -770.02984619141,z = 241.15199279785 },
    },

    Armories = {
      {x = 118.56095123291,y = -729.23553466797,z = 241.1519317627 },
    },

    Vehicles = {
      {
        Spawner    = {x = 152.14860534668,y = -681.07427978516,z = 32.131786346436 },
        SpawnPoint = {x = 156.58151245117,y = -690.98602294922,z = 32.129154205322 },
        Heading    = 150.0
      }
    },

    Vehicles1 = {
	  {
		Spawner1    = {x = -71.661056518555,y = -811.02301025391,z = 325.083984375 },
		SpawnPoint1 = {x = -75.194091796875,y = -818.81500244141,z = 325.17517089844 },
		Heading1   = 90.0
	  }
	},

    VehicleDeleters = {
      {x = 156.58151245117,y = -690.98602294922,z = 32.129154205322 },
    },
	
	VehicleDeleters1 = {
	  {x = -75.194091796875,y = -818.81500244141,z = 325.17517089844 },
	},

    BossActions = {
      {x = 150.73254394531,y = -756.2353515625,z = 241.15196228027 },
    },

  },

}
