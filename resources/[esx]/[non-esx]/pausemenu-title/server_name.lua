function SetData()
	players = {}
	for i = 0, 255 do
		if NetworkIsPlayerActive( i ) then
			table.insert( players, i )
		end
	end
	
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~y~RedSideRP ~t~| ~g~Discord: p3x5g8x~t~ | ~b~ID: ' .. id .. ' ~t~| ~b~Nom: ~b~' .. name .. " ~t~| ~r~Joueurs: " .. #players .. "/64")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)