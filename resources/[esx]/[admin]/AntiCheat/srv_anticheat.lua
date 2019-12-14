local events = {
	'HCheat:TempDisableDetection',
	'BsCuff:Cuff696999',
	'police:cuffGranted',
	'_chat:messageEntered',
	'mellotrainer:adminTempBan',
	'AdminMenu:giveCash',
	'AdminMenu:giveBank',
	'AdminMenu:giveDirtyMoney',
	'esx-qalle-jail:jailPlayer',
	'kickAllPlayer',
	'esx_slotmachine:sv:2',
	'lscustoms:payGarage',
	'dmv:success',
	'esx_billing:sendBill',
	
-- Jobs
	'esx_gopostaljob:pay',
	'esx_banksecurity:pay',
	'esx_truckerjob:pay',
	'esx_ambulancejob:success',
	'esx_taxijob:success',
	'esx_mecanojob:onNPCJobMissionCompleted',
	'esx_mecanicjob:onNPCJobMissionCompleted',

-- Drogues
	'esx_drugs:startHarvestCoke',
	'esx_drugs:startHarvestMeth',
	'esx_drugs:startHarvestWeed',
	'esx_drugs:startHarvestOpium',
	'esx_drugs:startHarvestCrack',
	'esx_drugs:startHarvestMethlab',
	'esx_drugs:startHarvestAcetone',
	'esx_drugs:startHarvestLithium',
	'esx_drugs:startHarvestKetamine',
	'esx_drugs:startHarvestEcstasy',
	'esx_drugs:startHarvestBillet',

-- Ajouts de detection KRZ
	'KorioZ-PersonalMenu:Weapon_addAmmoToPedS',
	'KorioZ-PersonalMenu:Admin_BringS',
	'KorioZ-PersonalMenu:Admin_giveCash',
	'KorioZ-PersonalMenu:Admin_giveBank',
	'KorioZ-PersonalMenu:Admin_giveDirtyMoney',
	'KorioZ-PersonalMenu:Boss_promouvoirplayer',
	'KorioZ-PersonalMenu:Boss_destituerplayer',
	'KorioZ-PersonalMenu:Boss_recruterplayer',
	'KorioZ-PersonalMenu:Boss_virerplayer',
}

local eventsAdmin = {
	'Admin2Menu:giveCash',
	'Admin2Menu:giveBank',
	'Admin2Menu:giveDirtyMoney',
	'KorioZ-PersonalMenu:Admin_giveCash',
	'KorioZ-PersonalMenu:Admin_giveBank',
	'KorioZ-PersonalMenu:Admin_giveDirtyMoney',
}

local Text               = {}
local lastduree          = ""
local lasttarget         = ""
local BanList            = {}
local BanListLoad        = false
local BanListHistory     = {}
local BanListHistoryLoad = false

Users = {}
violations = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('AC:GetGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
   end)

platenum = math.random(00001, 99998)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local r = math.random(00001, 99998)
		platenum = r
	end
end)


GodModKickMessage = "LaFive ANTI-CHEAT | CHEAT DETECTÉ ! VOUS AVEZ ÉTÉ EXCLU DU SERVEUR - [Cheat detection #".. platenum .."]."
kickMessage = "LaFive ANTI-CHEAT | CHEAT DETECTÉ ! VOUS N'AVEZ PAS LE DROIT DE JOUER ICI ! [Mod Menu detection #".. platenum .."]."
kickMessagePolice = "LaFive ANTI-RP | DETECTION VOLE DE VEHICULE ! Voler des véhicule de service police/ems n'est pas autorisé! Merci de lire le réglement. [Detection #".. platenum .."]."
BanMessageLuaInjection = "LaFive ANTI-CHEAT | LUA MOD MENU / INJECTION DETECTÉ - VOUS ÊTES GLOBALEMENT BANNI DE CE SERVEUR [Ban ID: #".. platenum .."]."
BanMessageHealthHack = "LaFive ANTI-CHEAT | CHEAT DETECTÉ - VOUS ÊTES GLOBALEMENT BANNI DE CE SERVEUR [Ban ID: #".. platenum .."]."
KickSessionSolo = "LaFive ANTI-RP | SESSION SOLO DETECTÉ - Vous avez été kick du serveur, merci de vous reconnecter.\n[Detection #".. platenum .."]."

