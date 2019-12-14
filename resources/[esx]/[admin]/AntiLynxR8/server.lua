--- CONFIGURATION ---

-- Whitelist players by giving them "applecheat.bypass"

-- register some fake events (set to "" to disable)
local eventname1 = "antilynx8:anticheat"
local eventname2 = "DiscordBot:playerDied"
local eventname3 = "mellotrainer:adminKick"

-- discord webhook (set to "" to disable)
local webhookurl = "" -- not tested

-- Check if command- and resource-count is correct
local checkComsEveRes = true

-- kill detection (only if enabled in client.lua)
local minKills = 5 -- minimal kills to send a sorry

-- detect a manipulated game timer
local gameTimer = false -- doesnt seem to work on all servers

-- prevent fake chat messages
local checkChatMessage = true -- (might be incompatible with other scripts)

--- CONFIGURATION ---

if(checkChatMessage) then
	RegisterServerEvent("_chat:messageEntered")
	RegisterServerEvent("chat:addMessage")
	AddEventHandler('_chat:messageEntered', function(author, color, message)
		if(GetPlayerName(source)) then
			if(GetPlayerName(source):find(author)) then
				CancelEvent()
				if(IsPlayerAceAllowed(source, "applecheat.bypass")) then
					print("AppleCheat: " .. GetPlayerName(source) .. " [" .. source .. "] should have been kicked, but he is allowed to bypass.")
				else
					TriggerClientEvent("chatMessage", -1, "AppleCheat", {180, 0, 0}, GetPlayerName(source) .. " has been kicked.")
					if(not webhookurl == "") then
						PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = "AppleCheat", content = GetPlayerName(source) .. " [" .. source .. "] has been kicked."}), { ['Content-Type'] = 'application/json' })
					end
					if(reson == "resources") then
						print()
						print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he sent a fake-chat-message. Identifiers:")
						for id in pairs(GetPlayerIdentifiers(source)) do
							print(GetPlayerIdentifiers(source)[id])
						end
						print()		
						DropPlayer(source, "AppleCheat: This chat-message does not seem to be normal!")
					end
				end
			end
		end
	end)
	AddEventHandler('chat:addMessage', function(author, color, message)
		if(GetPlayerName(source)) then
			if(GetPlayerName(source):find(author)) then
				CancelEvent()
				if(IsPlayerAceAllowed(source, "applecheat.bypass")) then
					print("AppleCheat: " .. GetPlayerName(source) .. " [" .. source .. "] should have been kicked, but he is allowed to bypass.")
				else
					TriggerClientEvent("chatMessage", -1, "AppleCheat", {180, 0, 0}, GetPlayerName(source) .. " has been kicked.")
					if(not webhookurl == "") then
						PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = "AppleCheat", content = GetPlayerName(source) .. " [" .. source .. "] has been kicked."}), { ['Content-Type'] = 'application/json' })
					end
					if(reson == "resources") then
						print()
						print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he sent a fake-chat-message. Identifiers:")
						for id in pairs(GetPlayerIdentifiers(source)) do
							print(GetPlayerIdentifiers(source)[id])
						end
						print()		
						DropPlayer(source, "AppleCheat: This chat-message does not seem to be normal!")
					end
				end
			end
		end
	end)
end

RegisterServerEvent("anticheatkick")
AddEventHandler("anticheatkick", function(reson)
	if(IsPlayerAceAllowed(source, "applecheat.bypass")) then
		if(not reson == "keys") then
			print("AppleCheat: " .. GetPlayerName(source) .. " [" .. source .. "] should have been kicked, but he is allowed to bypass.")
		end
	else
		if(GetPlayerName(source)) then
			TriggerClientEvent("chatMessage", -1, "AppleCheat", {180, 0, 0}, GetPlayerName(source) .. " has been kicked.")
		end
		if(not webhookurl == "") then
			PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = "AppleCheat", content = GetPlayerName(source) .. " [" .. source .. "] has been kicked."}), { ['Content-Type'] = 'application/json' })
		end
		if(reson == "resources") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his resources were manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()		
			DropPlayer(source, "AppleCheat: Your resources seem to be manipulated!")
		elseif(reson == "commands") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his commands were manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Your commands seem to be manipulated!")
		elseif(reson == "god") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because of using god-mode. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Seems like you are using god-mode!")
		elseif(reson == "keys") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because of pressing forbidden keys. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Vous avez appuyer sur une touche bloquer")
		elseif(reson == "invisiblevehicle") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his vehicle was invisible. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Your vehicle seems to be invisible!")
		elseif(reson == "tp") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because of teleportation or No-Clipping. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Seems like you teleported!")
		elseif(reson == "gametimer") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his game-time was manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Seems like your game-time was manipulated!")
		elseif(reson == "speedhack") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his speed was manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Your speed seem to be manipulated!")
		elseif(reson == "events") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his events were manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Your events seem to be manipulated!")
		elseif(reson == "handling") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because his handling was manipulated. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: Your handling seems to be manipulated!")
		elseif(reson == "visible") then
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he was invisible. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: You seem to be invisible!")
		else
			print()
			print(GetPlayerName(source) .. " [" .. source .. "] has been kicked. Identifiers:")
			for id in pairs(GetPlayerIdentifiers(source)) do
				print(GetPlayerIdentifiers(source)[id])
			end
			print()
			DropPlayer(source, "AppleCheat: You have been kicked, the reason is unknown yet.")
		end
	end
end)

deadplayers = {}
Citizen.CreateThread(function()
	while true do
		if(checkComsEveRes) then
			TriggerClientEvent("hereyourDATAcheat", -1, GetNumResources(), #GetRegisteredCommands())
		end
		if(gameTimer) then
			TriggerClientEvent("gameTimerChack", -1)
		end
		if(#deadplayers > 0) then
			if(#deadplayers >= minKills) then
				for pID in pairs(deadplayers) do
					TriggerClientEvent("chatMessage", deadplayers[pID], "AppleCheat", {180, 0, 0}, "This did not go as planned. Sorry!")
				end
			end
		end
		while(#deadplayers > 0) do
			table.remove(deadplayers, 1)
		end
		Wait(30000)
	end
end)

RegisterServerEvent("deadcheat")
AddEventHandler("deadcheat", function()
	table.insert(deadplayers, source)
end)

if(not eventname1 == "") then
	RegisterServerEvent(eventname)
	AddEventHandler(eventname, function()
		print()
		print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he triggered the wrong event. Identifiers:")
		for id in pairs(GetPlayerIdentifiers(source)) do
			print(GetPlayerIdentifiers(source)[id])
		end
		print()		
		DropPlayer(source, "AppleCheat: You triggered the wrong event!")
	end)
end
if(not eventname2 == "") then
	RegisterServerEvent(eventname)
	AddEventHandler(eventname, function()
		print()
		print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he triggered the wrong event. Identifiers:")
		for id in pairs(GetPlayerIdentifiers(source)) do
			print(GetPlayerIdentifiers(source)[id])
		end
		print()		
		DropPlayer(source, "AppleCheat: You triggered the wrong event!")
	end)
end
if(not eventname3 == "") then
	RegisterServerEvent(eventname)
	AddEventHandler(eventname, function()
		print()
		print(GetPlayerName(source) .. " [" .. source .. "] has been kicked, because he triggered the wrong event. Identifiers:")
		for id in pairs(GetPlayerIdentifiers(source)) do
			print(GetPlayerIdentifiers(source)[id])
		end
		print()		
		DropPlayer(source, "AppleCheat: You triggered the wrong event!")
	end)
end