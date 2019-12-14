Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale = 'fr'

Config.Zones = {

	PetrolFarm = {
		Pos   = {x = -574.42, y = 5352.89, z = 69.26},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Récolte du Papier",
		Type  = 1
	},


	TraitementPetrol = {
		Pos   = {x = 189.84, y = 2457.62, z = 54.72},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Transformation du Papier",
		Type  = 1
	},

	-- TraitementRaffin = {
		-- Pos   = {x = 2905.59, y = 4348.65, z = 49.32},
		-- Size  = {x = 4.0, y = 4.0, z = 1.0},
		-- Color = {r = 136, g = 243, b = 216},
		-- Name  = "Dillution du Whiskey (2)",
		-- Type  = 1
	-- },
	
	SellFarm = {
		Pos   = {x = 255.35, y = 228.97, z = 105.31},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Revente de Billet",
		Type  = 1
	},

	FuelerActions = {
		Pos   = {x = -2587.81, y = 1910.97, z = 166.53},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Point d'action",
		Type  = 27
	 },
	  
	VehicleSpawner = {
		Pos   = {x = -2588.9, y = 1927.62, z = 166.3},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage véhicule",
		Type  = 27
	},

	VehicleSpawnPoint = {
		Pos   = {x = -2595.72, y = 1929.9, z = 166.4},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Heading = 270.5,
		Type  = 0
	},

	VehicleDeleter = {
		Pos   = {x = -2595.72, y = 1929.9, z = 166.4},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Ranger son véhicule",
		Type  = 0
	}

}

