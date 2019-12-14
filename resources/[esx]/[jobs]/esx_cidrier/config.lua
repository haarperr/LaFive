Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'fr'

Config.Zones = {

	PommeFarm = {
		Pos   = {x = 273.8316, y = 6508.7934, z = 29.4032},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Cueillette de pommes",
		Type  = 1
	},


	TraitementCidre = {
		--Pos   = {x = 2534.2131, y = 4985.4423, z = 43.9617},
		Pos   = {x = -2174.5983, y = 4286.1933, z = 48.2070},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Faire du Cidre",
		Type  = 1
	},

	TraitementJus = {
		--Pos   = {x = -471.2581, y = 6290.4165, z = 12.6102},
		Pos   = {x = 1943.7429, y = 4653.4565, z = 39.5784},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Faire du Jus de Pommes",
		Type  = 1
	},
	
	SellFarm = {
		--Pos   = {x = 1392.1041, y = 3604.2780, z = 33.9809},
		Pos   = {x = -1829.2121, y = 799.4572, z = 137.2843},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Vente des produits",
		Type  = 1
	},

	CidrierActions = {
		Pos   = {x = 428.6598, y = 6477.2783, z = 27.7852},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Point d'action",
		Type  = 0
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 422.0107, y = 6474.6591, z = 28.0130},
		Size = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 0, b = 0},
		Name  = "Sortir son véhicule",
		Type  = 0
	},

	VehicleSpawnPoint = {
		Pos   = {x = 418.3748, y = 6476.4687, z = 27.8096},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 0, g = 200, b = 0},
		Name  = "Point de sortie du véhicule",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = 438.3269, y = 6461.0610, z = 27.7459},
		Size  = {x = 2.0, y = 2.0, z = 0.1},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Ranger son véhicule",
		Type  = 0
	}

}

