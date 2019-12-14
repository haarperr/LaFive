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
mainMenu = NativeUI.CreateMenu("Location","Liste", nil, nil, "shopui_title_sm_hangar", "shopui_title_sm_hangar")
_menuPool:Add(mainMenu)


spawnCar = function(boat)
    local boat = GetHashKey(boat)

    RequestModel(boat)
    while not HasModelLoaded(boat) do
        RequestModel(boat)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(boat, -1630.3711914063, -1165.87890625, 0.140752372742, 223.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LaFive")
end

function AddBoatMenu(menu)

------ Menu

    local carsubmenu = _menuPool:AddSubMenu(menu, "Bateaux normaux", nil, nil, "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    carsubmenu.Item:SetRightBadge(BadgeStyle.Car)

    local largeboatmenu = _menuPool:AddSubMenu(menu, "Bateaux large", nil, nil, "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    largeboatmenu.Item:SetRightBadge(BadgeStyle.Car)

------ Car Items

    local seashark = NativeUI.CreateItem("Scooter de mer", "")
    carsubmenu.SubMenu:AddItem(seashark)
    seashark:RightLabel("500$")

    local jetmax = NativeUI.CreateItem("Jetmax", "")
    carsubmenu.SubMenu:AddItem(jetmax)
    jetmax:RightLabel("850$")

    local toro = NativeUI.CreateItem("Toro", "")
    largeboatmenu.SubMenu:AddItem(toro)
    toro:RightLabel("3500$")

    local marquis = NativeUI.CreateItem("Bateau à voile", "")
    largeboatmenu.SubMenu:AddItem(marquis)
    marquis:RightLabel("5000$")

    carsubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == seashark then
            TriggerServerEvent('buySeashark')
            ESX.ShowNotification('Vous avez payez ~r~500$')
            Citizen.Wait(0)
            spawnCar("seashark")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~véhicule ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        elseif item == jetmax then
            TriggerServerEvent('buyJetmax')
            ESX.ShowNotification('Vous avez payez ~r~850$')
            Citizen.Wait(0)
            spawnCar("jetmax")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~véhicule ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        end
    end

    largeboatmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == toro then
            TriggerServerEvent('buyToro')
            ESX.ShowNotification('Vous avez payez ~r~3500$')
            Citizen.Wait(0)
            spawnCar("toro")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~moto ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        elseif item == marquis then
            TriggerServerEvent('buyMarquis')
            ESX.ShowNotification('Vous avez payez ~r~5000$')
            Citizen.Wait(0)
            spawnCar("marquis")
            ESX.ShowAdvancedNotification("Location", "Votre ~b~moto ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus(true)
        end
    end
end
        
AddBoatMenu(mainMenu)
_menuPool:RefreshIndex()



-- Blips

local blips = {
    {title="~b~Location de bateaux", colour=3, id=316, x = -1612.22, y = -1147.9, z = 0.480758094788}
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
	{x = -1612.22, y = -1147.9, z = 0.480758094788},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(zikoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, zikoz[k].x, zikoz[k].y, zikoz[k].z)

            if dist <= 3.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec ~b~Miikeuh")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local v1 = vector3(-1612.22, -1147.9031738281, 2.70)

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
            Draw3DText(v1.x,v1.y,v1.z, "Miikeuh")
		end
	end
end)

--Citizen.CreateThread(function()
--    local hash = GetHashKey("cs_old_man2")
--    while not HasModelLoaded(hash) do
--    RequestModel(hash)
--    Wait(20)
--    end
--	ped = CreatePed("PED_TYPE_CIVMALE", "cs_old_man2", -1612.22, -1147.9031738281, 0.70, 317.591, true, true)
--    SetBlockingOfNonTemporaryEvents(ped, true)
--    SetEntityAsMissionEntity(ped)
--    SetEntityInvincible(ped, true)
--    FreezeEntityPosition(ped, true)
--    SetModelAsNoLongerNeeded(cs_old_man2)
--end)
