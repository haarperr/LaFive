

local menuEnabled = false

RegisterNetEvent("ToggleActionmenu")
AddEventHandler("ToggleActionmenu", function()
	ToggleActionMenu()
end)

function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showPlayerMenu = true
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end
end

function killTutorialMenu()
		SetNuiFocus( false, false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end

RegisterNetEvent("kuana:senddatawallet")
AddEventHandler("kuana:senddatawallet", function(nome, unome, datad, altura, sexo, mo, cam, ca, item, idcard)
	local nometotal = nome.." "..unome
	SetNuiFocus( true, true )
	SendNUIMessage({
			showPlayerMenu = true,
			nomeh = nometotal,
			nome1 = nome,
			nome2 = unome,
			datadh = datad,
			altura = altura,
			sexo = sexo,
			mota = mo,
			camiao = cam,
			carro = ca,
			armas = item,
			nidcard = idcard
	})
end)

RegisterNUICallback('close', function(data, cb)
  ToggleActionMenu()
  cb('ok')
end)


function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
