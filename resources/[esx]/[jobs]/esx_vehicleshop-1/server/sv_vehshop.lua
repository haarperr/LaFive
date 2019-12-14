ESX              = nil
local Categories = {}
local Vehicles   = {}
local Categories2 = {}
local Vehicles2   = {}
local VehiclesJobs = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('onMySQLReady', function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories')
	Vehicles     = MySQL.Sync.fetchAll('SELECT * FROM vehicles')
	if Categories ~= nil then

		local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

		if vehiclejob ~= nil then
			for i=1, #vehiclejob, 1 do
				local vehicle = vehiclejob[i]

				table.insert(VehiclesJobs, vehicle)
			end
		end
		if vehicles ~= nil then
			for i=1, #vehicles, 1 do
				local vehicle = vehicles[i]

				for j=1, #Categories, 1 do
					if Categories[j].name == vehicle.category then
						vehicle.categoryLabel = Categories[j].label
						break
					end
				end

				table.insert(Vehicles, vehicle)
			end
		end
		-- send information after db has loaded, making sure everyone gets vehicle information
		TriggerClientEvent('esx_vehicleshop:sendCategories', -1, Categories)
		TriggerClientEvent('esx_vehicleshop:sendVehicles', -1, Vehicles)
	end
end)

function getdata()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories')
	Vehicles     = MySQL.Sync.fetchAll('SELECT * FROM vehicles')
	if Categories ~= nil then
		if vehiclejob ~= nil then
			for i=1, #vehiclejob, 1 do
				local vehicle = vehiclejob[i]

				table.insert(VehiclesJobs, vehicle)
			end
		end
		if vehicles ~= nil then
			for i=1, #vehicles, 1 do
				local vehicle = vehicles[i]

				for j=1, #Categories, 1 do
					if Categories[j].name == vehicle.category then
						vehicle.categoryLabel = Categories[j].label
						break
					end
				end

				table.insert(Vehicles, vehicle)
			end
		end
		if vehicles2 ~= nil then
			for i=1, #vehicles2, 1 do
				local vehicle = vehicles2[i]

				for j=1, #Categories, 1 do
					if Categories[j].name == vehicle.category then
						vehicle.categoryLabel = Categories[j].label
						break
					end
				end

				table.insert(Vehicles2, vehicle)
			end
		end
		-- send information after db has loaded, making sure everyone gets vehicle information
		TriggerClientEvent('esx_vehicleshop:sendCategories', -1, Categories)
		TriggerClientEvent('esx_vehicleshop:sendVehicles', -1, Vehicles)

	end
end

function ForceSync()
	
	TriggerClientEvent('esx_vehicleshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_vehicleshop:sendVehicles', -1, Vehicles)
	--SetTimeout(10000000, ForceSync)
end

getdata()

ForceSync()
ESX.RegisterServerCallback('parow:getCategories', function (_, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('parow:getVehiclesJob', function (_, cb)
	cb(VehiclesJobs)
end)
ESX.RegisterServerCallback('parow:getVehicles', function (_, cb)
	cb(Vehicles)
end)
ESX.RegisterServerCallback('parow:getCategories2', function (_, cb)
	cb(Categories2)
end)
ESX.RegisterServerCallback('parow:getVehicles2', function (_, cb)
	cb(Vehicles2)
end)
ESX.RegisterServerCallback('parow:getoccas', function (_, cb)


end)

RegisterServerEvent('esx_vehicleshop:setVehicleOwnedJob')
AddEventHandler('esx_vehicleshop:setVehicleOwnedJob', function(vehicleProps,job,label)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO job_parkings (job, vehicle,plate,name,parked) VALUES (@job, @vehicle,@plate,@name,@parked)',
	{
		['@job']   = job,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@name'] = label,
		['@parked'] = 1
	},
	function (_)
		TriggerClientEvent('esx:showNotification', _source, '~g~Ce est directement livré dans votre entreprise ', vehicleProps.plate)
	end)
		
	
end)

ESX.RegisterServerCallback('parow:checkmoney', function (source, cb, price)

	local xPlayer     = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_vehicleshop:setVehicleOwned')
AddEventHandler('esx_vehicleshop:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle,plate) VALUES (@owner, @vehicle,@plate)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	},
	function (_)
		TriggerClientEvent('esx:showNotification', _source, '~g~Ce véhicule vous appartient désormais', vehicleProps.plate)
	end)
end)


ESX.RegisterServerCallback('parow:checkveh', function (source, cb,vehicleProps)
	local _source = source
	t = vehicleProps.plate
	local found = false
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
			
		},
		function(result)

			local vehicles = {}

			for i=1, #result, 1 do
				v = json.decode(result[i].vehicle)
				v = v.plate
				v = tostring(v)
				v = string.gsub(v," ","")
				t = string.gsub(t, " ", "")
				t = t:lower()
				if v:lower() == t and found == false then
					found = true
				
				end
				
			end
			if found == true then
				cb(true)
			else
				cb(false)
			end
			
			

		end
	)


end)


RegisterServerEvent('parow:vente')
AddEventHandler('parow:vente', function (vehicleProps,price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO vehicles_occas (identifier,price, props) VALUES (@owner,@price, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@price']   = price,
		['@vehicle'] = json.encode(vehicleProps)
	},
	function (_)
		TriggerClientEvent('forcesync',-1)
	end)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner=@owner',
	{
		['@owner']   = xPlayer.identifier

	},
	function (_)


	end)
end)

RegisterServerEvent('removefromoccas:parow')
AddEventHandler('removefromoccas:parow', function (id,price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(id)
	MySQL.Async.fetchAll(
		'SELECT * FROM `vehicles_occas` WHERE `id` = @id',
		{
			['@id'] = id,
			
		},
		function(result)
			local x = nil
			for i = 1, #result, 1 do

				x =result[i].identifier
				print(x)
				found = true
				break
			end

			if found == true then
				MySQL.Async.execute('UPDATE vehicles_occas SET buyable = true WHERE id=@id',
				{
					['@id']   = id
			
				},
				function (_)
					TriggerClientEvent('forcesync',-1)
					TriggerClientEvent("parow:shownotif",_source,"Véhicule acheté avec succès",26)  
			
				end)
			else
			--	cb(false)
			end
			
			

		end
	)

end)



RegisterServerEvent('parow:recuptgconnard')
AddEventHandler('parow:recuptgconnard', function (id,price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('DELETE FROM vehicles_occas where id = @id',
	{
		['@id']   = id

	},
	function (_)
		xPlayer.addMoney(price)
		TriggerClientEvent('forcesync',-1)
		TriggerClientEvent("parow:shownotif",_source,"Véhicule acheté avec succès",26)  
	end)

end)