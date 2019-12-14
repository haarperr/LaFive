ID = math.random(00001, 99998)
ver = "LaFive AntiCheat."


function SendWebhookMessageInit(webhook,message)
	webhook = "https://discordapp.com/api/webhooks/654076483559489572/L0eCYSZQlKa-gpQERZFAOvHl4r5D1whuP7ejomGBxZj1x6aMFg2vskDBv5Ez7nORCIrH"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local r = math.random(00001, 99998)
		ID = r
	end
end)

SendWebhookMessageInit(webhook,"**Initialisation de l'Anti Cheat** \n**Version:** "..ver.."\n**Module:**\n- cl_DeleteVehModdeur: **ALLUMER**\n- cl_anticheat: **ALLUMER**\n- srv_anticheat: **ALLUMER**\n\n```[Initialisation #".. ID .."].```")



print("^2 ==================================================================== ")
print(" ")
print(" ")
print(" ")
print(" ")
print("\t\t^1Serveur sous protection")
print("\t\t^1     Version: "..ver.."")
print(" ")
print(" ")
print(" ")
print(" ")
print("^2 ====================================================================")


local sync = 0
RegisterServerEvent("AC:Sync")
AddEventHandler("AC:Sync", function(source)
	local sync = sync+1
	local player = GetNumPlayerIndices()
	print("^2Syncronisation AntiCheat effectué ^4[SyncID] ^2"..sync.."+"..player)
end)



-- STATISTIQUE AC

function WebhookStats(webhook,message)
	webhook = "https://discordapp.com/api/webhooks/654076483559489572/L0eCYSZQlKa-gpQERZFAOvHl4r5D1whuP7ejomGBxZj1x6aMFg2vskDBv5Ez7nORCIrH"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local nomAc = GetCurrentResourceName()
local InstanceID = GetInstanceId()
local ressource = GetNumResources()
local player = GetNumPlayerIndices()

WebhookStats(webhook,"**Initialisation de l'anti cheat** \n**Version:** "..ver.."\n**Module:**\n- cl_DeleteVehModdeur: **ALLUMER**\n- cl_anticheat: **ALLUMER**\n- srv_anticheat: **ALLUMER**\n``` DEBUG ```\n**AC Lancer sous:** "..nomAc.."\n**Instance ID:** "..InstanceID.."\n**Nombres de ressource:** "..ressource.."\n**Player Indices:** "..player.."\n\n```[Initialisation #".. ID .."].```")

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
		SendWebhookMessageInit(webhook,"**Désactivation de l'anti cheat** \n**Version:** "..ver.."\n**Module:**\n- cl_DeleteVehModdeur: **ÉTEINT**\n- cl_anticheat: **ÉTEINT**\n- srv_anticheat: **ÉTEINT**\n\n```[Initialisation #".. ID .."].```")
		

		WebhookStats(webhook,"**Désactivation de l'anti cheat** \n**Version:** "..ver.."\n**Module:**\n- cl_DeleteVehModdeur: **ÉTEINT**\n- cl_anticheat: **ÉTEINT**\n- srv_anticheat: **ÉTEINT**\n``` DEBUG ```\n**AC Lancer sous:** "..nomAc.."\n**Instance ID:** "..InstanceID.."\n**Nombres de ressource:** "..ressource.."\n**Player Indices:** "..player.."\n\n```[Initialisation #".. ID .."].```")
    end
end)