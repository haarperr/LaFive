ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('BuyKit')
AddEventHandler('BuyKit', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceKit
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('fixkit', 1)
end)

RegisterServerEvent('BuyCaro')
AddEventHandler('BuyCaro', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCaro
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('carokit', 1)
end)

RegisterServerEvent('BuyLock')
AddEventHandler('BuyLock', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceLockpick
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('lockpick', 1)
end)

RegisterNetEvent('vendreMotor')
AddEventHandler('vendreMotor', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local schorange = xPlayer.getInventoryItem('motor').count

    price = 20000

    if schorange >= 2 then
        TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un moteur pour ~g~2000$ d\'argent sale')
    xPlayer.removeInventoryItem('motor', 1)
    --xPlayer.addMoney(2000)
    xPlayer.addAccountMoney('black_money', price)
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Tu n\'a plus de moteur à vendre')
    end
end)
   

