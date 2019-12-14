-- Uncomment if you want add Players Steam or connected players

local id = PlayerId()
local serverID = GetPlayerServerId(PlayerId())
players = {}
for i = 0, 255 do
    if NetworkIsPlayerActive( i ) then
        table.insert( players, i )
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if IsControlJustPressed(1, 57) then -- F10
            TriggerEvent('esx:showColoredNotification', "Votre ID est le ".. GetPlayerServerId(PlayerId()) .. "", 118)
            TriggerEvent('esx:showColoredNotification', "Il y a actuellement " .. #players .. " joueurs connectés", 118)
        end
    end
end)





