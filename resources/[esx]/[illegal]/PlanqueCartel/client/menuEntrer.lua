ESX = nil

local planque1 = {coords = vector3(998.08, -3158.42, -38.90)}



local porteForcer = false

local porteDejaForcer = false

local enInstance = false



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end



	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(10)

	end



	PlayerData = ESX.GetPlayerData()

end)



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

  PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob2')

AddEventHandler('esx:setJob2', function(job2)

  PlayerData.job2 = job2

end)



_menuPool = NativeUI.CreatePool()

mainMenu = NativeUI.CreateMenu("Planque Gang", "~b~Entré d'une planque de gang.")

_menuPool:Add(mainMenu)





function FirstItem(menu) 

    local entrerPlaque = NativeUI.CreateItem("Entrer dans la planque", "~g~Permet de rentrer dans la plaque de gang, si tu à les clefs.")

    menu:AddItem(entrerPlaque)

    local forcerPlaque = NativeUI.CreateItem("Essayer d'entrer (Sans les clefs)", "~r~Si tu rate cela previendra tout les membres de gang à l'interieur.")

    menu:AddItem(forcerPlaque)



    menu.OnItemSelect = function(sender, item, index)

        if item == entrerPlaque then

            if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ms13' then

                local ped = GetPlayerPed(-1)

                ESX.Game.Teleport(ped, planque1.coords, cb)

                _menuPool:CloseAllMenus()

                enInstance = true

            else

                ESX.ShowNotification("~r~La porte ne s'ouvre pas.\n~w~Tu ne possède pas les accès.")

            end

        elseif item == forcerPlaque then

            if porteDejaForcer then

                ESX.ShowNotification("~r~La porte à déja été forcer.\n~w~Attends un peu et recommence.")



            else

                if porteForcer then

                    local ped = GetPlayerPed(-1)

                    ESX.Game.Teleport(ped, planque1.coords, cb)

                    _menuPool:CloseAllMenus()

                    enInstance = true

                    ESX.ShowNotification("~r~La porte était ouverte.\n~w~Tu peu entré mais soit prudent.")

                else

                    TriggerServerEvent("ms13:ForcePorte")

                end

            end

        end

    end

end





RegisterNetEvent('ms13:PorteOuverte')

AddEventHandler('ms13:PorteOuverte', function()

    porteForcer = true

end)



RegisterNetEvent('ms13:PorteFermer')

AddEventHandler('ms13:PorteFermer', function()

    porteForcer = false

end)

-- Forcer la porte réussi

RegisterNetEvent('ms13:PorteForcerOuverte')

AddEventHandler('ms13:PorteForcerOuverte', function()

    porteForcer = true

    if enInstance then

        ESX.ShowNotification("Quelqu'un vient de forcer la porte de la planque !")

        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

    end

    Wait(10*1000)

    porteForcer = false

end)



RegisterNetEvent('ms13:PorteForcerOuverteNotif')

AddEventHandler('ms13:PorteForcerOuverteNotif', function()

    ESX.ShowNotification("Tu a pas réussi à ouvrir la porte")

    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)



    local ped = GetPlayerPed(-1)

    ESX.Game.Teleport(ped, planque1.coords, cb)

    _menuPool:CloseAllMenus()

    enInstance = true

end)





-- Forcer la porte pas réussi

RegisterNetEvent('ms13:PorteForcerFermer')

AddEventHandler('ms13:PorteForcerFermer', function()

    if enInstance then

        ESX.ShowNotification("Quelqu'un à essayer de forcer la porte de la planque")

        PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

    end

    porteDejaForcer = true

    Wait(10*1000)

    porteDejaForcer = false

end)



local count = 1

RegisterNetEvent('ms13:PorteForcerFermerNotif')

AddEventHandler('ms13:PorteForcerFermerNotif', function()

    if count == 1 then

        ESX.ShowNotification("Tu n'a pas réussi à ouvrir la porte")

        PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)

        count = 0

    end

    Wait(3000)

    count = 1

end)



RegisterNetEvent('ms13:SeTrouveDansLinstance')

AddEventHandler('ms13:SeTrouveDansLinstance', function()

    enInstance = true

end)



RegisterNetEvent('ms13:QuitteInstance')

AddEventHandler('ms13:QuitteInstance', function()

    enInstance = false

end)



local count = 0

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        while ESX == nil do

            Citizen.Wait(10)

        end

        _menuPool:ProcessMenus()

        if count == 0 then

            FirstItem(mainMenu)

            count = 1

        end

    end

end)





_menuPool:RefreshIndex()

_menuPool:MouseControlsEnabled (false);

_menuPool:MouseEdgeEnabled (false);

_menuPool:ControlDisablingEnabled(false);



function OuvrirPlanqueGang(station)

    mainMenu:Visible(not mainMenu:Visible())

end