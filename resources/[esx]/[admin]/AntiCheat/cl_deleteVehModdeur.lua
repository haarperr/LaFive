-- CONFIG --

ESX          = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
-- Blacklisted vehicle models
ListeBlackList = {
	"RHINO",
	"BLIMP",
	"BLIMP2",
	"CARGOPLANE",
	"BESRA",
	"CUBAN800",
	"DODO",
	"JET",
	"MILJET",
	"CARGOBOB",
	"hydra",
	"CUTTER",
	"DUMP",
	"BULLDOZER",
	"Lazer",
	"luxor",
	"luxor2",
	"miljet",
	"nimbus",
	"shamal",
	"mammatus",
	"besra",
	"deluxo",
	"tug",
	"oppressor",
	"TITAN"
}

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			coords = GetEntityCoords(playerPed, true)
			--x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(ListeBlackList) do
				local voiture = ESX.Game.GetVehiclesInArea(coords, 350) -- Changer ça si trop de MS utilisé
				for _, voiture in pairs(voiture) do
					checkCar(voiture)
				end
			end
		end
	end
end)

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)
		VieDuVehicule = GetVehicleEngineHealth(car)

		if VieDuVehicule <= 1 then
			_DeleteEntity(car)
		end
		if isListeBlackListed(carModel) then
			_DeleteEntity(car)
			if carName ~= "BLIMP" then
				print(carName)
				AfficherAC("~r~LAFIVE ANTI CHEAT ACTIVER - SUPPRESSION DE VEHICULE BLACKLIST EN COURS !\nPERTE DE FPS POSSIBLE !", car, carModel, carName)
			end
		end
	end
end

function ACdelete(car)
	Wait(15000)
	_DeleteEntity(car)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end


local textActif = false
local wait = 0
function AfficherAC(text, car, carModel, carName)
	if textActif == false then
		TriggerServerEvent("AC:VehModdeur", car, carModel, carName)
		Citizen.CreateThread(function()
			textActif = true
			while wait < 200 do
				wait = wait + 1
				DrawAdvancedText(0.588, 0.836, 0.005, 0.0028, 0.4, text, 255, 255, 255, 255, 6, 0)
				Wait(10)
			end
			wait = 0
			textActif = false
		end)
	end
end

function isListeBlackListed(model)
	for _, blacklistedCar in pairs(ListeBlackList) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end