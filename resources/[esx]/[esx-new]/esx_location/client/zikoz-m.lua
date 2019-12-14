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

ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Location","Liste", nil, nil, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
_menuPool:Add(mainMenu)


spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, -495.7711914063, -668.97890625, 32.81, 267.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LF:Loc")
end

function AddCarMenu(menu)

------ Menu

    local carsubmenu = _menuPool:AddSubMenu(menu, "Voiture", nil, nil, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    carsubmenu.Item:RightLabel("→") 

    local motosubmenu = _menuPool:AddSubMenu(menu, "Moto", nil, nil, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    motosubmenu.Item:RightLabel("→") 

    local velosubmenu = _menuPool:AddSubMenu(menu, "Vélo", nil, nil, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    velosubmenu.Item:RightLabel("→") 

------ Car Items

    local blista = NativeUI.CreateItem("Blista", "")
    carsubmenu.SubMenu:AddItem(blista)
    blista:RightLabel("500$")

    local vespa = NativeUI.CreateItem("Vespa", "")
    motosubmenu.SubMenu:AddItem(vespa)
    vespa:RightLabel("350$")

    local bmx = NativeUI.CreateItem("BMX", "")
    velosubmenu.SubMenu:AddItem(bmx)
    bmx:RightLabel("75$")

    carsubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == blista then
            TriggerServerEvent('buyBlista')
            ESX.ShowNotification('Vous avez payez ~r~500$')
            Citizen.Wait(0)
            spawnCar("blista")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~véhicule ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        end
    end

    motosubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == vespa then
            TriggerServerEvent('buyVespa')
            ESX.ShowNotification('Vous avez payez ~r~350$')
            Citizen.Wait(0)
            spawnCar("faggio2")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~moto ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        end
    end

    velosubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == bmx then
            TriggerServerEvent('buyBmx')
            ESX.ShowNotification('Vous avez payez ~r~75$')
            Citizen.Wait(0)
            spawnCar("bmx")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~vélo ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        end
    end
end
        
AddCarMenu(mainMenu)
_menuPool:RefreshIndex()



-- Blips

local blips = {
    {title="~b~Location", colour=3, id=315, x = -490.4936523438, y = -690.28031738281, z = 13.830758094788}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

local zikoz = {
	{x = -490.52936523438, y = -690.2831738281, z = 33.21},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(zikoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, zikoz[k].x, zikoz[k].y, zikoz[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec ~b~Hakim")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local v1 = vector3(-1043.4936523438, -2661.5031738281, 14.830758094788)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 20

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x,v1.y,v1.z, "Hakim")
		end
	end
end)

--Citizen.CreateThread(function()
--    local hash = GetHashKey("s_m_m_gardener_01")
--    while not HasModelLoaded(hash) do
--    RequestModel(hash)
--    Wait(20)
--    end
--	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_gardener_01", -1043.4936523438, -2661.5031738281, 12.830758094788, 224.591, true, true)
--    SetBlockingOfNonTemporaryEvents(ped, true)
--    SetEntityInvincible(ped, true)
--    FreezeEntityPosition(ped, true)
--    SetEntityAsMissionEntity(ped, true, true)
--    SetPedHearingRange(ped, 0.0)
--    SetPedSeeingRange(ped, 0.0)
--    SetPedFleeAttributes(ped, 0, 0)
--    SetPedCombatAttributes(ped, 46, true)
--end)
