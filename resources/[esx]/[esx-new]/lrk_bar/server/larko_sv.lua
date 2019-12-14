ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyAlcool')
AddEventHandler('buyAlcool', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceAlcool
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('alcool', 1)
end)

