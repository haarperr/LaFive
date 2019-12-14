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

local PID           			= 0
local GUI           			= {}
local metalQTE                  = 0
ESX 			    			= nil
GUI.Time            			= 0
local metalQTE                  = 0
local sulfurQTE                 = 0
local charcoalQTE               = 0
local hqQTE                     = 0
local boxQTE                    = 0
local plasticQTE                = 0
local pipeQTE                   = 0
local steelQTE                  = 0
local myJob 					= nil
local PlayerData 				= {}
local GUI 						= {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('esx_crafting:hasEnteredMarker', function(zone)

        ESX.UI.Menu.CloseAll()

        if zone == 'exitMarker' then
            CurrentAction     = zone
            CurrentActionMsg  = ('Appuyez sur ~INPUT_CONTEXT~ pour arrêter de récolter')
            CurrentActionData = {}
        end


        --Metal
        if zone == 'metalmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'metal_make'
                 CurrentActionMsg  = _U('press_collect_metal')
                 CurrentActionData = {}
            end
         end

         --Sulfur
         if zone == 'sulfurmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'sulfur_make'
                 CurrentActionMsg  = _U('press_collect_sulfur')
                 CurrentActionData = {}
            end
         end

         --Charcoal
         if zone == 'charcoalmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'charcoal_make'
                 CurrentActionMsg  = _U('press_collect_charcoal')
                 CurrentActionData = {}
            end
         end     
         
        --HQ
         if zone == 'hqmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'hq_make'
                 CurrentActionMsg  = _U('press_transform_metal')
                 CurrentActionData = {}
            end
         end   
         if zone == 'boxmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'box_make'
                 CurrentActionMsg  = _U('press_collect_box')
                 CurrentActionData = {}
            end
         end   
        --Spring
        if zone == 'springmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'spring_make'
                 CurrentActionMsg  = _U('press_collect_spring')
                 CurrentActionData = {}
            end
         end
        --Plastic
        if zone == 'plasticmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'plastic_make'
                 CurrentActionMsg  = _U('press_collect_plastic')
                 CurrentActionData = {}
            end
         end
        --Metalpipe
        if zone == 'pipemake' then
            if myJob ~= "police" then
                 CurrentAction     = 'pipe_make'
                 CurrentActionMsg  = _U('press_collect_pipe')
                 CurrentActionData = {}
            end
         end
        --Steel
        if zone == 'steelmake' then
            if myJob ~= "police" then
                 CurrentAction     = 'steel_make'
                 CurrentActionMsg  = _U('press_collect_steel')
                 CurrentActionData = {}
            end
         end



end)

AddEventHandler('esx_crafting:hasExitedMarker', function(zone)

        CurrentAction = nil
        ESX.UI.Menu.CloseAll()

        TriggerServerEvent('esx_crafting:stopMakeMetal')
        TriggerServerEvent('esx_crafting:stopMakeSulfur')
        TriggerServerEvent('esx_crafting:stopMakeCharcoal')
        TriggerServerEvent('esx_crafting:stopTransformMetal')
        TriggerServerEvent('esx_crafting:stopMakeBox')
        TriggerServerEvent('esx_crafting:stopMakeSpring')
        TriggerServerEvent('esx_crafting:stopMakePlastic')
        TriggerServerEvent('esx_crafting:stopMakePipe')
        TriggerServerEvent('esx_crafting:stopMakeSteel')
        
end)


-- Render markers
Citizen.CreateThread(function()
    while true do

        Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)


-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_crafting:ReturnInventory')
AddEventHandler('esx_crafting:ReturnInventory', function(metalNbr, sulfurNbr, charcoalNbr, hqNbr, boxNbr, springNbr, plasticNbr, pipeNbr, steelNbr, jobName, currentZone)
    metalQTE        = metalNbr
    sulfurQTE       = sulfurNbr
    charcoalQTE     = charcoalNbr
    hqQTE           = hqNbr
    boxQTE          = boxNbr
    springQTE       = springNbr
    plasticQTE      = plasticNbr
    pipeQTE         = pipeNbr
    steelQTE        = steelNbr
    myJob           = jobName
    TriggerEvent('esx_crafting:hasEnteredMarker', currentZone)
end)


-- Activate menu when player is inside marker
Citizen.CreateThread(function()
    while true do

        Wait(0)

        local coords      = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker  = false
        local currentZone = nil

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
                isInMarker  = true
                currentZone = k
            end
        end

        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            lastZone                = currentZone
            TriggerServerEvent('esx_crafting:GetUserInventory', currentZone)
        end

        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('esx_crafting:hasExitedMarker', lastZone)
        end
        if isInMarker and isInZone then
            TriggerEvent('esx_crafting:hasEnteredMarker', 'exitMarker')
        end
    end
end)


-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, Keys['E']) then
				isInZone = true -- unless we set this boolean to false, we will always freeze the user
				if CurrentAction == 'exitMarker' then
					isInZone = false -- do not freeze user
					TriggerEvent('esx_crafting:freezePlayer', false)
					TriggerEvent('esx_crafting:hasExitedMarker', lastZone)
					Citizen.Wait(15000)
           -- if IsControlJustReleased(0, 38) then
                elseif CurrentAction == 'metal_make' then
                    TriggerServerEvent('esx_crafting:startMakeMetal')
                elseif CurrentAction == 'sulfur_make' then
                    TriggerServerEvent('esx_crafting:startMakeSulfur')
                elseif CurrentAction == 'charcoal_make' then
                    TriggerServerEvent('esx_crafting:startMakeCharcoal')
                elseif CurrentAction == 'hq_make' then
                    TriggerServerEvent('esx_crafting:startTransformMetal')
                elseif CurrentAction == 'box_make' then
                    TriggerServerEvent('esx_crafting:startMakeBox')
                elseif CurrentAction == 'spring_make' then
                    TriggerServerEvent('esx_crafting:startMakeSpring')
                elseif CurrentAction == 'plastic_make' then
                    TriggerServerEvent('esx_crafting:startMakePlastic')
                elseif CurrentAction == 'pipe_make' then
                    TriggerServerEvent('esx_crafting:startMakePipe')
                elseif CurrentAction == 'steel_make' then
                    TriggerServerEvent('esx_crafting:startMakeSteel')
                else
                    isInZone = false -- not a crafting zone
                end

                if isInZone then
                    TriggerEvent('esx_crafting:freezePlayer', true)
                end

                CurrentAction = nil
            end
        end
    end
end)

RegisterNetEvent('esx_crafting:freezePlayer')
AddEventHandler('esx_crafting:freezePlayer', function(freeze)
	FreezeEntityPosition(GetPlayerPed(-1), freeze)
end)

