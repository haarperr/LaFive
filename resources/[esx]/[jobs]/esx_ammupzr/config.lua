Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 21
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 0, g = 255, b = 255 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale = 'fr'

Config.AmmuStations = {

  Ammu = {

    Blip = {
      Pos     = { x = 75.81, y = -1576.32, z = 29.48 },
      Sprite  = 313,
      Display = 4,
      Scale   = 0.6,
      Colour  = 81,
    },

    AuthorizedWeapons = {
-- Define prices of the weapons.
			{name  = "WEAPON_FLASHLIGHT", price = 500, label = "Lampe Torche (1000$)"},
			{name  = "WEAPON_HAMMER", price = 500, label = "Marteau (1500$)"},
			{name  = "WEAPON_CROWBAR", price = 1500, label = "Pied de biche (3000$)"},
			{name  = "WEAPON_HATCHET", price = 1500, label = "Hache (4000$)"},
            {name  = "WEAPON_BAT", price = 1500, label = "Batte de Baseball (4500$)"},
			{name  = "WEAPON_KNUCKLE", price = 1500, label = "Poing Americain (5000$)"},
			{name  = "WEAPON_KNIFE", price = 1500, label = "Couteau (5000$)"},
			{name  = "WEAPON_SWITCHBLADE", price = 2500, label = "Couteau à Cran d'Arrêt (5000$)"},
			{name  = "WEAPON_GOLFCLUB", price = 2500, label = "Club de Gold (6000$)"},
			{name  = "WEAPON_MACHETE", price = 4500, label = "Machette (7500$)"},
			{name  = "WEAPON_PISTOL", price = 20000, label = "Pistolet 9mm (130000$)"},
			{name  = "WEAPON_SNSPISTOL", price = 25000, label = "MP-25 (Petit Pistolet (180000$)"},
			{name  = "WEAPON_HEAVYPISTOL", price = 35000, label = "Colt 1911 (185000$)"},
			{name  = "WEAPON_PISTOL50", price = 35000, label = "Desert Eagle (165000$)"},
		--	{name  = "WEAPON_MICROSMG", price = 100000, label = "Micro Smg (550000$)"},
	--		{name  = "WEAPON_BULLPUPRIFLE", price = 50000, label = "Assaut Securoserv (85000$)"},
		--	{name  = "WEAPON_COMPACTRIFLE", price = 25000, label = "AKSMG Securoserv (55000$)"},
			{name  = "WEAPON_PISTOL50", price = 10000, label = "Pitol50 Securoserv (20000$)"},
			
    },

	  AuthorizedVehicles = {
		 -- { name = 'osiris',  label = 'Osiris' },
		  --{ name = 'patriot',    label = 'Patriot' },
		 -- { name = '9f',      label = '9F' },
     -- { name = 'vacca',   label = 'Vacca' },
      { name = 'bison',   label = '4x4 Livraison' },
      { name = 'mule',   label = 'Camion Livraison' },      
	  },
	  
	  Vehicles = {
      {
        Spawner    = { x = 53.64, y = -1554.55, z = 28.46 },
        SpawnPoint = { x = 64.67, y = -1539.74, z = 28.48 },
        Heading    = 230.5,
      }
    },
	
	VehicleDeleters = {
      { x = 41.97, y = -1579.54, z = 28.38 },
      
    },

    Armories = {
      { x = 77.36, y = -1578.51, z = 28.61 },
    },

    BossActions = {
      { x = 83.35, y = -1571.23, z = 28.61 },
    },

  },

}
