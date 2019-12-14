ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

-- blips

local blips = {
    {title="Pôle emplois", colour=5, id=408, x = -310.0, y = -278.6, z = 30.2}
}

Citizen.CreateThread(function()

    if Config.EnableBlips then
        for _, info in pairs(blips) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.id)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, 0.9)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)
        end
    end
end)

--Citizen.CreateThread(function()
--    local hash = GetHashKey("mp_f_boatstaff_01")
--    while not HasModelLoaded(hash) do
--    RequestModel(hash)
--    Wait(20)
--    end
--    ped = CreatePed("PED_TYPE_CIVMALE", "mp_f_boatstaff_01", -265.19, -962.5, 30.22, 202.776, true, true)
--    SetBlockingOfNonTemporaryEvents(ped, true)
--    SetEntityInvincible(ped, true)
--    FreezeEntityPosition(ped, true)
--    SetEntityAsMissionEntity(ped, true, true)
--    SetPedHearingRange(ped, 0.0)
--    SetPedSeeingRange(ped, 0.0)
--    SetPedAlertness(ped, 0.0)
--    SetPedFleeAttributes(ped, 0, 0)
--    SetPedCombatAttributes(ped, 46, true)
--end)

-- marker et help text

local joblisting = {
	{x = -310.47, y = -278.55, z = 30.72},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        for k in pairs(joblisting) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, joblisting[k].x, joblisting[k].y, joblisting[k].z)

            if dist <= 3.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~pôle emplois~s~")
				if IsControlJustPressed(1,51) then 
					mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)
