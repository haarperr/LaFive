ESX = nil

local PlayerData                = {}



local entrerPlanque = {coords = vector3(-330.35, 48.52, 54.42)}

local SortiePlanque1 = {coords = vector3(998.08, -3158.42, -38.90)}

local SortiePlanqueVehicule = {coords = vector3(1000.35, -3164.35, -38.90)}

local SortiePlanqueVehiculeEXT = {coords = vector3(-369.93, 39.88, 51.05)}



local VehiculePlanque = {coords = vector3(1004.55, -3159.39, -38.90)}



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end



	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(10)

	end



end)



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

  PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob2')

AddEventHandler('esx:setJob2', function(job2)

  PlayerData.job2 = job2

end)





-- Zone de mise nettoyage



Citizen.CreateThread(function()

     while true do

          while ESX == nil do

               Citizen.Wait(10)

          end

		local sleepThread = 1000

		local ped = PlayerPedId()

		local pedCoords = GetEntityCoords(ped)

		local distanceSortiePlanque1 = GetDistanceBetweenCoords(pedCoords, SortiePlanque1.coords, true)

		local distanceSortiePlanqueVehicule = GetDistanceBetweenCoords(pedCoords, SortiePlanqueVehicule.coords, true)

		local distanceEntrePlanqueVehicule = GetDistanceBetweenCoords(pedCoords, SortiePlanqueVehiculeEXT.coords, true)

		local dstCheckPublic = GetDistanceBetweenCoords(pedCoords, entrerPlanque.coords, true)

		local distanceMenuVeh = GetDistanceBetweenCoords(pedCoords, VehiculePlanque.coords, true)

          if dstCheckPublic <= 30 then

               sleepThread = 5

               DrawMarker(0, entrerPlanque.coords.x, entrerPlanque.coords.y, entrerPlanque.coords.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 235, 64, 52, 100, false, true, 2, false, nil, nil, false)

          end

          if dstCheckPublic <= 2.5 then

               sleepThread = 5

               ESX.Game.Utils.DrawText3D(entrerPlanque.coords, "~b~[E] ~w~Planque de gang\n~r~Zone à risque", 1.0)

			if IsControlJustPressed(0, 38) then

				OuvrirPlanqueGang()

               end

		end

		

		-- Sortie de la planque

		if distanceSortiePlanque1 <= 30 then

               sleepThread = 5

               DrawMarker(0, SortiePlanque1.coords.x, SortiePlanque1.coords.y, SortiePlanque1.coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 235, 64, 52, 100, false, true, 2, false, nil, nil, false)

          end

          if distanceSortiePlanque1 <= 2.5 then

               sleepThread = 5

               ESX.Game.Utils.DrawText3D(SortiePlanque1.coords, "~b~[E] ~w~Sortie planque de gang", 1.0)

               if IsControlJustPressed(0, 38) then

                    SortirPlanqueGang()

               end

		end

		

		-- Sortie de la planque avec véhicule

		if distanceSortiePlanqueVehicule <= 30 then

               sleepThread = 5

               DrawMarker(36, SortiePlanqueVehicule.coords.x, SortiePlanqueVehicule.coords.y, SortiePlanqueVehicule.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 235, 64, 52, 255, false, true, 2, false, nil, nil, false)

          end

          if distanceSortiePlanqueVehicule <= 2.5 then

               sleepThread = 5

               ESX.Game.Utils.DrawText3D(SortiePlanqueVehicule.coords, "~b~[E] ~w~Sortie planque de gang\n~b~Sortie avec véhicule", 1.0)

			if IsControlJustPressed(0, 38) then

				local DansVehicule = IsPedInAnyVehicle(GetPlayerPed(-1), false)

				if DansVehicule then

					if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ms13' then

						SetPedCoordsKeepVehicle(PlayerPedId(), SortiePlanqueVehiculeEXT.coords.x, SortiePlanqueVehiculeEXT.coords.y, SortiePlanqueVehiculeEXT.coords.z-1)

						TriggerEvent("ms13:QuitteInstance")

					else

						ESX.ShowNotification("~r~Le garage ne s'ouvre pas.\n~w~Tu ne possède pas les accès.")

					end

				else

					ESX.ShowHelpNotification('Tu ~r~doit ~w~ etre en véhicule pour utiliser cette sortie.')

				end

               end

		end



		-- Entré planque avec véhicule



		if distanceEntrePlanqueVehicule <= 30 then

               sleepThread = 5

               DrawMarker(36, SortiePlanqueVehiculeEXT.coords.x, SortiePlanqueVehiculeEXT.coords.y, SortiePlanqueVehiculeEXT.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 235, 64, 52, 255, false, true, 2, false, nil, nil, false)

          end

          if distanceEntrePlanqueVehicule <= 2.5 then

               sleepThread = 5

               ESX.Game.Utils.DrawText3D(SortiePlanqueVehiculeEXT.coords, "~b~[E] ~w~Entré planque de gang\n~b~Entré avec véhicule", 1.0)

			if IsControlJustPressed(0, 38) then

				local DansVehicule = IsPedInAnyVehicle(GetPlayerPed(-1), false)

				if DansVehicule then

					if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ms13' then

						SetPedCoordsKeepVehicle(PlayerPedId(), SortiePlanqueVehicule.coords.x, SortiePlanqueVehicule.coords.y, SortiePlanqueVehicule.coords.z-1)

						TriggerEvent("ms13:SeTrouveDansLinstance")

					else

						ESX.ShowNotification("~r~Le garage ne s'ouvre pas.\n~w~Tu ne possède pas les accès.")

					end

				else

					ESX.ShowHelpNotification('Tu ~r~doit ~w~etre en véhicule pour utiliser cette sortie.')

				end

            end

		end





		-- Menu de vehicule dans la planque

		if distanceMenuVeh <= 30 then

               sleepThread = 5

               DrawMarker(36, VehiculePlanque.coords.x, VehiculePlanque.coords.y, VehiculePlanque.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 3, 252, 15, 255, false, true, 2, false, nil, nil, false)

          end

          if distanceMenuVeh <= 2.5 then

               sleepThread = 5

               ESX.Game.Utils.DrawText3D(VehiculePlanque.coords, "~b~[E] ~w~Sortir un véhicule", 1.0)

			if IsControlJustPressed(0, 38) then

				--if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ms13' then

					MenuVehicule()

				--else

				--	ESX.ShowNotification("~r~Le menu ne s'ouvre pas.\n~w~Tu ne possède pas les accès.")

				--end

            end

		end





		Citizen.Wait(sleepThread)

	end

end)