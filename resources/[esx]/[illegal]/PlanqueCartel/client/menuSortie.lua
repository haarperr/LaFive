ESX = nil

local planque1Sortie = {coords = vector3(-330.35, 48.52, 54.42)}



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



function ShowNotification(text)

    SetNotificationTextEntry("STRING")

    AddTextComponentString(text)

    DrawNotification(false, false)

end



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

  PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob2')

AddEventHandler('esx:setJob2', function(job2)

  PlayerData.job2 = job2

end)



_menuPool2 = NativeUI.CreatePool()

sortieMenu = NativeUI.CreateMenu("Planque Gang", "~b~Action planque de gang.")

_menuPool2:Add(sortieMenu)





function SortiePlanque(menu) 

    local option = {

        "Fermer",

        "Ouvert",

    }

    local sortie = NativeUI.CreateItem("Sortir dans la planque", "Permet d'ouvrir ou de fermer la porte de la planque.")

    local ouvrir_fermer = NativeUI.CreateListItem("Ouvrir / fermer la porte", option, 1)

    menu:AddItem(ouvrir_fermer)

    menu:AddItem(sortie)

    menu.OnItemSelect = function(sender, item, index)

        if item == sortie then

            local ped = GetPlayerPed(-1)

            ESX.Game.Teleport(ped, planque1Sortie.coords, cb)

            _menuPool2:CloseAllMenus()

            TriggerEvent("ms13:QuitteInstance")

        end

    end

    menu.OnListChange = function(sender, item, index)

        if item == ouvrir_fermer then

            action = item:IndexToItem(index)

            ShowNotification("Vous avez ~b~"..action.." ~w~la porte.")

            if action == "Ouvert" then

                TriggerServerEvent("ms13:PorteOuverte")

            elseif action == "Fermer" then

                TriggerServerEvent("ms13:PorteFermer")

            end

        end

    end

end





local count = 0

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        while ESX == nil do

            Citizen.Wait(10)

        end

        _menuPool2:ProcessMenus()

        if count == 0 then

            SortiePlanque(sortieMenu)

            count = 1

        end

    end

end)





_menuPool2:RefreshIndex()

_menuPool2:MouseControlsEnabled (false);

_menuPool2:MouseEdgeEnabled (false);

_menuPool2:ControlDisablingEnabled(false);



function SortirPlanqueGang(station)

    sortieMenu:Visible(not sortieMenu:Visible())

end