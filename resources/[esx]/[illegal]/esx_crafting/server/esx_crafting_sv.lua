ESX 						      = nil
local CopsConnected       	      = 0
local PlayersMakeMetal            = {}
local PlayersMakeSulfur           = {}
local PlayersMakeCharcoal         = {}
local PlayersTransformingMetal    = {}
local PlayersMakeBox              = {}
local PlayersMakeSpring           = {}
local PlayersMakePlastic          = {}
local PlayersMakePipe             = {}
local PlayersMakeSteel            = {}


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(5000, CountCops)

end

CountCops()


--metal-----------------------------------------------------

local function MakeMetal(source)

	if CopsConnected < Config.RequiredCopsMetal then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsMetal)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeMetal[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local metal = xPlayer.getInventoryItem('metal')

			if metal.limit ~= -1 and metal.count >= metal.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_metal'))
			else
				xPlayer.addInventoryItem('metal', 1)
				MakeMetal(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeMetal')
AddEventHandler('esx_crafting:startMakeMetal', function()

	local _source = source

	PlayersMakeMetal[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_metal'))

	MakeMetal(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeMetal')
AddEventHandler('esx_crafting:stopMakeMetal', function()

	local _source = source

	PlayersMakeMetal[_source] = false

end)


--sulfur-----------------------------------------------------

local function MakeSulfur(source)

	if CopsConnected < Config.RequiredCopsSulfur then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsSulfur)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeSulfur[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local sulfur = xPlayer.getInventoryItem('sulfur')

			if sulfur.limit ~= -1 and sulfur.count >= sulfur.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_sulfur'))
			else
				xPlayer.addInventoryItem('sulfur', 1)
				MakeSulfur(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeSulfur')
AddEventHandler('esx_crafting:startMakeSulfur', function()

	local _source = source

	PlayersMakeSulfur[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_sulfur'))

	MakeSulfur(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeSulfur')
AddEventHandler('esx_crafting:stopMakeSulfur', function()

	local _source = source

	PlayersMakeSulfur[_source] = false

end)


--charcoal-----------------------------------------------------

local function MakeCharcoal(source)

	if CopsConnected < Config.RequiredCopsCharcoal then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsCharcoal)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeCharcoal[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local charcoal = xPlayer.getInventoryItem('charcoal')

			if charcoal.limit ~= -1 and charcoal.count >= charcoal.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_charcoal'))
			else
				xPlayer.addInventoryItem('charcoal', 1)
				MakeCharcoal(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeCharcoal')
AddEventHandler('esx_crafting:startMakeCharcoal', function()

	local _source = source

	PlayersMakeCharcoal[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_charcoal'))

	MakeCharcoal(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeCharcoal')
AddEventHandler('esx_crafting:stopMakeCharcoal', function()

	local _source = source

	PlayersMakeCharcoal[_source] = false

end)



--HQ-----------------------------------------------------

local function TransformMetal(source)

	if CopsConnected < Config.RequiredCopsHq then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsHq)
		return
	end

	SetTimeout(10000, function()

		if PlayersTransformingMetal[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local metalQuantity = xPlayer.getInventoryItem('metal').count
			local hqQuantity = xPlayer.getInventoryItem('hq').count

			if hqQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_hq'))
			elseif metalQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_metal'))
			else
				xPlayer.removeInventoryItem('metal', 5)
				xPlayer.addInventoryItem('hq', 1)
			
				TransformMetal(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startTransformMetal')
AddEventHandler('esx_crafting:startTransformMetal', function()

	local _source = source

	PlayersTransformingMetal[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_hq'))

	TransformMetal(_source)

end)

RegisterServerEvent('esx_crafting:stopTransformMetal')
AddEventHandler('esx_crafting:stopTransformMetal', function()

	local _source = source

	PlayersTransformingMetal[_source] = false

end)

--Box-----------------------------------------------------

local function MakeBox(source)

	if CopsConnected < Config.RequiredCopsBox then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsBox)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeBox[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local box = xPlayer.getInventoryItem('metbox')

			if box.limit ~= -1 and box.count >= box.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_box'))
			else
				xPlayer.addInventoryItem('metbox', 1)
				MakeBox(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeBox')
AddEventHandler('esx_crafting:startMakeBox', function()

	local _source = source

	PlayersMakeBox[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_box'))

	MakeBox(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeBox')
AddEventHandler('esx_crafting:stopMakeBox', function()

	local _source = source

	PlayersMakeBox[_source] = false

end)

--Spring-----------------------------------------------------

local function MakeSpring(source)

	if CopsConnected < Config.RequiredCopsSpring then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsSpring)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeSpring[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local spring = xPlayer.getInventoryItem('spring')

			if spring.limit ~= -1 and spring.count >= spring.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_spring'))
			else
				xPlayer.addInventoryItem('spring', 1)
				MakeSpring(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeSpring')
AddEventHandler('esx_crafting:startMakeSpring', function()

	local _source = source

	PlayersMakeSpring[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_spring'))

	MakeSpring(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeSpring')
AddEventHandler('esx_crafting:stopMakeSpring', function()

	local _source = source

	PlayersMakeSpring[_source] = false

end)


--Plastic-----------------------------------------------------

local function MakePlastic(source)

	if CopsConnected < Config.RequiredCopsPlastic then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsPlastic)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakePlastic[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local plastic = xPlayer.getInventoryItem('plastic')

			if plastic.limit ~= -1 and plastic.count >= plastic.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_plastic'))
			else
				xPlayer.addInventoryItem('plastic', 1)
				MakePlastic(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakePlastic')
AddEventHandler('esx_crafting:startMakePlastic', function()

	local _source = source

	PlayersMakePlastic[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_plastic'))

	MakePlastic(_source)

end)

RegisterServerEvent('esx_crafting:stopMakePlastic')
AddEventHandler('esx_crafting:stopMakePlastic', function()

	local _source = source

	PlayersMakePlastic[_source] = false

end)


--Pipe-----------------------------------------------------

local function MakePipe(source)

	if CopsConnected < Config.RequiredCopsPipe then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsPipe)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakePipe[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local pipe = xPlayer.getInventoryItem('metalpipe')

			if pipe.limit ~= -1 and pipe.count >= pipe.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_pipe'))
			else
				xPlayer.addInventoryItem('metalpipe', 1)
				MakePipe(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakePipe')
AddEventHandler('esx_crafting:startMakePipe', function()

	local _source = source

	PlayersMakePipe[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_pipe'))

	MakePipe(_source)

end)

RegisterServerEvent('esx_crafting:stopMakePipe')
AddEventHandler('esx_crafting:stopMakePipe', function()

	local _source = source

	PlayersMakePipe[_source] = false

end)


--Steel-----------------------------------------------------

local function MakeSteel(source)

	if CopsConnected < Config.RequiredCopsSteel then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsSteel)
		return
	end

	SetTimeout(5000, function()

		if PlayersMakeSteel[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local steel = xPlayer.getInventoryItem('steel')

			if steel.limit ~= -1 and steel.count >= steel.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_steel'))
			else
				xPlayer.addInventoryItem('steel', 1)
				MakeSteel(source)
			end

		end
	end)
end

RegisterServerEvent('esx_crafting:startMakeSteel')
AddEventHandler('esx_crafting:startMakeSteel', function()

	local _source = source

	PlayersMakeSteel[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('making_steel'))

	MakeSteel(_source)

end)

RegisterServerEvent('esx_crafting:stopMakeSteel')
AddEventHandler('esx_crafting:stopMakeSteel', function()

	local _source = source

	PlayersMakeSteel[_source] = false

end)





-- RETURN INVENTORY TO CLIENT
RegisterServerEvent('esx_crafting:GetUserInventory')
AddEventHandler('esx_crafting:GetUserInventory', function(currentZone)
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_crafting:ReturnInventory', 
    	_source, 
		xPlayer.getInventoryItem('metal').count, 
		xPlayer.getInventoryItem('sulfur').count,
		xPlayer.getInventoryItem('charcoal').count,
		xPlayer.getInventoryItem('hq').count,
		xPlayer.getInventoryItem('metbox').count,
		xPlayer.getInventoryItem('spring').count,
		xPlayer.getInventoryItem('plastic').count,
		xPlayer.getInventoryItem('metalpipe').count,
		xPlayer.getInventoryItem('steel').count,
		xPlayer.job.name, 
		currentZone
    )
end)


