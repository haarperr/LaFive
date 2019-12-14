--------------- Farm by Zikoz x) ---------------
------------------------------------------------

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
mainMenu = NativeUI.CreateMenu("Orange", "Liste", 4, 200)
mainMenuSachet = NativeUI.CreateMenu("Orange", "Liste", 4, 200)
mainMenuVente = NativeUI.CreateMenu("Orange", "Liste", 4, 200)
_menuPool:Add(mainMenu)
_menuPool:Add(mainMenuSachet)
_menuPool:Add(mainMenuVente)

function OrangeFarmMenu(menu)

    recolteorange = NativeUI.CreateItem("Récolter des oranges", "")
    menu:AddItem(recolteorange)

    menu.OnItemSelect = function(menu, item)
        if item == recolteorange then
            _menuPool:CloseAllMenus(true)
            notify('~g~Vous êtes entrain de récolté des oranges...')
            FreezeEntityPosition(GetPlayerPed(-1),true) 
            Wait(30000)
            TriggerServerEvent('recoOrange')
            FreezeEntityPosition(GetPlayerPed(-1),false) 
        end
    end
end

function OrangeSachetMenu(menu)

    schorange = NativeUI.CreateItem("Mettre vos oranges en sachet", "")
    menu:AddItem(schorange)

    menu.OnItemSelect = function(menu, item)
        if item == schorange then            
            _menuPool:CloseAllMenus(true)
            notify('~g~Vous êtes entrain de mettre en sachet vos oranges...')
            FreezeEntityPosition(GetPlayerPed(-1),true)
            Wait(30000)
            TriggerServerEvent('schOrange')
            FreezeEntityPosition(GetPlayerPed(-1),false) 
        end
    end
end

function OrangeVenteMenu(menu)

    dealer = NativeUI.CreateItem("Vendre vos sachets", "")
    menu:AddItem(dealer)

    menu.OnItemSelect = function(menu, item)
        if item == dealer then
            _menuPool:CloseAllMenus(true)
            notify('~g~Vous êtes entrain de vendre vos sachets d\'Oranges...')
            FreezeEntityPosition(GetPlayerPed(-1),true)
            Wait(5000)
            TriggerServerEvent('vendreOrange')
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end


OrangeFarmMenu(mainMenu)
OrangeSachetMenu(mainMenuSachet)
OrangeVenteMenu(mainMenuVente)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    while true do
        Wait(0)
        _menuPool:ProcessMenus()

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            if IsEntityAtCoord(PlayerPedId(), 354.65, 6517.87, 28.26, 30.5, 20.5, 15.5, 0, 1, 0) then 
  
                        ESX.ShowHelpNotification("Appuie sur ~INPUT_TALK~ pour récolter des ~o~oranges")
                        if IsControlJustPressed(1, 51) then
                            mainMenu:Visible(not mainMenu:Visible())
                        end
                    end
                end    
        end)

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                Wait(0)
        
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    if IsEntityAtCoord(PlayerPedId(), 395.14, 3569.1, 32.29, 3.5, 3.5, 3.5, 0, 1, 0) then 
          
                                ESX.ShowHelpNotification("Appuie sur ~INPUT_TALK~ pour mettre en sachet des ~b~Oranges")
                                if IsControlJustPressed(1, 51) then
                                    mainMenuSachet:Visible(not mainMenuSachet:Visible())
                                end
                            end
                        end    
                end)

                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    while true do
                        Wait(0)
                
                            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                            if IsEntityAtCoord(PlayerPedId(), -1479.37, -374.37, 38.17, 2.5, 2.5, 2.5, 0, 1, 0) then 
                  
                                        ESX.ShowHelpNotification("Appuie sur ~INPUT_TALK~ pour vendre vos sachets ~b~d'Oranges")
                                        if IsControlJustPressed(1, 51) then
                                            mainMenuVente:Visible(not mainMenuVente:Visible())
                                        end
                                    end
                                end    
                        end)

        function notify(text)
            SetNotificationTextEntry('STRING')
            AddTextComponentString(text)
            DrawNotification(false, false)
        end

        -- Blips

Citizen.CreateThread(function()

    if Config.EnableBlips then
        for _, info in pairs(Config.Zones) do
            local blip = AddBlipForCoord(info.x, info.y, info.z)

            SetBlipSprite(blip, Config.Blip.Sprite)
            SetBlipDisplay(blip, Config.Blip.Display)
            SetBlipScale(blip, Config.Blip.Scale)
            SetBlipColour(blip, Config.Blip.Colour)
            SetBlipAsShortRange(blip, true)
        
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blip.Text)
            EndTextCommandSetBlipName(blip)
        
        end
    end
end)

