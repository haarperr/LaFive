

_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

local GUI							= {}
GUI.Time							= 0

local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local currentCat  = nil
local Categories2              = {}
local Vehicles2              = {}
local xp = nil
local LastVehicles            = {}
local cat = {}
local cat2 = {}
local model2 = {}
local cat3 = {}
local model3 = {}
local catJob = {}
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
    end
    load()
end)
RegisterNetEvent("parow:shownotif")
AddEventHandler("parow:shownotif", function(text, color)
    if color == 210 then
        color = 18
    end
    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function(veh)
    json.encode(veh)
    Vehicles = veh
    load()
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function(categories)
    Categories = categories
    load()
end)
function load()
    --("sync")
    cat2 = {}
    cat = {}
    model2={}
    Citizen.Wait(100)
        
    ESX.TriggerServerCallback('parow:getCategories', function (categories)
        Categories = categories
        LoadCategories(Categories)
        --(#Categories)
    end)
    ESX.TriggerServerCallback('parow:getVehicles', function (vehicles)
        Vehicles = vehicles
        LoadVehicles(Vehicles)
    end)
end
function LoadCategories(veh)


    for i=1, #veh, 1 do
        --
        table.insert(cat2,
        {
            v = veh[i].label,
            c = veh[i].name,

            
        }
        )
    end
end


RegisterNetEvent('parow:exit')
AddEventHandler('parow:exit', function()
	if menuaas == true then
        local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
        ----(vehicle)
        if DoesEntityExist(vehicle) then
            ESX.Game.DeleteVehicle(vehicle)
        end
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn( ped, false )
        ESX.Game.DeleteVehicle(vehicle)
        SetEntityVisible(ped, true)
        menuaas = false
    end
end)
function LoadVehicles(veh)

    cat = {}
    for i=1, #veh, 1 do
        table.insert(cat,
            {
                v = veh[i].category,
                c = veh[i].name,
                x = veh[i].model,
                p = veh[i].price,
            }
        )

    end
end
RegisterNetEvent('opentestmenu')
AddEventHandler('opentestmenu', function()
    _menuPool:CloseAllMenus()
    openDynamicMxenu2()
end)
AddEventHandler('parow:exit', function()
    _menuPool:CloseAllMenus()
    
end)
RegisterNetEvent('forcesync')
AddEventHandler('forcesync', function()
    load()
end)
RegisterNetEvent('openOccasMenu')
AddEventHandler('openOccasMenu', function()
    _menuPool:CloseAllMenus()
    openDynamicMxenu22()
end)

function openDynamicMxenu2()
    inShopMenuye(true)
    mainMenu22 = NativeUI.CreateMenu("", "Concessionaire", 5, 200,"shopui_title_ie_modgarage","shopui_title_ie_modgarage")
    _menuPool:Add(mainMenu22)
    AddMasinMenu(mainMenu22)
    _menuPool:RefreshIndex()
    mainMenu22:Visible(true)
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end


function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow(0)
	SetTextOutline(0)
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function AddMasinMenu(menu)
    vehicleInd = {}
    vaa = {}
    vehicleInd2 = {}
    Categories2 = Categories
    for i=1, #Categories, 1 do
        --     --
        k = _menuPool:AddSubMenu(menu, Categories[i].label, "",true,true)
        vehicleInd[Categories[i].name] = {}
        for x=1,#Vehicles,1 do
            
            if Categories[i].name == Vehicles[x].category then
                c = NativeUI.CreateItem(Vehicles[x].name,"")
                c:RightLabel(Vehicles[x].price.."$")
             --   print(Vehicles[x].category .. " " .. Vehicles[x].model )
             
                ktt = vehicleInd[Categories[i].name]

                table.insert(ktt,{name=Vehicles[x].name,model=Vehicles[x].model,price=Vehicles[x].price})
                p = GetVehicleModelMaxSpeed(Vehicles[x].model)
                if p ~= nil then
                    local StatisticsPanel = NativeUI.CreateStatisticsPanel()
                    StatisticsPanel:AddStatistics("Vitesse")
                    StatisticsPanel:AddStatistics("Accélération")
                    StatisticsPanel:AddStatistics("Frein")
                    kx = GetVehicleModelAcceleration(Vehicles[x].model)*100
                    p = p * 3.6
                    p = p/220
                    StatisticsPanel:SetPercentage(1, p*100)
                    StatisticsPanel:SetPercentage(2, kx)
                    StatisticsPanel:SetPercentage(3, GetVehicleModelMaxBraking(Vehicles[x].model)*100)
                    c:AddPanel(StatisticsPanel)
                end
                k:AddItem(c)
                k.OnItemSelect = function(_, _, ind)
                    BuyNew(xp[ind].name,xp[ind].price,xp[ind].model,true)
                end
                k.OnIndexChange = function(_, index)
                    print(json.encode(xp))
                    local hash = GetHashKey(xp[index].model)
                    RequestModel(hash)
                      while not HasModelLoaded(hash) do
                        Citizen.Wait(0)
                        RequestModel(hash)
                        drawTxt("~p~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
                    end
                    print(xp[index].model)
                    ChangeCam(xp[index].model)
    
                end
                k.OnMenuClosed = function(_)
                    inShopMenuye(false)
        
                    local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
                    ----(vehicle)
                    if DoesEntityExist(vehicle) then
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                    local ped = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn( ped, false )
                    ESX.Game.DeleteVehicle(vehicle)
                    SetEntityVisible(ped, true)
            
                    SetEntityCoords(GetPlayerPed(-1), -33.74,-1112.5,26.42)
                end
            end
        end

        end
    
        menu.OnItemSelect = function(_, _, ind)
          ind = ind 
         
            print(json.encode(Categories[ind]))
            currentCat = Categories[ind].name
            print(currentCat)
            xp = vehicleInd[currentCat]
            local hash = GetHashKey(xp[1].model)
            RequestModel(hash)
                while not HasModelLoaded(hash) do
                Citizen.Wait(0)
                    RequestModel(hash)
                    drawTxt("~p~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
            end
            ChangeCam(xp[1].model)
        
        end
        

        menu:Visible(true)
        _menuPool:RefreshIndex()
    menu.OnMenuClosed = function(_)
        inShopMenuye(false)
        
        local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
        ----(vehicle)
        if DoesEntityExist(vehicle) then
            ESX.Game.DeleteVehicle(vehicle)
        end
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn( ped, false )
        ESX.Game.DeleteVehicle(vehicle)
        SetEntityVisible(ped, true)

        SetEntityCoords(GetPlayerPed(-1), -33.74,-1112.5,26.42)
    end
end






function OpenShop(menu,ind)
    menuaas = true
    local vaa = {}
    
    local indexView = 1
    for i=1,#cat,1 do 
        --
        if cat[i].v == cat2[ind].c then
            vv = NativeUI.CreateItem(cat[i].c,"")
            p = GetVehicleModelMaxSpeed(cat[i].x)
            if p ~= nil then
            local StatisticsPanel = NativeUI.CreateStatisticsPanel()
            StatisticsPanel:AddStatistics("Vitesse")
            StatisticsPanel:AddStatistics("Accélération")
            StatisticsPanel:AddStatistics("Frein")
            k = GetVehicleModelAcceleration(cat[i].x)*100
            p = p * 3.6
            p = p/220
            StatisticsPanel:SetPercentage(1, p*100)
            StatisticsPanel:SetPercentage(2, k)
            StatisticsPanel:SetPercentage(3, GetVehicleModelMaxBraking(cat[i].x)*75)
            
            vv:AddPanel(StatisticsPanel)
            end
            vv:RightLabel(cat[i].p.."$")
            menu:AddItem(vv)
            table.insert(vaa,{ 
                price = cat[i].p,
                name = cat[i].c,
                model = cat[i].x
            })
            
        end

    end
    local hash = GetHashKey(vaa[1].model)
    RequestModel(hash)
      while not HasModelLoaded(hash) do
        Citizen.Wait(0)
          RequestModel(hash)
          drawTxt("~g~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
      end
    ChangeCam(vaa[1].model)

    menu.OnItemSelect = function(_, _, index)
        --(vaa[index].name)
        BuyNew(vaa[index].name,vaa[index].price,vaa[index].model,true)
    end
    menu.OnIndexChange  =function(_, index)
        --(index)
        local hash = GetHashKey(vaa[index].model)
        RequestModel(hash)
          while not HasModelLoaded(hash) do
            Citizen.Wait(0)
              RequestModel(hash)
              drawTxt("~g~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
          end
        ChangeCam(vaa[index].model)

    end
    menu.OnMenuClosed = function(_)
        inShopMenuye(false)
        TriggerEvent("opentestmenu")
        local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
        ----(vehicle)

        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn( ped, false )
        ESX.Game.DeleteVehicle(vehicle)
        SetEntityVisible(ped, true)
        menuaas = false
        SetEntityCoords(GetPlayerPed(-1), -33.74,-1112.5,26.42)
    end
end

function Plate()
    AddTextEntry('FMMC_MPM_NA', "Plaque")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 8)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result == "" then

            Plate()
        else
            return tostring(result)
        end 
    end
end

function BuyNew(_, price, model, stat)
    --(model)
    ESX.TriggerServerCallback('parow:checkmoney', function (result)
        if result == true then
            TriggerServerEvent("logs:BasicLogs","Véhicule neuf",price .."$ " .. " " .. GetLabelText(GetDisplayNameFromVehicleModel(model)) ,"achats")
            local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
            ----(vehicle)

            local ped = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn( ped, false )
            ESX.Game.DeleteVehicle(vehicle)
            SetEntityVisible(ped, true)

                coords = {x=-17.28,y=-1080.76,z=26.67,a=128.66}

            ESX.Game.SpawnVehicle(model, coords, coords.a, function (vehicle)
                local playerPed = GetPlayerPed(-1)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                local newPlate     = Plate()
                if newPlate ~= nil then
                    --(newPlate)
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    TriggerServerEvent("esx_vehiclelock:registerkey",vehicleProps.plate,"no")
                    TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
                else
                    local vehicle = GetVehiclePedIsIn( ped, false )

                    
                    SetEntityAsMissionEntity( vehicle, true, true )
                    deleteCar( vehicle )
                end

               
              end)

              FreezeEntityPosition(playerPed, false)
              SetEntityVisible(playerPed, true)

         





        else
            TriggerEvent("parow:shownotif","Pas suffisement d'argent",6)    
        end
    end,price)

end

function ChangeCam(model) 
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn( ped, false )
    ESX.Game.DeleteVehicle(vehicle)
    coords = {-47.45,-1098.76,26.42}
    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, false)
    local vehicle = GetClosestVehicle(Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z,  2.0,  0,  71)
    ----(vehicle)

    local hash = GetHashKey(model)
    RequestModel(hash)
      while not HasModelLoaded(hash) do
        Citizen.Wait(0)
          RequestModel(hash)
          drawTxt("~p~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
      end
      local ve =   CreateVehicle(hash,Config.Zones.ShopInside.Pos.x,Config.Zones.ShopInside.Pos.y,Config.Zones.ShopInside.Pos.z, true, false)
      
      SetEntityCollision(ve,false,false)
      FreezeEntityPosition(ve,true)
      SetEntityInvincible(ve,true)
      SetVehicleDoorsLocked(ve,4)
      SetVehicleDirtLevel(ve,0.0)
      if ve then
        SetPedIntoVehicle(ped, ve, -1)       
      end
end


function ChangeCam2(model, propreties) 
    --Citizen.Wait(50)
    propreties =json.decode(propreties)
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn( ped, false )
    local playerPed  = GetPlayerPed(-1)

    ESX.Game.DeleteVehicle(vehicle)
   
    coords = {x=Config.Zones.ShopInside.Pos.x,y=Config.Zones.ShopInside.Pos.y,z=Config.Zones.ShopInside.Pos.z}
    ESX.Game.SpawnLocalVehicle(model, coords, 46, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, propreties)
        SetEntityCollision(vehicle,false,false)
        FreezeEntityPosition(vehicle,true)
        SetEntityInvincible(vehicle,true)
        SetEntityVisible(playerPed, false)
        SetVehicleDirtLevel(vehicle,0.0)
        SetVehicleDoorsLocked(vehicle,4)
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        
        
    end)
end







function CreateCamVeh(model) 
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn( ped, false )
    ESX.Game.DeleteVehicle(vehicle)

    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, false)
    spa = {x=2253.1,y=2888.48,z=47.69}
    local vehicle = GetClosestVehicle(spa.x,spa.y,spa.z,  2.0,  0,  71)
    ----(vehicle)

    local hash = GetHashKey(model)
    RequestModel(hash)
      while not HasModelLoaded(hash) do
        Citizen.Wait(0)
          RequestModel(hash)
          drawTxt("~p~Chargement...",4,1,0.5,0.5,1.5,255,255,255,255)      
      end
      local ve =   CreateVehicle(hash,spa.x,spa.y,spa.z, true, false)
      
      SetEntityCollision(ve,false,false)
      FreezeEntityPosition(ve,true)
      SetEntityInvincible(ve,true)
      SetVehicleDoorsLocked(ve,4)
      if ve then
        SetPedIntoVehicle(ped, ve, -1)       
      end
end


