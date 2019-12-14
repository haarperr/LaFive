TriggerEvent('es:addCommand', 'litter', function(source, args, user)
	TriggerClientEvent('spawn:bed', source)
end)