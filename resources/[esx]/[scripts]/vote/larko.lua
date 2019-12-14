-- Ceci est un exemple basique utilisant ESX.
-- C'est seulement une demo, à vous de modifier à votre convenance.

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function getPlayerByName(playername)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer ~= nil and xPlayer.getName() == playername then
            return xPlayer
        end
    end
    return nil
end

AddEventHandler('onPlayerVote', function (playername, ip, date)
    local Player = getPlayerByName(playername)
    if Player then
        Player.addMoney(2000)
        TriggerClientEvent('esx:showColoredNotification', -1, ""..playername.. " a voté pour le serveur et a recu 2000$ ! Votez vous aussi et recevez 2000$", 148)
     --   TriggerClientEvent('esx:showNotification', ""..playername.. " a voté pour le serveur et a recu 2000$ ! Votez vous aussi sur le top serveur de LaFive pour recevoir 2000$")
        print('Joueur trouvé, le joueur a bien recu les 2000$')
    else
        print("Joueur introuvable !")
        TriggerClientEvent('esx:showColoredNotification', -1, "Un inconnu a voté pour le serveur et a recu 2000$ ! Votez vous aussi et recevez 2000$", 148)
     --   TriggerClientEvent('esx:showNotification', "Un inconnu a voté pour le serveur et a recu 2000$ ! Votez vous aussi pour LaFive sur TopServeur et recevez 2000$")
    end
end)

