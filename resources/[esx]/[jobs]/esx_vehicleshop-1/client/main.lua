local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsgxxxx        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
currentZonePRW = nil
ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)



	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)



function OpenShopMenu ()
  TriggerEvent("opentestmenu")
end



AddEventHandler('esx_vehicleshop:hasEnteredMarker', function (zone)
  if zone == 'ShopEntering' then
    if Config.EnablePlayerManagement then
      if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
        CurrentAction     = 'reseller_menu'
        CurrentActionMsgxx  = 'shop_menu'
        CurrentActionData = {}
      end
    else
      CurrentAction     = 'shop_menu'
      CurrentActionMsgxx  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la tablette'
      CurrentActionData = {}
    end
  end

  if zone == 'ShopImport' then

    currentZonePRW = zone
	CurrentAction     = 'ShopImport'
	CurrentActionMsgxx  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le catalogue'
	CurrentActionData = {}
  
end
if zone == 'ShopImport2' then

    currentZonePRW = zone
	CurrentAction     = 'ShopImport'
	CurrentActionMsgxx  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le catalogue'
	CurrentActionData = {}
  
end
  if zone == 'ResellVehicle' then

    
      CurrentAction     = 'occas'
      CurrentActionMsgxx  = 'Appuyez sur ~INPUT_CONTEXT~ pour mettre en vente son véhicule'
      CurrentActionData = {}
    
  end



end)

AddEventHandler('esx_vehicleshop:hasExitedMarker', function (_)
	if not IsInShopMenu then
		TriggerEvent("parow:exit")
	end

	CurrentAction = nil
end)

-- Create Blips

Citizen.CreateThread(function ()
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour(blip,26)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Concessionaire')
	EndTextCommandSetBlipName(blip)

	spa = Config.Zones["ShopImport"]
	local blip = AddBlipForCoord(spa.Pos.x,spa.Pos.y,spa.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour(blip,26)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Concessionaire Import')
	EndTextCommandSetBlipName(blip)
end)
-- Display markers
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		_menuPool:ProcessMenus()
		local coords = GetEntityCoords(PlayerPedId())

		for _,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(20)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_vehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_vehicleshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10)

		if CurrentAction == nil then
			Citizen.Wait(20)
		else

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsgxx)
			DisplayHelpTextFromStringLabel(0, 0, 0, -1)
			local ped = GetPlayerPed(-1)
			c = GetVehiclePedIsIn( ped, false )
			----(c)
			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'shop_menu'  and c == 0 then
					OpenShopMenu()
				elseif CurrentAction == 'occas'and c ~= 0 then
					OpenOccasMenu()
				elseif CurrentAction == 'ShopImport'  and c == 0 then
					OpenImportMenu()
					
        end
			--	CurrentAction = nil
			end
		end
	end
end)

function inShopMenuye(bool)
	IsInShopMenu = bool
end

function OpenOccasMenu()

		TriggerEvent("openOccasMenu")
end
-- Load IPLS
Citizen.CreateThread(function ()
	RemoveIpl('v_carshowroom')
	RemoveIpl('shutter_open')
	RemoveIpl('shutter_closed')
	RemoveIpl('shr_int')
	RemoveIpl('csr_inMission')
	RequestIpl('v_carshowroom')
	RequestIpl('shr_int')
	RequestIpl('shutter_closed')
end)
