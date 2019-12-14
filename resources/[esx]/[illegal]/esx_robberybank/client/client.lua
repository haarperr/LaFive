local holdingup = false
local hackholdingup = false
local bombholdingup = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local dooropen = false
local platingbomb = false
local platingbombtime = 20
local blipRobbery = nil
globalcoords = nil
globalrotation = nil
globalDoortype = nil
globalbombcoords = nil
globalbombrotation = nil
globalbombDoortype = nil




ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdupbank:currentlyrobbing')
AddEventHandler('esx_holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 300
end)

RegisterNetEvent('esx_holdupbank:currentlyhacking')
AddEventHandler('esx_holdupbank:currentlyhacking', function(robb, thisbank)
	hackholdingup = true
	RequestAnimDict("anim@heists@ornate_bank@hack")
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	while not HasAnimDictLoaded("anim@heists@ornate_bank@hack")
	do
	Wait(50)				
	end
	local playerPed = PlayerPedId()
	local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), x, y, z+0.2,  true,  true, true)
	TaskPlayAnim(playerPed,"anim@heists@ornate_bank@hack","hack_enter", 0.8, 0.0, -1,0, 0, 0, 0, 1)
	AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 10706),0,0,-0.499,0,0,0,true,true,false,true,1,true)
	Wait(800)
	local card1 = CreateObject(GetHashKey("prop_ld_wallet_01"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(card1, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005),0.20,0.05,0,0,0,0,true,true,false,true,1,true)
	Wait(1200)
	DeleteObject(card1)
	local card = CreateObject(GetHashKey("prop_cs_credit_card"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(card, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309),0.12,0.04,0,0,0,0,true,true,false,true,1,true)
	Wait(4000)
	DetachEntity(card, 1, 1)
	DeleteObject(card)
    local laptopfechado = CreateObject(GetHashKey("prop_laptop_02_closed"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(laptopfechado, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 26610),0.30,0.08,0,-0,-0,800,true,true,false,true,1,true)
	Wait(1500)
	DetachEntity(laptopfechado, 1, 1)
	DeleteObject(laptopfechado)
	local laptop = CreateObject(GetHashKey("prop_laptop_lester"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(laptop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0),0.140,0.80,0.02,0,-0.9,0,true,true,false,true,1,true)
	Wait(2000)
    DetachEntity(laptop, 1, 1)
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(-1),false)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",7,150, opendoors)
	savedbank = thisbank
	bank = robb
	secondsRemaining = 300
end)

RegisterNetEvent('esx_holdupbank:plantingbomb')
AddEventHandler('esx_holdupbank:plantingbomb', function(robb, thisbank)
	bombholdingup = true

	savedbank = thisbank
	bank = robb
	plantBombAnimation()
	secondsRemaining = 20
end)



function opendoors(success, timeremaining)
	if success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		TriggerEvent('esx_holdupbank:hackcomplete')
	else
		hackholdingup = false
		ESX.ShowNotification(_U('hack_failed'))
		print('Failure')
		TriggerEvent('mhacking:hide')
		secondsRemaining = 0
		incircle = false
	end
end

RegisterNetEvent('esx_holdupbank:killblip')
AddEventHandler('esx_holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:setblip')
AddEventHandler('esx_holdupbank:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:toofarlocal')
AddEventHandler('esx_holdupbank:toofarlocal', function(robb)
	holdingup = false
	bombholdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:toofarlocalhack')
AddEventHandler('esx_holdupbank:toofarlocalhack', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:closedoor')
AddEventHandler('esx_holdupbank:closedoor', function()
	dooropen = false
end)

RegisterNetEvent('esx_holdupbank:robberycomplete')
AddEventHandler('esx_holdupbank:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete') .. Banks[bank].reward)
	bank = ""
	TriggerEvent('esx_blowtorch:finishclear')
	TriggerServerEvent('esx_holdupbank:closedoor')
	TriggerEvent('esx_blowtorch:stopblowtorching')
	secondsRemaining = 0
	dooropen = false
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:hackcomplete')
AddEventHandler('esx_holdupbank:hackcomplete', function()
	hackholdingup = false
	ESX.ShowNotification(_U('hack_complete'))

	TriggerServerEvent('esx_holdupbank:opendoor', Banks[bank].hackposition.x, Banks[bank].hackposition.y, Banks[bank].hackposition.z, Banks[bank].doortype)

	bank = ""

	secondsRemaining = 0
	incircle = false
end)
RegisterNetEvent('esx_holdupbank:plantbombcomplete')
AddEventHandler('esx_holdupbank:plantbombcomplete', function(bank)
	bombholdingup = false


	ESX.ShowNotification(_U('bombplanted_run'))
	TriggerServerEvent('esx_holdupbank:plantbombtoall', bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z, bank.bombdoortype)

	incircle = false
end)

RegisterNetEvent('esx_holdupbank:plantedbomb')
AddEventHandler('esx_holdupbank:plantedbomb', function(x,y,z,doortype)
	local coords = {x,y,z}
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords)

    --AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
   -- AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)

	local rotation = GetEntityHeading(obs) + 47.2869
	SetEntityHeading(obs,rotation)
	globalbombcoords = coords
	globalbombrotation = rotation
	globalbombDoortype = doortype
	Citizen.CreateThread(function()
		while dooropen do
			Wait(2000)
			local obs, distance = ESX.Game.GetClosestObject(globalbombDoortype, globalbombcoords)
			SetEntityHeading(obs, globalbombrotation)
			Citizen.Wait(0);
		end
	end)
end)


RegisterNetEvent('esx_holdupbank:opendoors')
AddEventHandler('esx_holdupbank:opendoors', function(x,y,z,doortype)
	dooropen = true;

	local coords = {x,y,z}
	local obs, distance = ESX.Game.GetClosestObject('hei_v_ilev_bk_gate2_pris', coords)

	local pos = GetEntityCoords(obs);


	local rotation = GetEntityHeading(obs) + 70
	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype
	Citizen.CreateThread(function()
	while dooropen do
		Wait(2000)
		local obs, distance = ESX.Game.GetClosestObject(globalDoortype, globalcoords)
		SetEntityHeading(obs, globalrotation)
	end
	end)
end)


RegisterNetEvent('esx_holdupbank:exit')
AddEventHandler('esx_holdupbank:exit', function(bank)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), bank.hackposition.x , bank.hackposition.y, bank.hackposition.z, 0, 0, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
		if hackholdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
		if bombholdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 255)--156
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 75)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob') .. v.nameofbank)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_holdupbank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			DisplayHelpText(_U('press_to_cancel'))

			local pos2 = Banks[bank].position


			if IsControlJustReleased(1, 51) then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
				TriggerEvent('esx_blowtorch:stopblowtorching')
			end

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.hackposition

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not hackholdingup then
					DrawMarker(1, v.hackposition.x, v.hackposition.y, v.hackposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_hack') .. v.nameofbank)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_holdupbank:hack', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if hackholdingup then

			drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('hack_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)

			local pos2 = Banks[bank].hackposition

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('esx_holdupbank:toofarhack', bank)
			end
		end

		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.bombposition
			if (pos2 ~= nil) then
				if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
					if not bombholdingup then
						DrawMarker(1, v.bombposition.x, v.bombposition.y, v.bombposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

						if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
							if (incircle == false) then
								DisplayHelpText(_U('press_to_bomb') .. v.nameofbank)
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent('esx_holdupbank:plantbomb', k)
							end
						elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
							incircle = false
						end
					end
				end
			end
		end

		if bombholdingup then

			drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('bomb_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			DisplayHelpText(_U('press_to_cancel'))

			local pos2 = Banks[bank].bombposition


			if IsControlJustReleased(1, 51) then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)
function plantBombAnimation()
	local playerPed = GetPlayerPed(-1)

	
Citizen.CreateThread(function()
        platingbomb = true
			while platingbomb do
				local mesa = CreateObject(GetHashKey("hei_prop_gold_trolly_empty"), 263.25, 216.37, 100.55, true)
                FreezeEntityPosition(mesa, true)
				--SetEntityAsMissionEntity(CashPile, true, true)
				local mesa1 = CreateObject(GetHashKey("hei_prop_gold_trolly_empty"), 262.4, 212.93, 100.55, true)
                FreezeEntityPosition(mesa1, true)
				--SetEntityAsMissionEntity(CashPile2, true, true)
				local mesaouro = CreateObject(GetHashKey("prop_gold_trolly_full"), 266.32, 215.22, 100.55, true)
                FreezeEntityPosition(mesaouro, true)
                --SetEntityAsMissionEntity(gold, true, true)
                local mesaouro = CreateObject(GetHashKey("prop_gold_trolly_full"), 265.34, 211.96, 100.55, true)
                FreezeEntityPosition(mesaouro, true)
				--SetEntityAsMissionEntity(gold2, true, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.35, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.50, 101.45, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.35, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.50, 101.49, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.35, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.50, 101.53, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.35, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.20, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.52, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.45, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.38, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.31, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.24, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.17, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.10, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.03, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.89, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.96, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.88, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 262.81, 216.50, 101.57, true)
				local CashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), 263.59, 216.50, 101.57, true)
                Wait(1000)
                RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
				while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge")
				do
				Wait(50)				
				end
				local playerPed = PlayerPedId()
				local bomba = CreateObject(GetHashKey("prop_bomb_01"), x, y, z+0.2,  true,  true, true)
				local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), x, y, z+0.2,  true,  true, true)
				TaskPlayAnim(playerPed,"anim@heists@ornate_bank@thermal_charge","thermal_charge", 0.8, 0.0, -1,0, 0, 0, 0, 1)
				SetPedComponentVariation(PlayerPedId(),5,0,0,0)
				AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 10706),0,0,-0.499,0,0,0,true,true,false,true,1,true)
				--TaskPlayAnim(playerPed,"anim@heists@ornate_bank@thermal_charge","bag_thermal_charge", 0.8, 0.0, -1,0, 0, 0, 0, 1)
				--AttachEntityToEntity(bag, GetPlayerPed(-1), GetEntityBoneIndexByName(GetPlayerPed(PlayerPedId), "p_lhand"),0,0,-0.499,0,0,0,true,true,false,true,1,true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				FreezeEntityPosition(bag(-1),false)
				Wait(1500)
				AttachEntityToEntity(bomba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0, 0, 0, 0, 0, 175.0, true, true, false, true, 1, true)
                Wait(8000)
				DetachEntity(bomba, 1, 1)
				DeleteObject(bomba)
                if secondsRemaining <= 1 then
                    platingbomb = false
                    ClearPedTasksImmediately(PlayerPedId())

                end
                Citizen.Wait(0)
            end

    end)
end
