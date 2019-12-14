ESX = nil
local mostrar = false
local mugshot = false
local mugshot2 = nil
local mugshotStr = nil
local primeiravez = false
local qualecra = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('kuana:carteirausar')
AddEventHandler('kuana:carteirausar', function()
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = true
	})
end)



RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerMenu = false
	})

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('kuana:createwallet')
AddEventHandler('kuana:createwallet', function()
	TriggerServerEvent("kuana:createdatawallet")
end)

RegisterCommand("carteira", function(source, args, rawCommand)
	qualecra = false
	TriggerServerEvent("kuana:getdatawallet", item)
end)

RegisterCommand("carteiratemp", function(source, args, rawCommand)
	qualecra = false
	TriggerServerEvent("kuana:setallcarta")
end)

RegisterCommand("darcarteira", function(source, args, rawCommand)
	local Ped = PlayerPedId()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 1.0 then
		if mugshot ~= nil then
			UnregisterPedheadshot(mugshot)
		end
		mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
		TriggerServerEvent("kuana:getdatadwallet", GetPlayerServerId(closestPlayer), mugshotStr, item)
	end
	
end)

RegisterNetEvent('kuana:setqualecra')
AddEventHandler('kuana:setqualecra', function(idplayer, fotoplayer, itema)
	qualecra = true
	if mugshot2 ~= nil then
		UnregisterPedheadshot(mugshot2)
	end
	mugshot2 = nil
    mugshotStr = nil
	mugshot2, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(idplayer)))
	item = itema
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	item = "mao"

	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == 'licenca_pistolas' then
			if ESX.PlayerData.inventory[i].count > 0 then
				item = "sim"
			end
		end
	end

end)

RegisterNUICallback('closeButton', function(data, cb)
	SetNuiFocus( false, false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	primeiravez = false
	mugshot = false
	mugshot2 = nil
	mugshotStr = nil
	qualecra = false
	if mugshot ~= nil then
		UnregisterPedheadshot(mugshot)
	end
  	cb('ok')
end)


RegisterNUICallback('slide', function(data, cb)
	if primeiravez == false then
		Citizen.Wait(100)
		if qualecra == false then
			if mugshot ~= nil then
				UnregisterPedheadshot(mugshot)
			end
			mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
		end
		primeiravez = true
	elseif primeiravez == true then
		primeiravez = false
	end
  	cb('ok')
end)

RegisterNUICallback('slidea', function(data, cb)
	primeiravez = false
  	cb('ok')
end)

RegisterNetEvent('kuana:carteiracalc')
AddEventHandler('kuana:carteiracalc', function()
	item = "sim"
end)

RegisterNetEvent('kuana:carteiracalct')
AddEventHandler('kuana:carteiracalct', function()
	item = "nao"
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if primeiravez == true then
			DrawSprite(mugshotStr, mugshotStr, 0.571, 0.276, 0.044, 0.09, 0.0, 255, 255, 255, 1000)
		else

		end
    end
end)
