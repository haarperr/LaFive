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

local PlayerData                = {}
local GUI                       = {}

ESX = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job2 == nil do
			Citizen.Wait(10)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()

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
mainMenu = NativeUI.CreateMenu("","Menu interaction illégal", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")
_menuPool:Add(mainMenu)

function lrkgang(menu)
    local civ = _menuPool:AddSubMenu(menu, "Interaction citoyen", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")
    civ.SubMenu:SetMenuWidthOffset(60)
    civ.Item:RightLabel("→") 
    
    local veh = _menuPool:AddSubMenu(menu, "Interaction véhicule", nil, nil, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod")
    veh.SubMenu:SetMenuWidthOffset(60)
    veh.Item:RightLabel("→") 

    local mote = NativeUI.CreateItem("Menotter & démenotter", "")
    civ.SubMenu:AddItem(mote)

    local drag = NativeUI.CreateItem("Trainer", "")
    civ.SubMenu:AddItem(drag)

    local put = NativeUI.CreateItem("Jeter dans un véhicule", "")
    civ.SubMenu:AddItem(put)

    local out = NativeUI.CreateItem("Sortir du véhicule", "")
    civ.SubMenu:AddItem(out)

    local lockpick = NativeUI.CreateItem("Crocheter un véhicule", "")
    veh.SubMenu:AddItem(lockpick)

    local info = NativeUI.CreateItem("Informations sur le véhicule (en cours de dev)", "")
    info:SetRightBadge(BadgeStyle.Alert)
    veh.SubMenu:AddItem(info)

    civ.SubMenu.OnItemSelect = function(menu, item)
      if item == mote then
        local Ped = GetPlayerPed(-1)

        ShortestDistance = 2
        ClosestId = 0

        for ID = 0, 256 do
            if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
                Ped2 = GetPlayerPed(ID)
                local x, y, z = table.unpack(GetEntityCoords(Ped))
                if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                    ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                    ClosestId = GetPlayerServerId(ID)
                end
            end
        end

        if ClosestId == 0 then
          ESX.ShowNotification('~r~Aucun joueur a proximité!')
            return
        end

        TriggerServerEvent('SEM_CuffNear', ClosestId)
    elseif item == drag then
      local Ped = GetPlayerPed(-1)

      ShortestDistance = 2
      ClosestId = 0

      for ID = 0, 256 do
          if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
              Ped2 = GetPlayerPed(ID)
              local x, y, z = table.unpack(GetEntityCoords(Ped))
              if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                  ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                  ClosestId = GetPlayerServerId(ID)
              end
          end
      end

      if ClosestId == 0 then
        ESX.ShowNotification('~r~Aucun joueur a proximité!')
          return
      end

      TriggerServerEvent('SEM_DragNear', ClosestId)
        ESX.ShowNotification('Vous ~r~tenez ~w~l\'individu')
    elseif item == put then
      local Ped = GetPlayerPed(-1)
      local Veh = GetVehiclePedIsIn(Ped, true)

      ShortestDistance = 2
      ClosestId = 0

      for ID = 0, 256 do
          if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
              Ped2 = GetPlayerPed(ID)
              local x, y, z = table.unpack(GetEntityCoords(Ped))
              if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                  ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                  ClosestId = GetPlayerServerId(ID)
              end
          end
      end

      if ClosestId == 0 then
        ESX.ShowNotification('~r~Aucun joueur a proximité!')
          return
      end

      TriggerServerEvent('SEM_SeatNear', ClosestId, Veh)
      Citizen.Wait(500)
      TriggerServerEvent('SEM_DragNear', ClosestId)
        ESX.ShowNotification('Vous avez ~r~jeter ~w~l\'individu dans le véhicule')
    elseif item == out then
      local Ped = GetPlayerPed(-1)

      ShortestDistance = 2
      ClosestId = 0

      for ID = 0, 256 do
          if NetworkIsPlayerActive(ID) and GetPlayerPed(ID) ~= GetPlayerPed(-1) then
              Ped2 = GetPlayerPed(ID)
              local x, y, z = table.unpack(GetEntityCoords(Ped))
              if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  ShortestDistance) then
                  ShortestDistance = GetDistanceBetweenCoords(GetEntityCoords(Ped), x, y, z)
                  ClosestId = GetPlayerServerId(ID)
              end
          end
      end

      if ClosestId == 0 then
        ESX.ShowNotification('~r~Aucun joueur a proximité!')
          return
      end
      
      TriggerServerEvent('SEM_UnseatNear', ClosestId)
      Citizen.Wait(500)
      TriggerServerEvent('SEM_DragNear', ClosestId)
        ESX.ShowNotification('Vous avez ~r~sorti ~w~l\'individu du véhicule')
    elseif item == search then
        local player, distance = ESX.Game.GetClosestPlayer()

        if distance ~= -1 and distance <= 3.0 then
        OpenBodySearchMenu(player)
        end
        end
    end

    veh.SubMenu.OnItemSelect = function(menu, item)
        if item == lockpick then
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)

            if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

              local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

              if DoesEntityExist(vehicle) then

                Citizen.CreateThread(function()

                  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

                  Wait(20000)

                  ClearPedTasksImmediately(playerPed)

                  SetVehicleDoorsLocked(vehicle, 1)
                  SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                  TriggerEvent('esx:showNotification', ('Véhicule ~g~ouvert!'))

                end)

              end
            else
                ESX.ShowNotification(('Pas de ~r~véhicule ~w~a proximité!'))
            end
          elseif item == info then
            ESX.ShowNotification('~r~Cette fonctionnalité est encore en cours de développement')
        end
    end
end

lrkgang(mainMenu)
mainMenu:SetMenuWidthOffset(60)
_menuPool:RefreshIndex()



function OpenBodySearchMenu(player)

    ESX.TriggerServerCallback('esx_vagosjob:getOtherPlayerData', function(data)
  
      local elements = {}
  
      local blackMoney = 0
  
      for i=1, #data.accounts, 1 do
        if data.accounts[i].name == 'black_money' then
          blackMoney = data.accounts[i].money
        end
      end
  
      table.insert(elements, {
        label          = _U('confiscate_dirty') .. blackMoney,
        value          = 'black_money',
        itemType       = 'item_account',
        amount         = blackMoney
      })
  
      table.insert(elements, {label = '--- Armes ---', value = nil})
  
      for i=1, #data.weapons, 1 do
        table.insert(elements, {
          label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
          value          = data.weapons[i].name,
          itemType       = 'item_weapon',
          amount         = data.ammo,
        })
      end
  
      table.insert(elements, {label = _U('inventory_label'), value = nil})
  
      for i=1, #data.inventory, 1 do
        if data.inventory[i].count > 0 then
          table.insert(elements, {
            label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
            value          = data.inventory[i].name,
            itemType       = 'item_standard',
            amount         = data.inventory[i].count,
          })
        end
      end
  
  
      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'body_search',
        {
          title    = _U('search'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)
  
          local itemType = data.current.itemType
          local itemName = data.current.value
          local amount   = data.current.amount
  
          if data.current.value ~= nil then
  
            TriggerServerEvent('esx_vagosjob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
  
            OpenBodySearchMenu(player)
  
          end
  
        end,
        function(data, menu)
          menu.close()
        end
      )
  
    end, GetPlayerServerId(player))
  
  end


--Cuffing Event
RegisterNetEvent('SEM_Cuff')
AddEventHandler('SEM_Cuff', function()
	Ped = GetPlayerPed(-1)
	if (DoesEntityExist(Ped)) then
		Citizen.CreateThread(function()
		    RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			end
			if isCuffed then
				ClearPedSecondaryTask(Ped)
				StopAnimTask(Ped, 'mp_arresting', 'idle', 3)
				SetEnableHandcuffs(Ped, false)
				isCuffed = false
			else
				TaskPlayAnim(Ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(Ped, true)
				isCuffed = true
			end
		end)
	end
end)

--Cuff Animation & Restructions
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCuffed and not IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 3) then
			Citizen.Wait(3000)
			TaskPlayAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'mp_arresting', 'idle', 3) then
			DisableControlAction(1, 140, true) --R
			DisableControlAction(1, 141, true) --Q
			DisableControlAction(1, 142, true) --LMB
			SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true) --Vehicle Driving
			end
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), 'random@mugging3', 'handsup_standing_base', 3) then
			DisableControlAction(1, 140, true) --R
			DisableControlAction(1, 141, true) --Q
			DisableControlAction(1, 142, true) --LMB
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true) --Vehicle Driving
			end
		end
	end
