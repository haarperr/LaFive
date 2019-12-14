local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX = nil

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu('Pôle emplois', "Bienvenue au pole emplois!")
_menuPool:Add(mainMenu)

function AddMenuJobMenu(menu)

        local submenu = _menuPool:AddSubMenu(menu, "Pôle emplois : ~g~Metiers non WL", "", Config.MenuX, Config.MenuY,nil,nil,nil,Config.MenuColor.r,Config.MenuColor.g,Config.MenuColor.b,Config.MenuColor.a, 5, 50)
	
	    local minerjob = NativeUI.CreateItem("Mineur", "")

        submenu.SubMenu:AddItem(minerjob)
		
		local fishermanjob = NativeUI.CreateItem("Pêcheur", "")
		
		submenu.SubMenu:AddItem(fishermanjob)
		
		local fuelerjob = NativeUI.CreateItem("Raffineur", "")
		
		submenu.SubMenu:AddItem(fuelerjob)
		
	--	local garbagejob = NativeUI.CreateItem("Éboueur", "")
		
	--	submenu.SubMenu:AddItem(garbagejob)
	
		local lumberjackjob = NativeUI.CreateItem("Bûcheron", "")
		
		submenu.SubMenu:AddItem(lumberjackjob)
		
		local slaughtererjob = NativeUI.CreateItem("Abatteur", "")
		
		submenu.SubMenu:AddItem(slaughtererjob)
		
		local tailorjob = NativeUI.CreateItem("Couturier", "")
		
		submenu.SubMenu:AddItem(tailorjob)
	
		--local truckerjob = NativeUI.CreateItem("Chauffeur", "")
		
		--submenu.SubMenu:AddItem(truckerjob)
		
		submenu.SubMenu.OnItemSelect = function(menu, item)
		
		if item == minerjob then
		    TriggerServerEvent('esx_joblisting:setJobMiner')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == fishermanjob then
		    TriggerServerEvent('esx_joblisting:setJobFisherMan')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == fuelerjob then
		    TriggerServerEvent('esx_joblisting:setJobFueler')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == garbagejob then
		    TriggerServerEvent('esx_joblisting:setJobGarbage')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == lumberjackjob then
		    TriggerServerEvent('esx_joblisting:setJobLumberJack')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == slaughtererjob then
		    TriggerServerEvent('esx_joblisting:setJobAbatteur')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == tailorjob then
		    TriggerServerEvent('esx_joblisting:setJobTailor')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
		if item == truckerjob then
		    TriggerServerEvent('esx_joblisting:setJobTrucker')
			ESX.ShowNotification('Voici votre nouveau job!')
		end
	end
end

AddMenuJobMenu(mainMenu)
_menuPool:MouseEdgeEnabled (false);
_menuPool:MouseControlsEnabled (false);
_menuPool:ControlDisablingEnabled(false);
_menuPool:RefreshIndex()
