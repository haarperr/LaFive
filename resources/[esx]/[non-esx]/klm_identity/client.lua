ESX = nil
clotheshop = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)
function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Identité", "~b~NOUVELLE IDENTITE")
_menuPool:Add(mainMenu)

function AddMenuIdentityMenu(menu)
    
    local nameItem = NativeUI.CreateItem('Nom :', "Déterminer votre prenom.")
    menu:AddItem(nameItem)
    local prenameItem = NativeUI.CreateItem('Prénom :', "Déterminer votre nom.")
    menu:AddItem(prenameItem)
    local ageItem = NativeUI.CreateItem('Age :', "Déterminer votre age.")
    menu:AddItem(ageItem)
    local birdItem = NativeUI.CreateItem('Date de naissance :', "Déterminer votre date de naissance.")
    menu:AddItem(birdItem)
    
    menu.OnItemSelect = function(_, item, _)
        if item == nameItem then
			local Username = KeyboardInput('Name:', 'Input Your Username', 20)

			if Username ~= nil then
				Username = tostring(Username)

				if type(Username) == 'string' then
					print('yes')
				end
			end
        elseif item == prenameItem then
             local prenom = KeyboardInput("Prénom :", "", 10)
        elseif item == ageItem then
            local age = KeyboardInput("Age :", "", 2)
        elseif item == birdItem then
             local dated = KeyboardInput("Date de naissance :", "", 8)
        end
    end
end

function AddMenuSaveMenu(menu)
	
	local Description = "Sauvegarder et Continuer"
	local Select = NativeUI.CreateColouredItem("Accepter", Description, Colours.BlueDark, Colours.BlueDark)
	menu:AddItem(Select)

    menu.OnItemSelect = function(menu, item)
		if item == Select then
			TriggerServerEvent('esx_skin:save', Character)
			TriggerEvent('skinchanger:loadSkin', Character)
			_menuPool:CloseAllMenus(true)
		end
	end
end

AddMenuIdentityMenu(mainMenu)
AddMenuSaveMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		_menuPool:ProcessMenus()
		_menuPool:MouseControlsEnabled(true)
        if IsControlJustPressed(1, 345) then
           mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)