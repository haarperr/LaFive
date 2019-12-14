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
local ped = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","Vendeur d'armes illégales", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")
_menuPool:Add(mainMenu)

function AddRepairMenu(menu)

    local gunmenu = _menuPool:AddSubMenu(menu, "Armes", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")

    local itemmenu = _menuPool:AddSubMenu(menu, "Items", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")

    local car = NativeUI.CreateItem("Carabine d'assaut", "")
    gunmenu.SubMenu:AddItem(car)
    car:RightLabel("120000$")

    local ass = NativeUI.CreateItem("Fusil d'assaut", "")
    gunmenu.SubMenu:AddItem(ass)
    ass:RightLabel("112500$")

    local spe = NativeUI.CreateItem("Carabine spécial", "")
    gunmenu.SubMenu:AddItem(spe)
    spe:RightLabel("93750$")

    local mic = NativeUI.CreateItem("Micro SMG", "")
    gunmenu.SubMenu:AddItem(mic)
    mic:RightLabel("60000$")

    local taz = NativeUI.CreateItem("Tazer", "")
    gunmenu.SubMenu:AddItem(taz)
    taz:RightLabel("3750$")

    local sni = NativeUI.CreateItem("Sniper", "")
    gunmenu.SubMenu:AddItem(sni)
    sni:RightLabel("150000$")

    local caro = NativeUI.CreateItem("Aucun items pour l'instant", "")
    itemmenu.SubMenu:AddItem(caro)
	caro:SetRightBadge(BadgeStyle.Alert)

    gunmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == car then
        TriggerServerEvent("BuyCar")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Carabine d'assaut", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
    elseif item == ass then 
        TriggerServerEvent("BuyAss")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Fusil d'assaut", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
    elseif item == mic then
        TriggerServerEvent("BuyMic")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Micro SMG", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
    elseif item == spe then
        TriggerServerEvent("BuySpe")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Carabine spécial", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
    elseif item == taz then
        TriggerServerEvent("BuyTaz")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Tazer", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
    elseif item == sni then
        TriggerServerEvent("BuySni")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Sniper", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
        end
    end

    itemmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == caro then
        TriggerServerEvent("BuyCaro")
        ESX.ShowAdvancedNotification("X", "Préparation...", "", "CHAR_HUMANDEFAULT", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("X", "~g~Kit de Carosserie", "", "CHAR_HUMANDEFAULT", 1)
        _menuPool:CloseAllMenus(true)
        end
    end
end

AddRepairMenu(mainMenu)
_menuPool:RefreshIndex()

local zikoz = {
    {x = 2943.0, y = 4626.1, z = 47.720},

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
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parlez avec le ~r~vendeur d'armes illegales")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local ped = vector3(2943.0, 4626.12123413086, 49.10)

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
        if Vdist2(GetEntityCoords(PlayerPedId(), false), ped) < distance then
            Draw3DText(ped.x,ped.y,ped.z, "X")
		end
	end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_dockwork_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 2942.99, 4626.1, 47.787968444824, 156.591, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityAsMissionEntity(ped)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetModelAsNoLongerNeeded(s_m_m_dockwork_01)
end)
