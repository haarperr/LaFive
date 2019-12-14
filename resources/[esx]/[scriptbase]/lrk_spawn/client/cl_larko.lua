ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

local larko = {
    {x = -491.092, y = -690.921, z = 20.03}
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(larko) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, larko[k].x, larko[k].y, larko[k].z)

            if dist <= 10.2 then
                ESX.ShowHelpNotification("Bienvenue sur ~b~LaFive~w~, n'oubliez pas de lire notre reglement et de rejoindre notre discord.")
            end
        end
    end
end)

local larko2 = {
    {x = -469.422, y = -701.081, z = 20.03}
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(larko2) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, larko2[k].x, larko2[k].y, larko2[k].z)

            if dist <= 10.2 then
                ESX.ShowHelpNotification("Vous pouvez retrouver toutes les touches utilisables sur : ~b~discord.lafiverp.fr~w~.")
            end
        end
    end
end)

local larko3 = {
    {x = -489.962, y = -722.561, z = 23.93}
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(larko3) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, larko3[k].x, larko3[k].y, larko3[k].z)

            if dist <= 5.2 then
                ESX.ShowHelpNotification("~b~Hakim ~w~vous attends juste en haut, vous pourrez louer un véhicule sans permis chez lui.")
            end
        end
    end
end)