ESX                           = {}

local ind = {l = false, r = false}

local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
		    local vc = GetVehicleClass(veh)
		    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end	

Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end


local enableCruise = false
Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 0 )   
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped, false)
		local vehicleModel = GetEntityModel(vehicle)
		local speed = GetEntitySpeed(vehicle)
		local carSpeed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
		local float Max = GetVehicleMaxSpeed(vehicleModel)
			if ( ped ) then
				if IsControlJustPressed(1, 137) then
					local inVehicle = IsPedSittingInAnyVehicle(ped)
					if (inVehicle) then
						if (GetPedInVehicleSeat(vehicle, -1) == ped) then
						--vehicle = GetVehiclePedIsIn(ped, false)
						--speed = GetEntitySpeed(vehicle)
							
							if enableCruise == false then 
							SetEntityMaxSpeed(vehicle, speed)
							enableCruise = true
							speed = carSpeed
							TriggerEvent('esx:showColoredNotification', "Régulateur de vitesse actif sur " ..speed.."km/h", 148)
				SendNUIMessage({
						cruise = true,
					})else
					SetEntityMaxSpeed(vehicle, Max)
					enableCruise = false
					SendNUIMessage({
						cruise = false,
						TriggerEvent('esx:showNotification', "Régulateur de vitesse ~r~désactivé.")
					})
					end 
						else
							TriggerEvent('esx:showColoredNotification', "Vous devez conduire pour effectuer cette action.", 6)
						end
					end
				end
			end
		end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		
		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(ped)
		
		if car ~= 0 and (wasInCar or IsCar(car)) then
		
			wasInCar = true
			
            if beltOn then 
				DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
				DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
				end
			
			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(car)
			
			if speedBuffer[2] ~= nil 
			   and not beltOn
			   and GetEntitySpeedVector(car, true).y > 1.0  
			   and speedBuffer[1] > Cfg.MinSpeed 
			   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Cfg.DiffTrigger) then
			   
				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end
				
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)
			if IsControlJustReleased(0, 311) then
				beltOn = not beltOn
				if beltOn then 
					TriggerEvent('esx:showColoredNotification', "Ceinture attachée", 18)
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'buckle', 0.9)
				SendNUIMessage({
						seatbelt = true,
					})else
						TriggerEvent('esx:showColoredNotification', "Ceinture détachée", 6)
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'unbuckle', 0.9)
					SendNUIMessage({
						seatbelt = false,
					})
					end 
			end
			
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})

				-- Lights
				_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				if(feuPosition == 0 and feuRoute == 0) then
					SendNUIMessage({
						feuPosition = false
					})
				else
					SendNUIMessage({
						feuPosition = true
					})
				end
				if(feuPosition == 1 and feuRoute == 1) then
					SendNUIMessage({
						feuRoute = true
					})
				else
					SendNUIMessage({
						feuRoute = false
					})
				end

				
				
				
				-- Turn signal
				-- SetVehicleIndicatorLights (1 left -- 0 right)
				local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				if IsControlJustPressed(1, 190) then -- Sağ Ok
					ind.l = not ind.l
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.l)
				end
				if IsControlJustPressed(1, 189) then -- Sol Ok
					ind.r = not ind.r
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.r)
				end

				if(VehIndicatorLight == 0) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 1) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 2) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = true,
					})
				elseif(VehIndicatorLight == 3) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = true,
					})
				end

			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end

		Citizen.Wait(1)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				fuel = GetVehicleFuelLevel(PedCar)
				rpm = GetVehicleCurrentRpm(PedCar)
				rpmfuel = 0

--				if rpm > 0.9 then
--					rpmfuel = fuel - rpm / 0.8
--					Citizen.Wait(1000)
--				elseif rpm > 0.8 then
--					rpmfuel = fuel - rpm / 1.1
--					Citizen.Wait(1500)
--				elseif rpm > 0.7 then
--					rpmfuel = fuel - rpm / 2.2
--					Citizen.Wait(2000)
--				elseif rpm > 0.6 then
--					rpmfuel = fuel - rpm / 4.1
--					Citizen.Wait(3000)
--				elseif rpm > 0.5 then
--					rpmfuel = fuel - rpm / 5.7
--					Citizen.Wait(4000)
--				elseif rpm > 0.4 then
--					rpmfuel = fuel - rpm / 6.4
--					Citizen.Wait(5000)
--				elseif rpm > 0.3 then
--					rpmfuel = fuel - rpm / 6.9
--					Citizen.Wait(6000)
--				elseif rpm > 0.2 then
--					rpmfuel = fuel - rpm / 7.3
--					Citizen.Wait(8000)
--				else
--					rpmfuel = fuel - rpm / 7.5
--					Citizen.Wait(15000)
--				end

			--	carFuel = SetVehicleFuelLevel(PedCar, rpmfuel)

				SendNUIMessage({
			showfuel = true,
					fuel = fuel
				})
			end
		end

		Citizen.Wait(1)
	end
end)

  --larko--