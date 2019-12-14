ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyBand')
AddEventHandler('buyBand', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceFirstAidKit
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('firstaidkit', 1)
end)

RegisterNetEvent('buyDefib')
AddEventHandler('buyDefib', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceDefib
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('defibrillateur', 1)
end)

RegisterNetEvent('buyPo')
AddEventHandler('buyPo', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PricePiluleOubli
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('piluleoubli', 1)
end)

ESX.RegisterUsableItem('firstaidkit', function(source)
    local xPlayers     = ESX.GetPlayers()
    local hasAmbulance = false
  
    for i = 1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      if xPlayer.job.name == 'ambulance' then
        hasAmbulance = true
        break
      end
    end
  
    if not hasAmbulance then
      TriggerClientEvent('esx_pharmacy:useKit', source, 'firstaidkit', 4)
    else
      TriggerClientEvent('esx:showNotification', source, _U('has_ambulance'))  
    end
  end)
  
  ESX.RegisterUsableItem('defibrillateur', function(source)
    local xPlayers     = ESX.GetPlayers()
    local hasAmbulance = false
  
    for i = 1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      if xPlayer.job.name == 'ambulance' then
        hasAmbulance = true
        break
      end
    end
  
    if not hasAmbulance then
      TriggerClientEvent('esx_pharmacy:useDefibrillateur', source, 'defibrillateur')
    else
      TriggerClientEvent('esx:showNotification', source, _U('has_ambulance'))  
    end
  end)