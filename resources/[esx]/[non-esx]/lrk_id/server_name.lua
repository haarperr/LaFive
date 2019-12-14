local serverID = GetPlayerServerId(PlayerId())


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
	  if IsControlPressed(0, 57) then
		players = {}
        for i = 0, 256 do
            if NetworkIsPlayerActive( i ) then
                table.insert( players, i )
            end
        end
		TriggerEvent('esx:showColoredNotification', "~d~Votre ID est le " .. serverID .. "", 0)
		TriggerEvent('esx:showColoredNotification', "~d~Il y a actuellement " .. #players .. " joueur(s) connecté(s)", 0)
	  end
	end
end)