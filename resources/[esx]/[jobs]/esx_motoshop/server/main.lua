ESX              = nil
local Categories = {}
local Motos   = {}
local hasSqlRun  = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'motodealer', _U('dealer_customers'), false, false)
TriggerEvent('esx_society:registerSociety', 'motodealer', _U('moto_dealer'), 'society_motodealer', 'society_motodealer', 'society_motodealer', {type = 'private'})

function RemoveOwnedVehicle (plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate',
	{
		['@plate'] = plate
	})
end

AddEventHandler('onMySQLReady', function()
	LoadVehicles()
end)

function LoadVehicles()
	hasSqlRun = true

	Categories     = MySQL.Sync.fetchAll('SELECT * FROM moto_categories')
	local motos = MySQL.Sync.fetchAll('SELECT * FROM motos')

	for i=1, #motos, 1 do
		local moto = motos[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == moto.category then
				moto.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Motos, moto)
	end

	-- send information after db has loaded, making sure everyone gets moto information
	TriggerClientEvent('esx_motoshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_motoshop:sendMotos', -1, Motos)
end

-- extremely useful when restarting script mid-game
Citizen.CreateThread(function()
	Citizen.Wait(10000) -- hopefully enough for connection to the SQL server

	if not hasSqlRun then
		LoadVehicles()
	end
end)

RegisterServerEvent('esx_motoshop:setMotoOwned')
AddEventHandler('esx_motoshop:setMotoOwned', function (motoProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = motoProps.plate,
		['@vehicle'] = json.encode(motoProps)
	},
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, _U('moto_belongs', motoProps.plate))
	end)
end)

RegisterServerEvent('esx_motoshop:setMotoOwnedPlayerId')
AddEventHandler('esx_motoshop:setMotoOwnedPlayerId', function (playerId, motoProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = motoProps.plate,
		['@vehicle'] = json.encode(motoProps)
	},
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, _U('moto_belongs', motoProps.plate))
	end) 
end)

RegisterServerEvent('esx_motoshop:setMotoOwnedSociety')
AddEventHandler('esx_motoshop:setMotoOwnedSociety', function (society, motoProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = 'society:' .. society,
		['@plate']   = motoProps.plate,
		['@vehicle'] = json.encode(motoProps),
	},
	function (rowsChanged)

	end)
end)

RegisterServerEvent('esx_motoshop:sellMoto')
AddEventHandler('esx_motoshop:sellMoto', function (moto)
	MySQL.Async.fetchAll('SELECT * FROM motodealer_motos WHERE moto = @vehicle LIMIT 1', {
		['@vehicle'] = moto
	}, function (result)
		local id = result[1].id

		MySQL.Async.execute('DELETE FROM motodealer_motos WHERE id = @id', {
			['@id'] = id
		})
	end)
end)

RegisterServerEvent('esx_motoshop:rentMoto')
AddEventHandler('esx_motoshop:rentMoto', function (moto, plate, playerName, basePrice, rentPrice, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM motodealer_motos WHERE moto = @vehicle LIMIT 1', {
		['@vehicle'] = moto
	}, function (result)
		local id    = result[1].id
		local price = result[1].price
		local owner = xPlayer.identifier

		MySQL.Async.execute('DELETE FROM motodealer_motos WHERE id = @id', {
			['@id'] = id
		})

		MySQL.Async.execute('INSERT INTO rented_motos (moto, plate, player_name, base_price, rent_price, owner) VALUES (@vehicle, @plate, @player_name, @base_price, @rent_price, @owner)',
		{
			['@vehicle']     = moto,
			['@plate']       = plate,
			['@player_name'] = playerName,
			['@base_price']  = basePrice,
			['@rent_price']  = rentPrice,
			['@owner']       = owner,
		})
	end)
end)

-- unused?
RegisterServerEvent('esx_motoshop:setMotoForAllPlayers')
AddEventHandler('esx_motoshop:setMotoForAllPlayers', function (props, x, y, z, radius)
	TriggerClientEvent('esx_motoshop:setMoto', -1, props, x, y, z, radius)
end)