function SendWebhookMessageStaff(webhook,message)
	webhook = "https://discordapp.com/api/webhooks/654083956764966935/pusGAyANBw3nNT2sphjqD1FCXiLZpeJdVQjtoDiivTbb2ee3aO8yZUXugnwnmaPg3IBI"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

for i=1, #eventsAdmin, 1 do
	RegisterServerEvent(eventsAdmin[i])
	AddEventHandler(eventsAdmin[i], function()
		local _source = source
		TriggerEvent('AC:AdminDetected', eventsAdmin[i], _source, true)
	end)
end

RegisterServerEvent('AC:AdminDetected')
AddEventHandler('AC:AdminDetected', function(source, isServerEvent)
	name = GetPlayerName(source)

	SendWebhookMessageStaff(webhook,"**Give D'argent detecté!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n\n- La personne c'est give de l'argents par le menu admin\n+ Anticheat Flags: [Detection #".. platenum .."].```")
	--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', source, 0, BanMessageHealthHack)
	bandata = {}
	bandata.reason = BanMessageHealthHack
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
end)

RegisterServerEvent('AC:VehModdeur')
AddEventHandler('AC:VehModdeur', function(car, modele, carName)
	--SendWebhookMessage(webhook,"**LaFive - AC | Suppression de véhicule**```\n\nVehicule ID: "..car.."\nModèle: "..modele.."\nNom: "..carName.."\n\n[Detection #".. platenum .."].``` ")
end)

function SendWebhookMessage(webhook,message)
	webhook = "https://discordapp.com/api/webhooks/654083956764966935/pusGAyANBw3nNT2sphjqD1FCXiLZpeJdVQjtoDiivTbb2ee3aO8yZUXugnwnmaPg3IBI"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


for i=1, #events, 1 do
	RegisterServerEvent(events[i])
	AddEventHandler(events[i], function()
		local _source = source
		TriggerEvent('AC:injectionDetected', events[i], _source, true)
	end)
end

RegisterServerEvent('AC:LittleDetection')
	AddEventHandler('AC:LittleDetection', function(invincible,oldHealth, newHealth, curWait)
			name = GetPlayerName(source)

			WarnPlayer(name)
			--print('===========================================')
			--print(' ')
			--print(' ')
			--print(' ')
			--print(' ')
			--print('^1Player id ^0[' .. source .. '] ^1à essayer d\'utiliser un cheat de health: ^0'..newHealth-oldHealth..'hp ( to reach '..newHealth..'hp ) in '..curWait..'ms! ^1 | nom de la personne : ^0[' .. name .. ']')
			--print(' ')
			--print(' ')
			--print(' ')
			--print(' ')
			--print('===========================================')
			--SendWebhookMessage(webhook,"**Health Hack Detected!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n- Nombre(s) de détéction: \n\n- Régénération de :"..newHealth-oldHealth.."HP\n- HP après la régen: "..newHealth.."\n- Temps pour avoir "..newHealth..": "..curWait.."ms!\n+ Anticheat Flags: ( La régenération à été forcé )\n[Detection #".. platenum .."].```")

			if newHealth > 201 then
				--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', source, 0, BanMessageHealthHack)
				bandata = {}
				bandata.reason = BanMessageHealthHack
				bandata.period = '0' -- days, 0 for permanent
				TriggerEvent('AntiCheat:AutoBan', source, bandata)
				--TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. name .. " à été banni: "..BanMessageHealthHack.."")
				SendWebhookMessage(webhook,"**Health Hack Détected!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n- Nombre(s) de détection: 1\n\n- Régénération de :"..newHealth-oldHealth.."HP\n- HP après la régen: "..newHealth.."\n- Temps pour avoir "..newHealth..": "..curWait.."ms!\n+ Anticheat Flags: ( Le joueurs à été banni perma )\n[Détection #".. platenum .."].```")
				SendWebhookMessageStaff(webhook,"**Mod Menu détected!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n- Nombre(s) de détection: 1\n\n- Régénération de :"..newHealth-oldHealth.."HP\n- HP après la régen: "..newHealth.."\n- Temps pour avoir "..newHealth..": "..curWait.."ms!\n+ Anticheat Flags: ( Le joueur à été banni perma après "..avert.." détection du serveur. [Ban ID: #".. platenum .."]. )```")
			
			--else
			--	SendWebhookMessage(webhook,"**Health Hack Detected!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n- Nombre(s) de détéction: \n\n- Régénération de :"..newHealth-oldHealth.."HP\n- HP après la régen: "..newHealth.."\n- Temps pour avoir "..newHealth..": "..curWait.."ms!\n+ Anticheat Flags: ( False positive possible )\n[Detection #".. platenum .."].```")
			end


	end)

