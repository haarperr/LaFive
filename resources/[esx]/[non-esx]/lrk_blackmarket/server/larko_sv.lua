ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('BuyCar')
AddEventHandler('BuyCar', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCar
    local weaponName = 'WEAPON_CARBINERIFLE'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuyAss')
AddEventHandler('BuyAss', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCar
    local weaponName = 'WEAPON_ASSAULTRIFLE'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuyMic')
AddEventHandler('BuyMic', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceMic
    local weaponName = 'WEAPON_MICROSMG'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuySpe')
AddEventHandler('BuySpe', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceSpe
    local weaponName = 'WEAPON_SPECIALCARBINE'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuyTaz')
AddEventHandler('BuyTaz', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceTaz
    local weaponName = 'WEAPON_STUNGUN'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuySni')
AddEventHandler('BuySni', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceSni
    local weaponName = 'weapon_sniperrifle'
    xPlayer.addWeapon(weaponName, 45)
    xPlayer.removeMoney(price)
end)

RegisterServerEvent('BuyCaro')
AddEventHandler('BuyCaro', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCaro
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('carokit', 1)
end)

