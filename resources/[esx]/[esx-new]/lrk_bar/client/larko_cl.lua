local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","BlueHole", nil, nil, "shopui_title_liquorstore3", "shopui_title_liquorstore3")
_menuPool:Add(mainMenu)

function AddShopsMenu(menu)
    local shopsmenu = _menuPool:AddSubMenu(menu, "Boissons", nil, nil, "shopui_title_liquorstore3", "shopui_title_liquorstore3")
    
  --  local shopsmenu2 = _menuPool:AddSubMenu(menu, "Nourriture", nil, nil, "shopui_title_liquorstore3", "shopui_title_liquorstore3")

    local eau = NativeUI.CreateItem("Eau", "")
    shopsmenu.SubMenu:AddItem(eau)
    eau:RightLabel("~g~20$")

    local chocolat = NativeUI.CreateItem("Chocolat", "")
    shopsmenu.SubMenu:AddItem(chocolat)
    chocolat:RightLabel("~g~40$")

    local cocacola = NativeUI.CreateItem("Coca-Cola", "")
    shopsmenu.SubMenu:AddItem(cocacola)
    cocacola:RightLabel("~g~30$")

    local icetea = NativeUI.CreateItem("IceTea", "")
    shopsmenu.SubMenu:AddItem(icetea)
    icetea:RightLabel("~g~30$")

    local coffe = NativeUI.CreateItem("Café", "")
    shopsmenu.SubMenu:AddItem(coffe)
    coffe:RightLabel("~g~10$")

    local milk = NativeUI.CreateItem("Lait", "")
    shopsmenu.SubMenu:AddItem(milk)
    milk:RightLabel("~g~15$")

    local alcool = NativeUI.CreateItem("Alcool", "")
    shopsmenu.SubMenu:AddItem(alcool)
    alcool:RightLabel("~g~20$")

   -- local pain = NativeUI.CreateItem("Pain", "")
  --  shopsmenu2.SubMenu:AddItem(pain)
  --  pain:RightLabel("~g~20$")

    --local sandwich = NativeUI.CreateItem("Sandwich", "")
  --  shopsmenu2.SubMenu:AddItem(sandwich)
  --  sandwich:RightLabel("~g~35$")

   -- local hamburger = NativeUI.CreateItem("Hamburger", "")
   -- shopsmenu2.SubMenu:AddItem(hamburger)
   -- hamburger:RightLabel("~g~30$")

 --   local cupcake = NativeUI.CreateItem("CupCake", "")
   -- shopsmenu2.SubMenu:AddItem(cupcake)
   -- cupcake:RightLabel("~g~30$")

  --  local gps = NativeUI.CreateItem("GPS", "")
 --   gpsmenu.SubMenu:AddItem(gps)
 --   gps:RightLabel("~g~250$")

   -- local tel = NativeUI.CreateItem("Télephone", "")
   -- gpsmenu.SubMenu:AddItem(tel)
  --  tel:RightLabel("~g~500$")

  --  local sim = NativeUI.CreateItem("Carte SIM", "")
  --  gpsmenu.SubMenu:AddItem(sim)
  --  sim:RightLabel("~g~75$")


    shopsmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == eau then
            TriggerServerEvent('buyEau')
            ESX.ShowNotification('Vous avez payez ~r~20$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter de l'~b~eau", "", "CHAR_LAZLOW2", 1)
        elseif item == chocolat then
            TriggerServerEvent('buyChocolat')
            ESX.ShowNotification('Vous avez payez ~r~40$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter du ~b~chocolat", "", "CHAR_LAZLOW2", 1)
        elseif item == cocacola then
            TriggerServerEvent('buyCocaCola')
            ESX.ShowNotification('Vous avez payez ~r~30$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter une bouteille de ~b~Coca-Cola", "", "CHAR_LAZLOW2", 1)
        elseif item == icetea then
            TriggerServerEvent('buyIceTea')
            ESX.ShowNotification('Vous avez payez ~r~30$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter une bouteille d'~b~iceTea", "", "CHAR_LAZLOW2", 1)
        elseif item == coffe then
            TriggerServerEvent('buyCafe')
            ESX.ShowNotification('Vous avez payez ~r~10$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter un ~b~Café", "", "CHAR_LAZLOW2", 1)
        elseif item == alcool then
            TriggerServerEvent('buyAlcool')
            ESX.ShowNotification('Vous avez payez ~r~10$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter de l'alcool", "", "CHAR_LAZLOW2", 1)
        elseif item == milk then
            TriggerServerEvent('buyLait')
            ESX.ShowNotification('Vous avez payez ~r~15$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter du ~b~Lait", "", "CHAR_LAZLOW2", 1)
        end
    end
end
    
    --shopsmenu2.SubMenu.OnItemSelect = function(menu, item)
   -- if item == pain then
   --         TriggerServerEvent('buyPain')
   --         ESX.ShowNotification('Vous avez payez ~r~20$')
  --          Citizen.Wait(1)
  --          ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter du ~b~pain", "", "CHAR_LAZLOW2", 1)
--   elseif item == sandwich then
--           TriggerServerEvent('buySandwich')
--           ESX.ShowNotification('Vous avez payez ~r~35$')
--           Citizen.Wait(1)
--           ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter un ~b~sandwich", "", "CHAR_LAZLOW2", 1)
--   elseif item == hamburger then
--           TriggerServerEvent('buyHamburger')
--           ESX.ShowNotification('Vous avez payez ~r~30$')
--           Citizen.Wait(1)
--           ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter un ~b~hamburger", "", "CHAR_LAZLOW2", 1)
--   elseif item == cupcake then
--           TriggerServerEvent('buyCupCake')
--           ESX.ShowNotification('Vous avez payez ~r~35$')
--           Citizen.Wait(1)
--           ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter un ~b~CupCake", "", "CHAR_LAZLOW2", 1)
    --end
--end

--    gpsmenu.SubMenu.OnItemSelect = function(menu, item)
--    if item == gps then
--            TriggerServerEvent('buyGPS')
--            ESX.ShowNotification('Vous avez payez ~r~75$')
--            Citizen.Wait(1)
--            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter un ~b~GPS", "", "CHAR_LAZLOW2", 1)
--    elseif item == tel then
--            TriggerServerEvent('buyTEL')
--            ESX.ShowNotification('Vous avez payez ~r~250$')
--            Citizen.Wait(1)
--            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter une ~b~Télephone", "", "CHAR_LAZLOW2", 1)
--    elseif item == sim then
--            TriggerServerEvent('buySIM')
--            ESX.ShowNotification('Vous avez payez ~r~45$')
--            Citizen.Wait(1)
--            ESX.ShowAdvancedNotification("BlueHole", "Vous avez acheter une ~b~Carte SIM", "", "CHAR_LAZLOW2", 1)
--        end
--    end
--end



AddShopsMenu(mainMenu)
_menuPool:RefreshIndex()

local zikoz = {
    {x = -160.55, y = -1344.2, z = 29.0},
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(zikoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, zikoz[k].x, zikoz[k].y, zikoz[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour discuter avec le ~b~serveur")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local blips = {
    {title="BlueHole", colour=3, id=358, x = -160.55, y = -1344.2, z = 29.0}

}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)