RegisterServerEvent('AC:PoliceVehicule')
	AddEventHandler('AC:PoliceVehicule', function()
			name = GetPlayerName(source)
			DropPlayer(source, kickMessagePolice)
	end)

RegisterServerEvent('AC:GodModDetected')
	AddEventHandler('AC:GodModDetected', function(source)

		local s = source
		local nom = GetPlayerName(source)
	
	
		print('===========================================')
		print(' ')
		print(' ')
		print(' ')
		print(' ')
		print('^1Player id ^0[' .. source .. '] ^1à été banni 1j après 5 detection ^1 | nom de l\'event : ^0[' .. nom .. ']')
		print(' ')
		print(' ')
		print(' ')
		print(' ')
		print('===========================================')
		SendWebhookMessageStaff(webhook,"**Mod Menu detected!** \n```diff\nJoueurs: "..nom.."\nID du joueurs: "..source.."\n\n- Nombre(s) de détection: 1\n+ Anticheat Flags: ( Le joueur à été banni perma après "..avert.." détection du serveur. [Ban ID: #".. platenum .."]. )```")
		bandata = {}
		bandata.reason = BanMessageHealthHack
		bandata.period = '0' -- days, 0 for permanent
		TriggerEvent('AntiCheat:AutoBan', source, bandata)
		--TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. nom .. " à été banni: "..BanMessageHealthHack.."")
	
		--DropPlayer(source, BanMessageHealthHack)
	
	end)

RegisterServerEvent('AC:injectionDetected')
AddEventHandler('AC:injectionDetected', function(name, source, isServerEvent)

	local eventType = 'client'
	local s = source
	local nom = GetPlayerName(source)

	if isServerEvent then
		eventType = 'server'
	end

	print('===========================================')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('^1Player id ^0[' .. source .. '] ^1à essayer d\'utiliser un event de type: ^0' .. eventType .. ' ^1 | nom de l\'event : ^0[' .. name .. ']')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('===========================================')
	SendWebhookMessageStaff(webhook,"**Mod Menu detected!** \n```diff\nJoueurs: "..nom.."\nID du joueurs: "..source.."\n\n- Type d'event utilisé : " .. eventType .. "\n- Nom de l'event utilisé : " .. name .. "\n+ Anticheat Flags: ( Le joueur à été définitivement banni du serveur. [Ban ID: #".. platenum .."]. )```")
	
	TriggerClientEvent('chatMessage', -1, "LaFive - AntiCheat", {255, 0, 0}, "Le joueur: " .. nom .. " à été banni: "..BanMessageLuaInjection.."")
	--DropPlayer(source, BanMessageLuaInjection)
	bandata = {}
	bandata.reason = BanMessageHealthHack
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
end)


RegisterServerEvent('AC:ArmeDetect')
AddEventHandler('AC:ArmeDetect', function(source)

	local eventType = 'client'
	local s = source
	local nom = GetPlayerName(source)

	if isServerEvent then
		eventType = 'server'
	end

	print('===========================================')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('^1Player id ^0[' .. source .. '] ^1à essayer d\'utiliser un event de type: ^0' .. eventType .. ' ^1 | nom de l\'event : ^0[' .. name .. ']')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('===========================================')
	SendWebhookMessageStaff(webhook,"**Arme black list** \n```diff\nJoueurs: "..nom.."\nID du joueurs: "..source.."\n\n+ Anticheat Flags: ( Le joueur à été définitivement banni du serveur. [Ban ID: #".. platenum .."]. )```")
	bandata = {}
	bandata.reason = BanMessageHealthHack
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
	TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. nom .. " à été banni: "..BanMessageHealthHack.."")

	--DropPlayer(source, BanMessageLuaInjection)
end)