end)

--Dragging Event
local Drag = false
local OfficerDrag = -1
RegisterNetEvent('Drag')
AddEventHandler('Drag', function(a)
	Drag = not Drag
	OfficerDrag = a
end)

--Drag Attachment
Citizen.CreateThread(function()
    while true do
      Wait(0)
          if Drag then
              local Ped = GetPlayerPed(GetPlayerFromServerId(OfficerDrag))
              local Ped2 = PlayerPedId()
              AttachEntityToEntity(Ped2, Ped, 4103, 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
              StillDragged = true
          else
              if(StillDragged) then
                  DetachEntity(PlayerPedId(), true, false)
                  StillDragged = false
              end
          end
    end
end)

--Force Seat Player Event
RegisterNetEvent('SEM_Seat')
AddEventHandler('SEM_Seat', function(Veh)
	local Pos = GetEntityCoords(PlayerPedId())
	local EntityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    local RayHandle = CastRayPointToPoint(Pos.x, Pos.y, Pos.z, EntityWorld.x, EntityWorld.y, EntityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, VehicleHandle = GetRaycastResult(RayHandle)
    if VehicleHandle ~= nil then
		SetPedIntoVehicle(PlayerPedId(), VehicleHandle, 1)
	end
end)



--Force Unseat Player Event
RegisterNetEvent('SEM_Unseat')
AddEventHandler('SEM_Unseat', function(ID)
	local Ped = GetPlayerPed(ID)
	ClearPedTasksImmediately(Ped)
	PlayerPos = GetEntityCoords(PlayerPedId(),  true)
	local X = PlayerPos.x - 0
	local Y = PlayerPos.y - 0

    SetEntityCoords(PlayerPedId(), X, Y, PlayerPos.z)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);
	        	if IsControlJustPressed(0,  Keys['F9']) and PlayerData.job2 ~= nil and (PlayerData.job2.name == 'families' or 'ms13' or 'ballas' or 'vagos' or 'mafia') then 
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)
