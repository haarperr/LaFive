ESX = nil

local ZoneDeSpawn = {coords = vector3(1004.55, -3159.39, -38.90)}



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



Citizen.CreateThread(function()

    while ESX == nil do

        Citizen.Wait(10)

    end

    while true do

        PlayerData = ESX.GetPlayerData()

        grade = PlayerData.job.grade_name

        Citizen.Wait(1000)

    end

end)



_menuPool3 = NativeUI.CreatePool()

NatveVehMenu = NativeUI.CreateMenu("Menu véhicule", "~b~Sortir un véhicule de gang.")

_menuPool3:Add(NatveVehMenu)





function SetVehicleMaxMods(vehicle)

    local props = {

        modEngine       = 3,

        modBrakes       = 3,

        modTransmission = 3,

        modSuspension   = 3,

        modTurbo        = true,

        windowTint = 2,

        modLivery = 2,

        plateIndex = 1,

    }

    SetVehicleCustomPrimaryColour(vehicle, 0,0,0)

    SetVehicleCustomSecondaryColour(vehicle, 0,0,0)

    SetVehicleDirtLevel(vehicle, 0.1)

    ESX.Game.SetVehicleProperties(vehicle, props)

end



function menuVeh(menu)

    local ranger = NativeUI.CreateItem("Ranger le véhicule", "Permet de ~b~ranger ~w~votre véhicule de gang.")

    menu:AddItem(ranger) 

    local hakuchou = NativeUI.CreateItem("Hakuchou", "Sortir un ~b~hakuchou.")

    menu:AddItem(hakuchou)

    local Schafter6  = NativeUI.CreateItem("Schafter6 ", "Sortir un ~b~Schafter6 .")

    menu:AddItem(Schafter6)

    local Baller6 = NativeUI.CreateItem("Baller6", "Sortir un ~b~Baller6.")

    menu:AddItem(Baller6)

    --local g65amg = NativeUI.CreateItem("g65amg", "Sortir une ~b~g65amg.")

    --menu:AddItem(g65amg)



    menu.OnItemSelect = function(sender, item, index)

        if item == ranger then

            local DansVehicule = IsPedInAnyVehicle(GetPlayerPed(-1), false)

			if DansVehicule then

				local ped = GetPlayerPed(-1)

                local vehicle = GetVehiclePedIsIn(ped, false)

                DeleteVehicle(vehicle)

                _menuPool3:CloseAllMenus()

			else

                ESX.ShowHelpNotification('Tu ~r~doit ~w~ etre en véhicule pour utiliser ça.')

                _menuPool3:CloseAllMenus()

			end

        elseif item == hakuchou then

            local ped = GetPlayerPed(-1)

            local veh = ESX.Game.SpawnVehicle("hakuchou", ZoneDeSpawn.coords, 90.0, function(veh)

                SetVehicleMaxMods(veh)

            end)

            _menuPool3:CloseAllMenus()

        elseif item == Schafter6 then

            local ped = GetPlayerPed(-1)

            ESX.Game.SpawnVehicle("Schafter6", ZoneDeSpawn.coords, 90.0, function(veh)

                SetVehicleMaxMods(veh)

            end)

            _menuPool3:CloseAllMenus()

        elseif item == Baller6 then

            local ped = GetPlayerPed(-1)

            ESX.Game.SpawnVehicle("Baller6", ZoneDeSpawn.coords, 90.0, function(veh)

                SetVehicleMaxMods(veh)

            end)

            _menuPool3:CloseAllMenus()

        --elseif item == g65amg then

        --    local ped = GetPlayerPed(-1)

        --    ESX.Game.SpawnVehicle("g65amg", ZoneDeSpawn.coords, 90.0, function(veh)

        --        SetVehicleMaxMods(veh)

        --    end)

        --    _menuPool3:CloseAllMenus()

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

        _menuPool3:ProcessMenus()

        if count == 0 then

            menuVeh(NatveVehMenu)

            count = 1

        end

    end

end)





_menuPool3:RefreshIndex()

_menuPool3:MouseControlsEnabled (false);

_menuPool3:MouseEdgeEnabled (false);

_menuPool3:ControlDisablingEnabled(false);



function MenuVehicule(station)

    NatveVehMenu:Visible(not NatveVehMenu:Visible())

end