Citizen.CreateThread(function()

	Detection1()

end)



Citizen.CreateThread(function()

	Detection2()

end)



Citizen.CreateThread(function()

	Detection3()

end)



--[[Citizen.CreateThread(function()

	Detection4()

end)]]



--[[Citizen.CreateThread(function()

	Detection5()

end)]]



Citizen.CreateThread(function()

	DecorRegister('GamemodeCar', 3)

	DecorRegisterLock()

	Detection6()

end)



Citizen.CreateThread(function()

	Detection7()

end)



function ReqAndDelete(entity)

	if DoesEntityExist(entity) then

		NetworkRequestControlOfEntity(entity)

		local uselessCount = 0



		while (DoesEntityExist(entity) and not NetworkHasControlOfEntity(entity) and uselessCount < 100) do

			Citizen.Wait(1)

			uselessCount = uselessCount + 1

		end



		if DoesEntityExist(entity) then

			DetachEntity(entity, false, false)

			SetEntityCollision(entity, false, false)

			SetEntityAlpha(entity, 0, 1)

			SetEntityAsNoLongerNeeded(entity)



			if IsAnEntity(entity) then

				DeleteEntity(entity)

			elseif IsEntityAPed(entity) then

				DeletePed(entity)

			elseif IsEntityAVehicle(entity) then

				DeleteVehicle(entity)

			elseif IsEntityAnObject(entity) then

				DeleteObject(entity)

			end

		end

	end

end



function ViolateReport(report)

	TriggerServerEvent("token_1995:myAcSuckYourAssholeHacker", report)

end



function Detection1()

	while true do

		Citizen.Wait(1000)



		for k, v in ipairs(GetRegisteredCommands()) do

			for k2, v2 in ipairs(BlackList.Cmds) do

				if v.name == v2 then

				--	ViolateReport("Commandes BlackLists (" .. v2 ..")")

					TriggerServerEvent('Anticheat:Jump')

				end

			end

		end

	end

end



function Detection2()

	while true do

		Citizen.Wait(1000)

		local plyPed = PlayerPedId()



		for k, v in ipairs(BlackList.Weapons) do

			Citizen.Wait(10)



			if HasPedGotWeapon(plyPed, GetHashKey(v), false) then

				RemoveWeaponFromPed(plyPed, GetHashKey(v))

				--ViolateReport("Armes Interdites")

			end

		end

	end

end



function Detection3()

	while true do

		Citizen.Wait(60000)

		local plyPed = PlayerPedId()

		local player = PlayerId()



		if NetworkIsLocalPlayerInvincible() or GetPlayerInvincible(player) or GetEntityHealth(plyPed) > 200 then

			ViolateReport("Invincibilité")

		else

			if not IsPlayerDead(player) then

				if GetEntityHealth(plyPed) > 2 then

					local plyHealth = GetEntityHealth(plyPed)

					ApplyDamageToPed(plyPed, 2, false)

					Citizen.Wait(25)

		

					if GetEntityHealth(plyPed) == plyHealth then

					--	ViolateReport("Invincibilité")

					else

						SetEntityHealth(plyPed, plyHealth)

					end

				end



				if GetPedArmour(plyPed) > 2 then

					local plyArmor = GetPedArmour(plyPed)

					ApplyDamageToPed(plyPed, 2, true)

					Citizen.Wait(25)

	

					if GetPedArmour(plyPed) == plyArmor then

					--	ViolateReport("Invincibilité")

					else

						SetPedArmour(plyPed, plyArmor)

					end

				end

			end

		end

	end

end



function Detection4()

	while true do

		Citizen.Wait(30000)

		local plyPed = PlayerPedId()

		local vehPed = GetVehiclePedIsUsing(plyPed)



		if vehPed then

			if GetEntityHealth(vehPed) > GetEntityMaxHealth(vehPed) then

				--ViolateReport("Invincibilité Véhicule")

				SetEntityAsMissionEntity(vehiclePedIsUsing, true, true)

			end

		end

	end

end



function Detection5()

	while true do

		Citizen.Wait(0)



		if IsInputDisabled(2) then

			if IsDisabledControlPressed(0, 47) and IsControlJustReleased(0, 21) then

				--ViolateReport("Appuie Touche Suspècte - G / INSERT / 47-21")

			end



			if IsDisabledControlJustReleased(0, 117) then

			--	ViolateReport("Appuie Touche Suspècte - NUMPAD 7 / 117")

			end



			if IsDisabledControlJustReleased(0, 110) then

			--	ViolateReport("Appuie Touche Suspècte - NUMPAD 5 / 110")

			end



			--if IsDisabledControlJustReleased(0, 176) then

			--	ViolateReport("Appuie Touche Suspècte - ENTER / LEFT MOUSE BUTTON")

			--end



			if IsDisabledControlJustReleased(0, 121) then

			--	ViolateReport("Appuie Touche Suspècte - INSERT")

			end

		end

	end

end



function Detection6()

	while true do

		Citizen.Wait(10)



		for vehicle in EnumerateVehicles() do

			local handle = GetEntityScript(vehicle)



			if handle ~= nil then
                for k, v in ipairs(BlackList.Vehicles) do

					if GetEntityModel(vehicle) == GetHashKey(v) then

							ReqAndDelete(vehicle)
					end
				end
			end
		end
	end
end



function Detection7()

	while true do

		Citizen.Wait(10)



		for prop in EnumerateObjects() do

			Citizen.Wait(0)

			local handle = GetEntityScript(prop)



			if handle ~= nil and handle ~= 'es_extended' then

				ReqAndDelete(prop)

			end

		end

	end

end



RegisterNetEvent('token_1995:byebyeEntities')

AddEventHandler('token_1995:byebyeEntities', function()

	for prop in EnumerateObjects() do

		Citizen.Wait(10)

		local handle = GetEntityScript(prop)



		if handle ~= nil and handle ~= 'es_extended' then

			print('Ent Owner : ' .. NetworkGetEntityOwner(prop))

			ReqAndDelete(prop)

		end

	end

end)