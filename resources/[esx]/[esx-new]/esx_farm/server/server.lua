ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('recoOrange')
AddEventHandler('recoOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local orange = xPlayer.getInventoryItem('orange').count

    if orange > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu en porte trop sur toi')
    elseif orange < 50 then
        xPlayer.addInventoryItem('orange', 3)
    end
end)

RegisterNetEvent('schOrange')
AddEventHandler('schOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local orange = xPlayer.getInventoryItem('orange').count
    local schorange = xPlayer.getInventoryItem('schorange').count

    if schorange > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu porte trop de sachet sur toi')
    elseif orange < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous avez pas assez d\'orange')
    else
        xPlayer.removeInventoryItem('orange', 3)
        xPlayer.addInventoryItem('schorange', 1)    
    end
    end)

RegisterNetEvent('vendreOrange')
AddEventHandler('vendreOrange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local schorange = xPlayer.getInventoryItem('schorange').count

    if schorange > 1 then
        TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un sachet orange ~w~(~g~5$)')
    xPlayer.removeInventoryItem('schorange', 1)
    xPlayer.addMoney(40)
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Tu n\'a plus d\'oranges à vendres')
    end
end)
   

    