RegisterServerEvent('AC:CheatDetected2')
AddEventHandler('AC:CheatDetected2', function(source)

	local name = GetPlayerName(source)
	print('===========================================')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('^1Player id ^0[' .. source .. '] ^1à été kick, God Mod / cheat detected  detection !')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('===========================================')
	SendWebhookMessageStaff(webhook,"**HEALTH HACK DETECTED!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n\n+ Anticheat Flags: ( la personne à été définitivement banni du serveur.)```")

	--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', source, 0, BanMessageHealthHack)
	bandata = {}
	bandata.reason = BanMessageHealthHack
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
	TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. name .. " à été banni: "..BanMessageHealthHack.."")

	--DropPlayer(source, BanMessageHealthHack)
end)


RegisterServerEvent('AC:GiveArgent')
AddEventHandler('AC:GiveArgent', function(source)

	local name = GetPlayerName(source)
	print('===========================================')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('^1Player id ^0[' .. source .. '] ^1à été banni pour give argent cheat engine')
	print(' ')
	print(' ')
	print(' ')
	print(' ')
	print('===========================================')
	SendWebhookMessageStaff(webhook,"**GIVE ARGENT MODDEUR!** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.."\n\n+ Anticheat Flags: ( la personne à été définitivement banni du serveur.)```")
	--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', source, 0, BanMessageHealthHack)
	bandata = {}
	bandata.reason = BanMessageHealthHack
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
	TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. name .. " à été banni: "..BanMessageHealthHack.."")


	--DropPlayer(source, BanMessageHealthHack)
end)

function WarnPlayer(playername)
	local isKnown = false
	local isKnownCount = 1
	for i,thePlayer in ipairs(violations) do
		if thePlayer.name == name then
			isKnown = true
			if violations[i].count == 10 then
				isKnownCount = violations[i].count
				print('===========================================')
				print(' ')
				print(' ')
				print(' ')
				print(' ')
				print('^1Player id ^0[' .. source .. '] ^1à été kick pour god mod !')
				print(' ')
				print(' ')
				print(' ')
				print(' ')
				print('===========================================')
				SendWebhookMessageStaff(webhook,"**CHEATER DETECTE!** \n```diff\nJoueurs: "..playername.."\nID du joueurs: "..source.."\n\n+ Anticheat Flags: ( La personne à été banni 1 jours après : "..isKnownCount.." detection. )```")
				table.remove(violations,i)
				--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', source, 0, BanMessageHealthHack)
				bandata = {}
				bandata.reason = BanMessageHealthHack
				bandata.period = '0' -- days, 0 for permanent
				TriggerEvent('AntiCheat:AutoBan', source, bandata)
				TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. name .. " à été banni: "..BanMessageHealthHack.."")

				--DropPlayer(source, BanMessageHealthHack)
				--DropPlayer(source, kickMessage)
			else
				violations[i].count = violations[i].count+1
				isKnownCount = violations[i].count
			end
		end
	end

	if not isKnown then
		table.insert(violations, { name = name, count = 1 })
	end

	return isKnown, isKnownCount,isKnownExtraText
end



-- Log De warn


RegisterServerEvent('AC:TropDeDetection')
AddEventHandler('AC:TropDeDetection', function(detect)
	local s = source
	local nom = GetPlayerName(source)
	SendWebhookMessage(webhook,"**Possible cheateur détecté** \n```diff\nJoueurs: "..nom.."\nID du joueurs: "..source.."\n- Nombre(s) de détection: "..detect.."\n\n+ Anticheat Flags: ( Le joueurs est possiblement un cheateur. )\n[Detection #".. platenum .."].```")
end)


-- Lynx menu detection
RegisterServerEvent('antilynx8:anticheat')
AddEventHandler('antilynx8:anticheat', function(meme, memename)
	SendWebhookMessageStaff(webhook,"**LYNX MENU DETECTED** \n```diff\nJoueurs: "..memename.."\nID du joueurs: "..meme.."\n\n+ Anticheat Flags: ( la personne à été définitivement banni du serveur.)```")
	--TriggerEvent("RubyAntiCheat:Ban", 'LaFiveRP_Anti_Cheat', meme, 0, BanMessageLuaInjection)
	bandata = {}
	bandata.reason = BanMessageLuaInjection
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('AntiCheat:AutoBan', source, bandata)
	TriggerClientEvent('chatMessage', -1, "LaFive - AC", {255, 0, 0}, "Le joueur: " .. memename .. " a été banni: "..BanMessageLuaInjection.."")
end) 