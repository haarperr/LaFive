ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('tenueprison', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_tenues:settenueprison', _source)
end)

---------------------------------
--Larko#0002 #Niquer vous les cheateurs ( dumpeurs aussi )------------------------------------------------------------------