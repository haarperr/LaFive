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
mainMenu = NativeUI.CreateMenu("Pharmacie","~b~Pharmacie", "Pharmacie")
_menuPool:Add(mainMenu)

function AddShopsMenu(menu)
    local soins = _menuPool:AddSubMenu(menu, "Premiers soins", "Pour soigner vos bobos", 5, 100,"","","",210,0,0)
    soins.Item:RightLabel("→") 
    
    local pilules = _menuPool:AddSubMenu(menu, "Pilules louches", "...", 5, 100,"","","",210,0,0)
    pilules.Item:RightLabel("→") 

    local band = NativeUI.CreateItem("Kit de premiers soins", "")
    soins.SubMenu:AddItem(band)
    band:RightLabel("~g~4500$")

    local defib = NativeUI.CreateItem("Défibrillateur", "")
    soins.SubMenu:AddItem(defib)
    defib:RightLabel("~g~100000$")

    local piluleoubli = NativeUI.CreateItem("~b~Pilule de l'oubli", "")
    pilules.SubMenu:AddItem(piluleoubli)
    piluleoubli:RightLabel("~r~2300$")

    soins.SubMenu.OnItemSelect = function(menu, item)
    if item == band then
            TriggerServerEvent('buyBand')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Pharmacien", "Vous avez acheter un ~b~kit de premiers soins pour ~g~4500$", "", "CHAR_MP_PROF_BOSS", 1)
        elseif item == defib then
            TriggerServerEvent('buyDefib')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Pharmacien", "Vous avez acheter un ~b~défibrillateur pour ~g~100k$", "", "CHAR_MP_PROF_BOSS", 1)
        end
    end
    
    pilules.SubMenu.OnItemSelect = function(menu, item)
    if item == piluleoubli then
            TriggerServerEvent('buyPo')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Pharmacien", "Vous avez acheter une ~r~pilule de l'oublie pour ~r~2300$", "", "CHAR_MP_PROF_BOSS", 1)
        end
    end
end

AddShopsMenu(mainMenu)
_menuPool:RefreshIndex()

local larko = {
    {x = 98.45,    y = -225.41,  z = 53.64},
    {x = 591.24,   y = 2744.42,  z = 41.04},
    {x = 326.53,   y = -1074.25, z = 28.48},
    {x = 213.69,   y = -1835.14, z = 26.56},
    {x = -3157.74, y = 1095.24,  z = 19.85},
    {x = 542.6, y = -1579.08,  z = 28.28}
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(larko) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, larko[k].x, larko[k].y, larko[k].z)

            if dist <= 3.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour discuter avec le ~b~pharmacien")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local blips = {
    {title="Pharmacie", colour=1, id=403,x = 98.45,    y = -225.41,  z = 53.64 },
    {title="Pharmacie", colour=1, id=403,x = 591.24,   y = 2744.42,  z = 41.04 },
    {title="Pharmacie", colour=1, id=403,x = 326.53,   y = -1074.25, z = 28.48 },
    {title="Pharmacie", colour=1, id=403,x = 213.69,   y = -1835.14, z = 26.56 },
    {title="Pharmacie", colour=1, id=403,x = -3157.74, y = 1095.24,  z = 19.85 },
    {title="Pharmacie", colour=1, id=403,x = 542.74, y = -1579.08,  z = 19.85 }
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.7)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

RegisterNetEvent('esx_pharmacy:useKit')
AddEventHandler('esx_pharmacy:useKit', function(itemName, hp_regen)
  local ped    = GetPlayerPed(-1)
  local health = GetEntityHealth(ped)
  local max    = GetEntityMaxHealth(ped)

  if health > 0 and health < max then

    TriggerServerEvent('esx_pharmacy:removeItem', itemName)
    ESX.UI.Menu.CloseAll()
    ESX.ShowNotification(_U('use_firstaidkit'))

    health = health + (max / hp_regen)
    if health > max then
      health = max
    end
    SetEntityHealth(ped, health)
  end
end)

RegisterNetEvent('esx_pharmacy:useDefibrillateur')
AddEventHandler('esx_pharmacy:useDefibrillateur', function(itemName)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.ShowNotification(_U('no_players'))
  else
    local ped    = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(ped)

    if health == 0 then
      local playerPed = GetPlayerPed(-1)
      Citizen.CreateThread(function()
        ESX.ShowNotification(_U('revive_inprogress'))
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(15000)
        ClearPedTasks(playerPed)
        if GetEntityHealth(closestPlayerPed) == 0 then
          TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
          ESX.ShowNotification(_U('revive_complete') .. GetPlayerName(closestPlayer))
        else
          ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('isdead'))
        end
      end)
    else
		  ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('unconscious'))
    end
  end
end)