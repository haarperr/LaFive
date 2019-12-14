ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local events = {
	'esx:getSharedObject'
}


for i=1, #events, 1 do
  AddEventHandler(events[i], function()
    TriggerServerEvent('95b72f7e-85bb-4c30-afa5-ef589757429b', events[i])
  end)
end

