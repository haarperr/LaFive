---------------------------------
-- Created By Toni Morton      --
-- Please, Leave these credits --
-- Edited By Avery M. --
---------------------------------


RegisterServerEvent("SyncTrafficAlert")
AddEventHandler('SyncTrafficAlert', function(inputText)
TriggerClientEvent('DisplayTrafficAlert', -1, inputText)
end)


AddEventHandler('chatMessage', function(from, name, message)
	if message == "/news" then
		CancelEvent()
		TriggerClientEvent("TrafficAlert", from)
	end
end)

---------------------------------
-- Created By Toni Morton      --
-- Please, Leave these credits --
-- Edited By Avery M. --
---------------------------------
