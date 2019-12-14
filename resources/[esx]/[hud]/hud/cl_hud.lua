--BY BNJ-- 𝑯𝒐𝒎𝒎𝒆-𝒆𝒇𝒇𝒊𝒄𝒂𝒔𝒆

ESX                  = nil
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
end)
RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(moneyx)
	if rdy then
		ESX.PlayerData.money = moneyx

	end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded  = true
	ESX.PlayerData    = xPlayer

	cash = ESX.PlayerData.money



end)
PlayerData = {}
local boss = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded  = true
    ESX.PlayerData    = xPlayer

    cash = ESX.PlayerData.money

  PlayerData  = xPlayer
  if PlayerData.job.grade_name == 'boss' then
    
    boss = true
  else
    boss = false
  end
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job



  if PlayerData.job.grade_name == 'boss' then
    
    boss = true
  else
    boss = false
  end

end)
function roundxx(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end









function drawRct2(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function drawTxt3(x,y ,width,height,scale, text, r,g,b,a)
        SetTextFont(4)
        SetTextProportional(0)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, a)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(2, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x - width/2, y - height/2 + 0.005)
end

function drawTxtHUD(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
local ShowHUD = true
function drawKM(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
local cash = 0
local blackcash = 0
RegisterNetEvent("sendWeight")
AddEventHandler("sendWeight", function(mm)
	Weight = mm
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(_, _, _)
	cash = ESX.GetPlayerData().money
end)
RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(_, _)
	cash = ESX.GetPlayerData().money
end)
RegisterNetEvent("showhud:toggle")
AddEventHandler("showhud:toggle", function(m)
	ShowHUD = m
end)
local rdy = true
function ShowHud()
	ShowHUD = not ShowHUD

end
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	rdy = true
end)

--ShowHud()
Citizen.CreateThread(function()
	hea = 200
	while true do
        while ESX == nil do
            Wait(1)  
        end
        Citizen.Wait(1000)
        while ESX.GetPlayerData().accounts == nil do
            Wait(1)

        end

        if rdy then
            TriggerEvent('es:setMoneyDisplay', 0.0)
            ESX.UI.HUD.SetDisplay(0.0)
            TriggerEvent('esx_status:setDisplay', 0.0)
            cash = ESX.GetPlayerData().money
            blackcash = ESX.GetPlayerData().accounts[2].money
		end
	end

end)
local faimVal = 0
local soifVal = 0
Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(5000)
		
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			faimVal = status.val/1000000*100

		end)
		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			soifVal = status.val/1000000*100

		end)
		
	end

end)
HUD = {}
HUD.rouge = 255
HUD.bleu = 94
HUD.vert = 87
local societyMoney = 0

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)

  if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' and 'society_' .. PlayerData.job.name == society then
    societyMoney = money
  end

end)

Citizen.CreateThread(function()
	hea = 200
	while true do
		Citizen.Wait(0)
		if rdy then
			if ShowHUD then
				local myPed = GetPlayerPed(-1)
				local veh = GetVehiclePedIsIn(myPed,true)
				local health = GetEntityHealth(myPed) - 100
				local armor = GetPedArmour(myPed)
				local vitesse = GetEntitySpeed(veh) * 3.6
				local plate = GetVehicleNumberPlateText(veh)
				if health < 0 then 
					health = GetEntityHealth(myPed)
				end
                local armor = GetPedArmour(myPed)
              
                if boss then
                    drawTxt(math.ceil(societyMoney) .. " $",4,2,0.706,0.01,0.5,255,255,255,255) 
                    drawRct2(0.6725,0.0,0.069,0.045,0,0,0,200) 
                    drawRct2(0.6725,0.0,0.069,0.005,		HUD.rouge, HUD.vert, HUD.bleu,255)
                end
				drawRct2(0.3265,0.0,0.069,0.045,0,0,0,200) 
				drawRct2(0.3265,0.0,0.069,0.005,	HUD.rouge, HUD.vert, HUD.bleu,200)
				drawTxt(math.ceil(cash) .. " $",4,2,0.360,0.01,0.5,255,255,255,255) 
				drawRct2(0.398,0.0,0.069,0.045,0,0,0,200) 
				drawRct2(0.398,0.0,0.069,0.005,		HUD.rouge, HUD.vert, HUD.bleu,255)
				drawTxt(math.ceil(blackcash) .. " $",4,2,0.432,0.01,0.5,234, 32, 39,255) 
                drawTxt3(0.979, 0.505, 1.0,1.0,0.50 , "" ..math.ceil(health) .. "%", 255, 255, 255, 255) 
                drawTxt3(1.008, 0.505, 1.0,1.0,0.40 , "" .."💉" ,255, 255, 255, 255) 
                drawTxt3(1.121, 0.505, 1.0,1.0,0.50 , "" ..math.ceil(armor).."%", 255, 255, 255, 255) 
                drawTxt3(1.144, 0.505, 1.0,1.0,0.40 , "" .."🛡" ,255, 255, 255, 255) 
                
                
                drawTxt3(1.03	, 0.505, 1.0,1.0,0.50 , "" ..math.ceil(faimVal) .. "%", 255, 255, 255, 255) 
                drawTxt3(1.052, 0.505, 1.0,1.0,0.40 , "" .."🍔" ,255, 255, 255, 255) 

                drawTxt3(1.074	, 0.505, 1.0,1.0,0.50 , "" ..math.ceil(soifVal) .. "%", 255, 255, 255, 255) 
                drawTxt3(1.099, 0.505, 1.0,1.0,0.40 , "" .."🍹" ,255, 255, 255, 255) 

				drawRct2(0.471,0.0,0.199,0.045,0,0,0,200) 
				drawRct2(0.471,0.0,0.199,0.005,		HUD.rouge, HUD.vert, HUD.bleu,255)
			end
		end
	end
end)


local LastPress = 0
Citizen.CreateThread( function()
	while true do
		Wait( 0 )


        if IsControlPressed( 0, 82 ) then
          if PlayerData.job~= nil then
					drawTxt3(1.249, 1.453, 1.0,1.0,0.40 , PlayerData.job.label .. " - " ..  PlayerData.job.grade_label ,255, 255, 255, 255) 
          end
				end


	end
end )


function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow(0)
	SetTextOutline(0)
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end


SendNUIMessage({hud = ShowHUD})