RegisterServerEvent('esx_motoshop:getStockItem')
AddEventHandler('esx_motoshop:getStockItem', function (itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function (inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_society'))
		end
	end)
end)

RegisterServerEvent('esx_motoshop:putStockItems')
AddEventHandler('esx_motoshop:putStockItems', function (itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function (inventory)
		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, _U('have_deposited', count, item.label))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:getCategories', function (source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_motoshop:getMotos', function (source, cb)
	cb(Motos)
end)

ESX.RegisterServerCallback('esx_motoshop:buyMoto', function (source, cb, motoModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local motoData = nil

	for i=1, #Motos, 1 do
		if Motos[i].model == motoModel then
			motoData = Motos[i]
			break
		end
	end

	if xPlayer.getMoney() >= motoData.price then
		xPlayer.removeMoney(motoData.price)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_motoshop:buyMotoSociety', function (source, cb, society, motoModel)
	local motoData = nil

	for i=1, #Motos, 1 do
		if Motos[i].model == motoModel then
			motoData = Motos[i]
			break
		end
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function (account)
		if account.money >= motoData.price then

			account.removeMoney(motoData.price)
			MySQL.Async.execute('INSERT INTO motodealer_motos (moto, price) VALUES (@vehicle, @price)',
			{
				['@vehicle'] = motoData.model,
				['@price']   = motoData.price,
			})

			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:getPersonnalMotos', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function (result)
		local motos = {}

		for i=1, #result, 1 do
			local motoData = json.decode(result[i].moto)
			table.insert(motos, motoData)
		end

		cb(motos)
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:getCommercialMotos', function (source, cb)
	MySQL.Async.fetchAll('SELECT * FROM motodealer_motos ORDER BY moto ASC', {}, function (result)
		local motos = {}

		for i=1, #result, 1 do
			table.insert(motos, {
				name  = result[i].moto,
				price = result[i].price
			})
		end

		cb(motos)
	end)
end)


RegisterServerEvent('esx_motoshop:returnProvider')
AddEventHandler('esx_motoshop:returnProvider', function(motoModel)
	local _source = source

	MySQL.Async.fetchAll('SELECT * FROM motodealer_motos WHERE moto = @moto LIMIT 1', {
		['@moto'] = motoModel
	}, function (result)

		if result[1] then
			local id    = result[1].id
			local price = ESX.Round(result[1].price * 0.75)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motodealer', function(account)
				account.addMoney(price)
			end)

			MySQL.Async.execute('DELETE FROM motodealer_motos WHERE id = @id', {
				['@id'] = id
			})

			TriggerClientEvent('esx:showNotification', _source, _U('moto_sold_for', motoModel, price))
		else
			print('esx_motoshop: ' .. GetPlayerIdentifiers(_source)[1] .. ' attempted selling an invalid moto!')
		end

	end)
end)

ESX.RegisterServerCallback('esx_motoshop:getRentedMotos', function (source, cb)
	MySQL.Async.fetchAll('SELECT * FROM rented_motos ORDER BY player_name ASC', {}, function (result)
		local motos = {}

		for i=1, #result, 1 do
			table.insert(motos, {
				name       = result[i].moto,
				plate      = result[i].plate,
				playerName = result[i].player_name
			})
		end

		cb(motos)
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:giveBackMoto', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM rented_motos WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		if result[1] ~= nil then
			local moto   = result[1].moto
			local basePrice = result[1].base_price

			MySQL.Async.execute('INSERT INTO motodealer_motos (moto, price) VALUES (@moto, @price)',
			{
				['@moto'] = moto,
				['@price']   = basePrice
			})

			MySQL.Async.execute('DELETE FROM rented_motos WHERE plate = @plate',{
				['@plate'] = plate
			})

			RemoveOwnedVehicle(plate)
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:resellMoto', function (source, cb, plate, price)
	MySQL.Async.fetchAll('SELECT * FROM rented_motos WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		if result[1] ~= nil then -- is it a rented moto?
			cb(false) -- it is, don't let the player sell it since he doesn't own it
		else
			local xPlayer = ESX.GetPlayerFromId(source)

			MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate',
			{
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate
			}, function (result)

				-- does the owner match?
				if result[1] ~= nil then
					xPlayer.addMoney(price)
					RemoveOwnedVehicle(plate)
					cb(true)
				else
					if xPlayer.job.grade_name == 'boss' then
						MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate',
						{
							['@owner'] = 'society:' .. xPlayer.job.name,
							['@plate'] = plate
						}, function (result)
							if result[1] ~= nil then
								xPlayer.addMoney(price)
								RemoveOwnedVehicle(plate)
								cb(true)
							else
								cb(false)
							end
						end)
					else
						cb(false)
					end
				end
			end)
		end
	end)
end)


ESX.RegisterServerCallback('esx_motoshop:getStockItems', function (source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_motoshop:getPlayerInventory', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({ items = items })
end)

ESX.RegisterServerCallback('esx_motoshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

if Config.EnablePvCommand then
	TriggerEvent('es:addGroupCommand', 'pv', 'user', function(source, args, user)
		TriggerClientEvent('esx_motoshop:openPersonnalMotoMenu', source)
	end, {help = _U('leaving')})
end

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM rented_motos', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer ~= nil then
				xPlayer.removeAccountMoney('bank', result[i].rent_price)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rental', result[i].rent_price))
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier',
				{
					['@bank']       = result[i].rent_price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motodealer', function(account)
				account.addMoney(result[i].rent_price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 22, 00, PayRent)
