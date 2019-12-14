ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyBlista')
AddEventHandler('buyBlista', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceBlista
    xPlayer.removeMoney(price)
end)

RegisterNetEvent('buyVespa')
AddEventHandler('buyVespa', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceVespa
    xPlayer.removeMoney(price)
end)

RegisterNetEvent('buyBmx')
AddEventHandler('buyBmx', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceBmx
    xPlayer.removeMoney(price)
end)

