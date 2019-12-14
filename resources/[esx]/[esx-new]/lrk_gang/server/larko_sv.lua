ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('SEM_CuffNear')
AddEventHandler('SEM_CuffNear', function(ID)
    TriggerClientEvent('SEM_Cuff', ID)
end)

RegisterServerEvent('SEM_DragNear')
AddEventHandler('SEM_DragNear', function(ID)
	TriggerClientEvent('Drag', ID, source)
end)

RegisterServerEvent('SEM_SeatNear')
AddEventHandler('SEM_SeatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_Seat', ID, Vehicle)
end)

RegisterServerEvent('SEM_UnseatNear')
AddEventHandler('SEM_UnseatNear', function(ID, Vehicle)
    TriggerClientEvent('SEM_Unseat', ID, Vehicle)
end)
