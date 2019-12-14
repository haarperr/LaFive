ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('tenuecasa', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_tenues:settenuecasa', _source)
end)

---------------------------------
--Larko#0002 #Niquer vous les cheateurs ( dumpeurs aussi )------------------------------------------------------------------