ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getMaximumGrade(jobname)
	local result = MySQL.Sync.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
		['@jobname'] = jobname
	})

	if result[1] ~= nil then
		return result[1].grade
	end

	return nil
end

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]

        return {
            identifier = identity['identifier'],
            name = identity['name'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = identity['sex'],
            height = identity['height'],
            job = identity['job'],
            group = identity['group']
        }
    else
        return nil
    end
end


ESX.RegisterServerCallback('KorioZ-PersonalMenu:Bill_getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local playerGroup = xPlayer.getGroup()

		if playerGroup ~= nil then 
			cb(playerGroup)
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

-- Weapon Menu --
RegisterServerEvent('KorioZ-PersonalMenu:Weapon_AmmoToPedS')
AddEventHandler('KorioZ-PersonalMenu:Weapon_AmmoToPedS', function(plyId, value, quantity)
	TriggerClientEvent('KorioZ-PersonalMenu:Weapon_AmmoToPedC', plyId, value, quantity)
end)

-- Admin Menu --
RegisterServerEvent('KorioZ-PersonalMenu:Admin_teleS')
AddEventHandler('KorioZ-PersonalMenu:Admin_teleS', function(plyId, plyPedCoords)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)   
	local grade = getIdentity(source)

	bandata = {}
	bandata.reason = 'LAFIVE PRIVATE ANTICHEAT | INJECTION DETECTED FOR BRING' -- drop/ban reason
	bandata.period = '0' -- days, 0 for permanent

    if grade.group == 'mod' or grade.group == 'admin' or grade.group == 'superadmin' then
		TriggerClientEvent('KorioZ-PersonalMenu:Admin_teleC', plyId, plyPedCoords)
	else
		TriggerEvent('Anticheat:AutoBan', _source, bandata)
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Admin_Cash')
AddEventHandler('KorioZ-PersonalMenu:Admin_Cash', function(money)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)   
	local grade = getIdentity(source)

	bandata = {}
	bandata.reason = 'LAFIVE PRIVATE ANTICHEAT | INJECTION DETECTED FOR CASH GIVE'-- drop/ban reason
	bandata.period = '0' -- days, 0 for permanent

    if grade.group == 'mod' or grade.group == 'admin' or grade.group == 'superadmin' then
	    xPlayer.addMoney(money)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'GIVE de ' .. money .. '$')
	else 
		TriggerEvent('Anticheat:AutoBan', _source, bandata)
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Admin_Bank')
AddEventHandler('KorioZ-PersonalMenu:Admin_Bank', function(money)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)   
	local grade = getIdentity(source)

	bandata = {}
	bandata.reason = 'LAFIVE PRIVATE ANTICHEAT | INJECTION DETECTED FOR BANK GIVE' -- drop/ban reason
	bandata.period = '0' -- days, 0 for permanent

    if grade.group == 'mod' or grade.group == 'admin' or grade.group == 'superadmin' then
	    xPlayer.addAccountMoney('bank', money)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'GIVE de ' .. money .. '$ en banque')
	else
		TriggerEvent('Anticheat:AutoBan', _source, bandata)
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Admin_DirtyMoney')
AddEventHandler('KorioZ-PersonalMenu:Admin_DirtyMoney', function(money)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)   
	local grade = getIdentity(source)

	bandata = {}
	bandata.reason = 'LAFIVE PRIVATE ANTICHEAT | INJECTION DETECTED FOR DIRTY GIVE' -- drop/ban reason
	bandata.period = '0' -- days, 0 for permanent

    if grade.group == 'mod' or grade.group == 'admin' or grade.group == 'superadmin' then
	    xPlayer.addAccountMoney('black_money', money)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'GIVE de ' .. money .. '$ sale')
	else
		TriggerEvent('Anticheat:AutoBan', _source, bandata)
	end
end)

-- Grade Menu --
RegisterServerEvent('KorioZ-PersonalMenu:Patron_promouvoirplayer')
AddEventHandler('KorioZ-PersonalMenu:Patron_promouvoirplayer', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du ~r~Gouvernement~w~.')
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name .. '~w~.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '~w~.')
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
		end
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_destituerplayer')
AddEventHandler('KorioZ-PersonalMenu:Patron_destituerplayer', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.')
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~rétrogradé ' .. targetXPlayer.name .. '~w~.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~r~rétrogradé par ' .. sourceXPlayer.name .. '~w~.')
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
		end
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_recruterplayer')
AddEventHandler('KorioZ-PersonalMenu:Patron_recruterplayer', function(target, job, grade)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	
	targetXPlayer.setJob(job, grade)

	TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
	TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_virerplayer')
AddEventHandler('KorioZ-PersonalMenu:Patron_virerplayer', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob('unemployed', 0)

		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_promouvoirplayer2')
AddEventHandler('KorioZ-PersonalMenu:Patron_promouvoirplayer2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job2.grade == tonumber(getMaximumGrade(sourceXPlayer.job2.name)) - 1) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du ~r~Gouvernement~w~.')
	else
		if (sourceXPlayer.job2.name == targetXPlayer.job2.name) then
			targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) + 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name .. '~w~.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '~w~.')
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
		end
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_destituerplayer2')
AddEventHandler('KorioZ-PersonalMenu:Patron_destituerplayer2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job2.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, 'Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.')
	else
		if (sourceXPlayer.job2.name == targetXPlayer.job2.name) then
			targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) - 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~rétrogradé ' .. targetXPlayer.name .. '~w~.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~r~rétrogradé par ' .. sourceXPlayer.name .. '~w~.')
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
		end
	end
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_recruterplayer2')
AddEventHandler('KorioZ-PersonalMenu:Patron_recruterplayer2', function(target, job2, grade2)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	
	targetXPlayer.setJob2(job2, grade2)

	TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
	TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
end)

RegisterServerEvent('KorioZ-PersonalMenu:Patron_virerplayer2')
AddEventHandler('KorioZ-PersonalMenu:Patron_virerplayer2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (sourceXPlayer.job2.name == targetXPlayer.job2.name) then
		targetXPlayer.setJob2('unemployed2', 0)

		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end)
