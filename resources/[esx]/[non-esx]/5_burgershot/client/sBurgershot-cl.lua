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
mainMenu = NativeUI.CreateMenu('Burgershot', '~g~À la carte :', 0, 0, 'commonmenu', 'interaction_bgd', 0, 255, 255, 255, 255)
_menuPool:Add(mainMenu)

function AddObjectMenu(menu)

    local bmenu = _menuPool:AddSubMenu(menu, "~g~~s~Hamburger", "~o~Ingrédients: Steak, Oignon, Tomates, Cheddar", 5, 100,"","","",210,0,0)
    bmenu.Item:RightLabel("→") 

    local cmenu = _menuPool:AddSubMenu(menu, "~g~~s~Coca-Cola ", "~o~Composition: Cola, Colorant, Acidifiant", 5, 100,"","","",210,0,0)
    cmenu.Item:RightLabel("→")

    local mmenu = _menuPool:AddSubMenu(menu, "~g~~s~Menu du Jour ", "~o~Composition: Cola, Hamburger, Donut", 5, 100,"","","",210,0,0)
    mmenu.Item:RightLabel("→")

    local bigmac = NativeUI.CreateItem("Achetez", "")
    bmenu.SubMenu:AddItem(bigmac)
    bigmac:RightLabel("5$")

    local cola = NativeUI.CreateItem("Achetez", "")
    cmenu.SubMenu:AddItem(cola)
    cola:RightLabel("2$")

    local formule = NativeUI.CreateItem("Achetez", "")
    mmenu.SubMenu:AddItem(formule)
    formule:RightLabel("12$")


    bmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == bigmac then
            TriggerServerEvent("BuyBigmac")
            ESX.ShowAdvancedNotification("~r~BurgerShot", "~g~Préparation...", "", "CHAR_JIMMY_BOSTON", 1)
            Citizen.Wait(5)
            ESX.ShowAdvancedNotification("~r~BurgerShot", "Tien un bon ~g~Hamburger !", "", "CHAR_JIMMY_BOSTON", 1)
            end
        end
    
    cmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == cola then
            TriggerServerEvent("BuyCola")
            ESX.ShowAdvancedNotification("~r~BurgerShot", "~g~Préparation...", "", "CHAR_JIMMY_BOSTON", 1)
            Citizen.Wait(5)
            ESX.ShowAdvancedNotification("~r~BurgerShot", "Tien un bon ~g~Coca-Cola !", "", "CHAR_JIMMY_BOSTON", 1)
            end
        end
        mmenu.SubMenu.OnItemSelect = function(menu, item)
            if item == formule then
                TriggerServerEvent("BuyMenu")
                ESX.ShowAdvancedNotification("~r~BurgerShot", "~g~Préparation...", "", "CHAR_JIMMY_BOSTON", 1)
                Citizen.Wait(5)
                ESX.ShowAdvancedNotification("~r~BurgerShot", "Tien notre meilleur ~g~Menu !", "", "CHAR_JIMMY_BOSTON", 1)
                _menuPool:CloseAllMenus(true)
                end
            end
    end

AddObjectMenu(mainMenu)
_menuPool:RefreshIndex()

local blips = {
    {title="~r~BurgerShot", colour=1, id=52, x = -1183.5408935547, y = -884.19201660156, z = 13.795839309692},  
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

local sBurgershot = {
    {x = -1193.2465820313, y = -892.30560302734, z = 13.995154380798},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(sBurgershot) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sBurgershot[k].x, sBurgershot[k].y, sBurgershot[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parlez avec le ~g~caissier")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

--local ped = vector3(-1195.4284667969, -893.73004150391, 13.995156288147)

--Citizen.CreateThread(function()
--    local hash = GetHashKey("u_m_y_burgerdrug_01")
--    while not HasModelLoaded(hash) do
--    RequestModel(hash)
--    Wait(20)
--    end
--    ped = CreatePed("PED_TYPE_CIVMALE", "u_m_y_burgerdrug_01",  -1195.4284667969, -893.73004150391, 12.995156288147, 306.8, true, true)
--    SetBlockingOfNonTemporaryEvents(ped, true)
--	FreezeEntityPosition(ped, true)
--end)

