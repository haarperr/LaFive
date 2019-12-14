ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local essence = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'imprimerie', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'imprimerie', _U('fueler_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'imprimerie', 'Imprimerie', 'society_imprimerie', 'society_imprimerie', 'society_imprimerie', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "PetrolFarm" then
			local itemQuantity = xPlayer.getInventoryItem('papier').count
			if itemQuantity >= 150 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1500, function()
					xPlayer.addInventoryItem('papier', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_imprimeriejob:startHarvest')
AddEventHandler('esx_imprimeriejob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('petrol_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_imprimeriejob:stopHarvest')
AddEventHandler('esx_imprimeriejob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementRaffin" then
			local itemQuantity = xPlayer.getInventoryItem('papier').count
			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_raffine'))
				return
			else
				local rand = math.random(0,100)
				if (rand >= 98) then
					SetTimeout(1500, function()
						xPlayer.removeInventoryItem('papier', 1)
						xPlayer.addInventoryItem('billet', 1)
						TriggerClientEvent('esx:showNotification', source, _U('not_enough_raffine'))
						Transform(source, zone)
					end)
				else
					SetTimeout(1500, function()
						xPlayer.removeInventoryItem('papier', 1)
						xPlayer.addInventoryItem('billet', 1)
				
						Transform(source, zone)
					end)
				end
			end
		elseif zone == "TraitementPetrol" then
			local itemQuantity = xPlayer.getInventoryItem('papier').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_petrol'))
				return
			else
				SetTimeout(1500, function()
					xPlayer.removeInventoryItem('papier', 1)
					xPlayer.addInventoryItem('billet', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end	

RegisterServerEvent('esx_imprimeriejob:startTransform')
AddEventHandler('esx_imprimeriejob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_imprimeriejob:stopTransform')
AddEventHandler('esx_imprimeriejob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre whiskey')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('billet').count <= 0 then
				essence = 0
			else
				essence = 1
			end
			
		
			if essence == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('billet').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_fuel_sale'))
				essence = 0
				return
			else
				if (essence == 1) then
					SetTimeout(1500, function()
						local money = math.random(50,55)
						local argent = math.random(45,50)
						xPlayer.removeInventoryItem('billet', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_imprimerie', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
						
							xPlayer.addMoney(argent)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_imprimeriejob:startSell')
AddEventHandler('esx_imprimeriejob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_imprimeriejob:stopSell')
AddEventHandler('esx_imprimeriejob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_imprimeriejob:getStockItem')
AddEventHandler('esx_imprimeriejob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_imprimerie', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_imprimeriejob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_imprimerie', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_imprimeriejob:putStockItems')
AddEventHandler('esx_imprimeriejob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_imprimerie', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_imprimeriejob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)
