Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale = 'fr'

Config.Zones = {

	PetrolFarm = {
		Pos   = {x = 1830.97, y = 5041.32, z = 57.59},
		Size  = {x = 10.0, y = 10.0, z = 2.0},
		Color = {r = 255, g = 178, b = 9},
		Name  = "Récolte des graines (Whiskey)",
		Type  = 1
	},


	TraitementPetrol = {
		Pos   = {x = 2890.73, y = 4391.29, z = 49.38},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Fermentation du Whiskey (1)",
		Type  = 1
	},

	TraitementRaffin = {
		Pos   = {x = 2905.59, y = 4348.65, z = 49.32},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Dillution du Whiskey (2)",
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = -2963.56, y = 432.19, z = 14.29},
		Size  = {x = 4.5, y = 4.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Vente des produits",
		Type  = 1
	},

	FuelerActions = {
		Pos   = {x = 201.01, y = 2442.28, z = 59.45},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Point d'action",
		Type  = 27
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 189.67, y = 2458.21, z = 54.71},
		Size = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage véhicule",
		Type  = 27
	},

	VehicleSpawnPoint = {
		Pos   = {x = 196.84, y = 2455.69, z = 54.84},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Spawn point",
		Heading = 265.5,
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = 212.86, y = 2469.16, z = 54.62},
		Size  = {x = 5.0, y = 5.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Ranger son véhicule",
		Type  = 27
	}

}

