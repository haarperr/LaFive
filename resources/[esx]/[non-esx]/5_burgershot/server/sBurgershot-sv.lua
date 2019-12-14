ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('BuyBigmac')
AddEventHandler('BuyBigmac', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceBigmac
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('hamburger', 1)
end)
RegisterServerEvent('BuyCola')
AddEventHandler('BuyCola', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCola
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('cocacola', 1)
end)
RegisterServerEvent('BuyMenu')
AddEventHandler('BuyMenu', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceMenu
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('hamburger', 1)
    xPlayer.addInventoryItem('cocacola', 1)
    xPlayer.addInventoryItem('donut', 1)
end)

