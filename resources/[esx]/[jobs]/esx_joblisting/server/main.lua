ESX              = nil
local PlayerData = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_joblisting:setJobMiner')
AddEventHandler('esx_joblisting:setJobMiner', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("miner", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobFisherMan')
AddEventHandler('esx_joblisting:setJobFisherMan', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("fisherman", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobFueler')
AddEventHandler('esx_joblisting:setJobFueler', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("fueler", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobGarbage')
AddEventHandler('esx_joblisting:setJobGarbage', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("garbage", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobLumberJack')
AddEventHandler('esx_joblisting:setJobLumberJack', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("lumberjack", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobAbatteur')
AddEventHandler('esx_joblisting:setJobAbatteur', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("slaughterer", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobTailor')
AddEventHandler('esx_joblisting:setJobTailor', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("tailor", 0)	
end)

RegisterServerEvent('esx_joblisting:setJobTrucker')
AddEventHandler('esx_joblisting:setJobTrucker', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("trucker", 0)	
end)