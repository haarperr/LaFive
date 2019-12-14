-- Created by Deziel0495 and IllusiveTea --

-- NOTICE
-- This script is licensed under "No License". https://choosealicense.com/no-license/
-- You are allowed to: Download, Use and Edit the Script. 
-- You are not allowed to: Copy, re-release, re-distribute it without our written permission.

-- local Keys = {
	-- ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	-- ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	-- ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	-- ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	-- ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	-- ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	-- ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	-- ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	-- ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
-- }

--- DO NOT EDIT THIS
local holstered = true

ESX = nil
-- local PoliceJob = 'police'
local PlayerData = {}

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
	-- PlayerData.job = job
-- end)

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
	-- PlayerData = xPlayer
-- end)

-- RESTRICTED PEDS --
-- I've only listed peds that have a remote speaker mic, but any ped listed here will do the animations.
local skins = {
	-- Police --
	"mp_f_freemode_01",
	"mp_m_freemode_01",
}

-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_PISTOL50",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_SNSPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_VINTAGEPISTOL"
}

-- HOLSTER/UNHOLSTER GANG --

 Citizen.CreateThread(function()
	 while true do
        Citizen.Wait(0)
		loadAnimDict( "reaction@intimidation@1h" )
        local ped = PlayerPedId()
        -- if DoesEntityExist( ped ) and not IsEntityDead( ped ) and GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall (ped) then
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInWater(ped) and not IsPedSwimmingUnderWater(ped) and not IsPedSwimming(ped) then
			-- if DoesEntityExist( ped ) and not IsEntityDead( ped ) and GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall (ped) then
            if CheckWeapon(ped) then
                if holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                    Citizen.Wait(1700)
                    ClearPedTasks(ped)
                    holstered = false
                end
            elseif not CheckWeapon(ped) then
                if not holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                    Citizen.Wait(1500)
                    ClearPedTasks(ped)
                    holstered = true
                end
            end
        end
    end
end)

-- DO NOT REMOVE THESE! --

-- function CheckSkin(ped)
	-- for i = 1, #skins do
		-- if GetHashKey(skins[i]) == GetEntityModel(ped) then
			-- return true
		-- end
	-- end
	-- return false
-- end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if blocked then
				DisableControlAction(1, 25, true )
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				DisableControlAction(1, 23, true)
				DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
				DisablePlayerFiring(ped, true) -- Disable weapon firing
			end
	end
end)

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
