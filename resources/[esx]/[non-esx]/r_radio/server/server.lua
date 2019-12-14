local voip = {}
RegisterNetEvent('r_radio:ToggleRadio')
AddEventHandler('r_radio:ToggleRadio', function(freq,checked)
	for i = 1, #voip,1 do
		if voip[i].freq == freq then
			TriggerClientEvent("r_radio:mute",source,checked,voip[i].source)
		end
	end
end)
RegisterNetEvent('r_radio:SetFreq')
AddEventHandler('r_radio:SetFreq', function(freq)
	local found = true
	local k = 0
	for i = 1, #voip,1 do
		if voip[i].source == source then
			found = false
			k = i
			for p = 1, #voip,1 do
				TriggerClientEvent("r_radio:SyncRadio",voip[p].source,voip,false)
			end
			break
		end
	end
	if found then
		table.insert(voip,{source=source, freq=freq}) 
	else 
		voip[k].freq = freq
	end
	for i = 1, #voip,1 do
		if voip[i].freq == freq then
			TriggerClientEvent("r_radio:SyncRadio",voip[i].source,voip,true)
		end
	end
end)
function SyncRadio()


	TriggerClientEvent("r_radio:SyncRadio2",-1,voip)
	SetTimeout(5000, SyncRadio)
end

SyncRadio()
