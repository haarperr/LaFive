ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buySeashark')
AddEventHandler('buySeashark', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceSeashark
    xPlayer.removeMoney(price)
end)

RegisterNetEvent('buyJetmax')
AddEventHandler('buyJetmax', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceJetmax
    xPlayer.removeMoney(price)
end)

RegisterNetEvent('buyToro')
AddEventHandler('buyToro', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceToro
    xPlayer.removeMoney(price)
end)

RegisterNetEvent('buyMarquis')
AddEventHandler('buyMarquis', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceMarquis
    xPlayer.removeMoney(price)
end)

