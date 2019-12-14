ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kuana:getdatawallet')
AddEventHandler('kuana:getdatawallet', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xIdentifier = xPlayer.getIdentifier()
	local carro = nil
	local camiao = nil
	local mota = nil
	local fnome = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local unome = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local ddata = MySQL.Sync.fetchScalar("SELECT dateofbirth FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local sexo = MySQL.Sync.fetchScalar("SELECT sex FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local altura = MySQL.Sync.fetchScalar("SELECT height FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local checkcarta = MySQL.Sync.fetchScalar("SELECT mota FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
	local idcard = MySQL.Sync.fetchScalar("SELECT lastdigits FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	if checkcarta == nil then
		MySQL.Async.execute('INSERT INTO licensas (owner, mota, carro, camiao, armas) VALUES (@owner, @mota, @carro, @camiao, @armas)',
		{
			['@owner']   = xPlayer.identifier,
			['@mota']   = "nao",
			['@carro'] = "nao",
			["@camiao"] = "nao",
			["@armas"] = "nao"
		}, function (rowsChanged)
		end)
	else
		carro = MySQL.Sync.fetchScalar("SELECT carro FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		camiao = MySQL.Sync.fetchScalar("SELECT camiao FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		mota = MySQL.Sync.fetchScalar("SELECT mota FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		armas = MySQL.Sync.fetchScalar("SELECT armas FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
	end
	TriggerClientEvent("kuana:senddatawallet", xPlayer.source, fnome, unome, ddata, altura, sexo, mota, camiao, carro, armas, idcard)
	
end)

RegisterServerEvent('kuana:setallcarta')
AddEventHandler('kuana:setallcarta', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local playerslicenses = {}

    MySQL.Async.fetchAll("SELECT * FROM user_licenses",{}, function(data) 
        for _,v in pairs(data) do
            table.insert(playerslicenses , {type = v.type, owner = v.owner,  criado = "nao"})
        end
    end)
	
	local playerlicensas = {}
	MySQL.Async.fetchAll("SELECT * FROM licensas",{}, function(data) 
        for _,v in pairs(data) do
            table.insert(playerlicensas , {camiao = v.camiao, carro = v.carro, mota = v.mota, owner = v.owner})
        end
	end)	
	
	local existelicensas = false
	
	for _,v in pairs(playerslicenses) do
		for _,vv in pairs (playerslicensas) do
			if v.owner == vv.owner then 
				if v.type == "drive" then
					if vv.carro == "nao" then
						MySQL.Async.execute("UPDATE licensas SET carro = @carro WHERE owner = @owner ",
							{
								["@carro"] = "sim",
								["@owner"] = xPlayer.identifier
							}
						)
					end
				elseif v.type == "drive_bike" then
				    if vv.mota == "nao" then
					    MySQL.Async.execute("UPDATE licensas SET mota = @mota WHERE owner = @owner ",
							{
								["@mota"] = "sim",
								["@owner"] = xPlayer.identifier
							}
                        )
					end
				elseif v.type == "drive_truck" then
				    if vv.camiao == "nao" then
						MySQL.Async.execute("UPDATE licensas SET camiao = @camiao WHERE owner = @owner ",
							{
								["@camiao"] = "sim",
								["@owner"] = xPlayer.identifier
							}
						)
					end
				end
				v.criado = "sim"
			end
		end
	end

	for _,vvv in pairs(playerslicenses) do
		if vvv.criado == "nao" then
			MySQL.Async.execute('INSERT INTO licensas (owner, mota, carro, camiao, armas) VALUES (@owner, @mota, @carro, @camiao, @armas)',
			{
				['@owner']   = vvv.owner,
				['@mota']   = "nao",
				['@carro'] = "nao",
				["@camiao"] = "nao",
				["@armas"] = "nao"
			}, function (rowsChanged)
			end)
			vvv.criado = "sim"
			if vvv.type == "drive" then
				MySQL.Async.execute("UPDATE licensas SET carro = @carro WHERE owner = @owner ",
					{
						["@carro"] = "sim",
						["@owner"] = vvv.owner
					}
				)
			elseif vvv.type == "drive_bike" then
				MySQL.Async.execute("UPDATE licensas SET mota = @mota WHERE owner = @owner ",
					{
						["@mota"] = "sim",
						["@owner"] = vvv.owner
					}
				)
			elseif vvv.type == "drive_truck" then
				MySQL.Async.execute("UPDATE licensas SET camiao = @camiao WHERE owner = @owner ",
					{
						["@camiao"] = "sim",
						["@owner"] = vvv.owner
					}
				)
			end
		else
			for _,vvvv in pairs (playerslicensas) do
				if vvv.owner == vvvv.owner then 
					if vvv.type == "drive" then
						if vvvv.carro == "nao" then
							MySQL.Async.execute("UPDATE licensas SET carro = @carro WHERE owner = @owner ",
								{
									["@carro"] = "sim",
									["@owner"] = vvv.owner
								}
							)
						end
					elseif vvv.type == "drive_bike" then
						if vvvv.mota == "nao" then
							MySQL.Async.execute("UPDATE licensas SET mota = @mota WHERE owner = @owner ",
								{
									["@mota"] = "sim",
									["@owner"] = vvv.owner
								}
							)
						end
					elseif vvv.type == "drive_truck" then
						if vvvv.camiao == "nao" then
							MySQL.Async.execute("UPDATE licensas SET camiao = @camiao WHERE owner = @owner ",
								{
									["@camiao"] = "sim",
									["@owner"] = vvv.owner
								}
							)
						end
					end
				end
			end
		end
	end
end)

RegisterServerEvent('kuana:createdatawallet')
AddEventHandler('kuana:createdatawallet', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xIdentifier = xPlayer.getIdentifier()
	local carro = nil
	local camiao = nil
	local mota = nil
	local fnome = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local unome = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local ddata = MySQL.Sync.fetchScalar("SELECT dateofbirth FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local sexo = MySQL.Sync.fetchScalar("SELECT sex FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local altura = MySQL.Sync.fetchScalar("SELECT height FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local checkcarta = MySQL.Sync.fetchScalar("SELECT mota FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
	local idcard = MySQL.Sync.fetchScalar("SELECT lastdigits FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	if checkcarta == nil then
		MySQL.Async.execute('INSERT INTO licensas (owner, mota, carro, camiao, armas) VALUES (@owner, @mota, @carro, @camiao, @armas)',
		{
			['@owner']   = xPlayer.identifier,
			['@mota']   = "nao",
			['@carro'] = "nao",
			["@camiao"] = "nao",
			["@armas"] = "nao"
		}, function (rowsChanged)
		end)
	end
end)

RegisterServerEvent('kuana:getdatadwallet')
AddEventHandler('kuana:getdatadwallet', function(dplayer, printcara)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xAlvo = ESX.GetPlayerFromId(dplayer)
	local xIdentifier = xPlayer.getIdentifier()
	local carro = nil
	local camiao = nil
	local mota = nil
	local fnome = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local unome = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local ddata = MySQL.Sync.fetchScalar("SELECT dateofbirth FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local sexo = MySQL.Sync.fetchScalar("SELECT sex FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local altura = MySQL.Sync.fetchScalar("SELECT height FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	local checkcarta = MySQL.Sync.fetchScalar("SELECT mota FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
	local idcard = MySQL.Sync.fetchScalar("SELECT lastdigits FROM users WHERE identifier = @id", {['@id'] = xIdentifier})
	if checkcarta == nil then
		MySQL.Async.execute('INSERT INTO licensas (owner, mota, carro, camiao, armas) VALUES (@owner, @mota, @carro, @camiao, @armas)',
		{
			['@owner']   = xPlayer.identifier,
			['@mota']   = "nao",
			['@carro'] = "nao",
			["@camiao"] = "nao",
			["@armas"] = "nao"
		}, function (rowsChanged)
		end)
	else
		carro = MySQL.Sync.fetchScalar("SELECT carro FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		camiao = MySQL.Sync.fetchScalar("SELECT camiao FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		mota = MySQL.Sync.fetchScalar("SELECT mota FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
		armas = MySQL.Sync.fetchScalar("SELECT armas FROM licensas WHERE owner = @id", {['@id'] = xIdentifier})
	end
	TriggerClientEvent("kuana:setqualecra", xAlvo.source, source, printcara, armas)
	TriggerClientEvent("kuana:senddatawallet", xAlvo.source, fnome, unome, ddata, altura, sexo, mota, camiao, carro, armas, idcard)
end)