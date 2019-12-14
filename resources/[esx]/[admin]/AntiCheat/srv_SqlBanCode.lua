RegisterServerEvent('RubyAntiCheat:Ban')
AddEventHandler('RubyAntiCheat:Ban', function(source, id, duree, raison)
	local identifier
	local license
	local liveid    = "no info"
	local xblid     = "no info"
	local discord   = "no info"
	local playerip
	local target    = id
	local duree     = 0
	local reason    = raison
	local permanent = 0

	if target and target > 0 then
		local ping = GetPlayerPing(target)
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = source
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
					end
			
				if duree > 0 then
					ban(source,identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
					DropPlayer(target, Text.yourban .. reason)
					--TriggerEvent("esx:banhammer",targetplayername,sourceplayername,reason,duree)
				else
					local permanent = 1
					ban(source,identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
					DropPlayer(target, Text.yourpermban .. reason)
					--TriggerEvent("esx:banhammer",targetplayername,sourceplayername,reason,'perma')
				end
			
			else
				TriggerEvent('bansql:sendMessage', source, Text.invalidtime)
			end	
		else
			TriggerEvent('bansql:sendMessage', source, Text.invalidid)
		end
	else
		TriggerEvent('bansql:sendMessage', source, Text.invalidid)
	end
end)