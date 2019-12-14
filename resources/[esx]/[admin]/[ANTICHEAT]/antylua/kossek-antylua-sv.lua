ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("kossek-antylua:kick")
AddEventHandler("kossek-antylua:kick", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	print(('LaFive a détecté un logiciel externe douteux sur votre ordinateur, si vous pensez que cela est une erreur veuillez contacter notre support discord à l\'adresse suivante : https://discord.gg/UjUrfnN'):format(xPlayer.identifier))
	DropPlayer(source, "LaFive a détecté un logiciel externe douteux sur votre ordinateur, si vous pensez que cela est une erreur veuillez contacter notre support discord à l\'adresse suivante : https://discord.gg/UjUrfnN")
end)