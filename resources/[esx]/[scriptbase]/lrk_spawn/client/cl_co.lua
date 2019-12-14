ESX = nil

wait = 0

local cam = nil

local cam2 = nil

local PlayerCoords = nil



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end



end)



--RegisterNetEvent('esx:playerLoaded')

--AddEventHandler('esx:playerLoaded', function(xPlayer)

--    print("1")

--    Citizen.Wait(1000)

--    SetEntityCoords(PlayerPedId(), 436.65, -989.49, 26.67, 0.0, 0.0, 0.0, true)

--    Visible()

--end)



RegisterNetEvent('anime:base')

AddEventHandler('anime:base', function()

    print("1")

    Citizen.Wait(1000)

    SetEntityCoords(PlayerPedId(), 436.65, -989.49, 26.67, 0.0, 0.0, 0.0, true)

    Visible()

end)



local enable = false

local heading = 360.00

local signmodel = GetHashKey("prop_police_id_board")

local textmodel = GetHashKey("prop_police_id_text")

local scaleform = {}

local text = {}

local camAnim = nil

local cam2Anim = nil

local cam3 = nil

local cam4 = nil

local coords = nil

local enable = true

local SignProp1 = {}

local SignProp2 = {}

local status = true



Citizen.CreateThread(function()

    scaleform = LoadScaleform("mugshot_board_01")

    text = CreateNamedRenderTargetForModel("ID_TEXT", textmodel)

  

    while text do

        Citizen.Wait(1)

        SetTextRenderId(text) -- set render target

        Set_2dLayer(4)

        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)

        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)

        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)

        DrawScaleformMovie(scaleform, 0.40, 0.35, 0.80, 0.75, 255, 255, 255, 255, 0)

        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)

        SetTextRenderId(GetDefaultScriptRendertargetRenderId())

    end

  end)



Citizen.CreateThread(function()

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)

    while ESX == nil do

        Wait(100)

    end

    local loaded = ESX.IsPlayerLoaded()

    DoScreenFadeOut(10)

    while not IsScreenFadedOut() do

        Citizen.Wait(10)

    end

    DisplayHud(false)

    DisplayRadar(false)

    --SetTimecycleModifier('hud_def_blur')

    --FreezeEntityPosition(GetPlayerPed(-1), true)

    --SetEntityCollision(GetPlayerPed(-1), false, false)

    --NetworkSetEntityVisibleToNetwork(GetPlayerPed(-1), false)

    --SetEntityVisible(GetPlayerPed(-1), false, 0)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 3881.36, 5497.28, 441.15, 0.00,0.00,0.00, 100.00, false, 0)

    PointCamAtCoord(cam, -136.73, 2899.67, 537.09)

    SetCamActive(cam, true)

    RenderScriptCams(true, false, 1, true, true)



    while not loaded do

        loaded = ESX.IsPlayerLoaded()

        Wait(100)

    end

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)

    

    

    DoScreenFadeIn(500)

    AfficherAC("Synchronisation en cours ...", 13000)

    sync()

    Citizen.Wait(2000)

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)

    while GetNumberOfActiveBlips() < 2 do

        Wait(100)

    end

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)

    wait = 14000

    Citizen.Wait(500)

    local PlayerPed = GetPlayerPed(-1)

    PlayerCoords = GetEntityCoords(PlayerPed, true)

    TriggerEvent("anime:base")

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)



    print("2")

    local ped = PlayerPedId()

    enable = true

    Session()

    CreateCam()

    AnimationIntro()

    SpawnCharacter() 

    NetworkSetVoiceActive(false)

    NetworkSetTalkerProximity(0.0)

    Citizen.Wait(5000)

    if status == true then

        while enable == true do

            Citizen.Wait(1)

            ESX.ShowHelpNotification("Appuyer sur ~INPUT_FRONTEND_ACCEPT~ pour accéder a LaFive.")

            RequestAnimDict("mp_character_creation@customise@male_a")

            TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)

            if IsControlJustReleased(1, 201) then

                SpawnEntity()

            end

        end

    end

















end)



function Session()

    Citizen.Wait(1000)

    DoScreenFadeOut(1000)

    Citizen.Wait(10000)

    SetEntityHeading(PlayerPedId(), 350.0)

    DisplayRadar(false) 

    DoScreenFadeIn(1000)

end



RegisterNetEvent("anim:CreateSign")

AddEventHandler("anim:CreateSign", function()

    SignProp1 = CreateObject(signmodel, 1, 1, 1, false, true, false)

    SignProp2 = CreateObject(textmodel, 1, 1, 1, false, true, false)



    AttachEntityToEntity(SignProp1, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);

    AttachEntityToEntity(SignProp2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);



    local ScaleformMovie = RequestScaleformMovie("MUGSHOT_BOARD_01")



    while not HasScaleformMovieLoaded(scaleform) do

        Citizen.Wait(0)

    end

    print("load 1")

    while HasScaleformMovieLoaded(scaleform) do

        Citizen.Wait(0)

        PushScaleformMovieFunction(ScaleformMovie, "SET_BOARD")

        PushScaleformMovieFunctionParameterString("WELCOME TO")

        PushScaleformMovieFunctionParameterString("LAFIVE")

        PushScaleformMovieFunctionParameterString("LOS SANTOS POLICE DEPT")

        PushScaleformMovieFunctionParameterString("#0045")

        PushScaleformMovieFunctionParameterString(0)

        PushScaleformMovieFunctionParameterString(5)

        PushScaleformMovieFunctionParameterString(0)

        PopScaleformMovieFunctionVoid()

    end

end)





function CreateCam()

    camAnim = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 440.30, -986.15, 26.97, 0.00, 0.00, 89.75, 50.00, false, 0)

    PointCamAtCoord(camAnim, 435.549, -986.21, 27.41)

    SetCamActive(camAnim, true)

    RenderScriptCams(true, false, 2000, true, true) 

end



function AnimationIntro()

    RequestAnimDict("mp_character_creation@lineup@male_a")

    Citizen.Wait(100)

    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "intro", 1.0, 1.0, 5900, 0, 1, 0, 0, 0)

    Citizen.Wait(5700)

    TriggerEvent("anim:CreateSign")

    RequestAnimDict("mp_character_creation@customise@male_a")

    Citizen.Wait(100)

    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 1.0, 1.0, -1, 0, 1, 0, 0, 0)

end



function SpawnEntity()

    RequestAnimDict("mp_character_creation@lineup@male_a")

    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)

    Citizen.Wait(8000)

    DoScreenFadeOut(1000)

    Citizen.Wait(1000)

    DoScreenFadeIn(1000)

    SetEntityAsMissionEntity(SignProp1, 1, 1)

    SetEntityAsMissionEntity(SignProp2, 1, 1)

    DeleteObject(SignProp1)

    DeleteObject(SignProp2)

    SetEntityCoords(PlayerPedId(), PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 0.0, 0.0, 0.0, false)

----RenderScriptCams(false, true, 500, true, true)      

--

--cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerCoords.x,PlayerCoords.y,PlayerCoords.z+200, 300.00,0.00,0.00, 100.00, false, 0)

--PointCamAtCoord(cam, PlayerCoords.x,PlayerCoords.y,PlayerCoords.z+2)

--SetCamActiveWithInterp(cam, cam2Anim, 1, true, true)

--PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)

    RenderScriptCams(false, false, 1, true, true)

--PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)

    SetEntityCollision(GetPlayerPed(-1), true, true)

    NetworkSetEntityVisibleToNetwork(GetPlayerPed(-1), true)

    SetEntityVisible(GetPlayerPed(-1), true, 0)

    FreezeEntityPosition(GetPlayerPed(-1), false)

    Citizen.Wait(1500)

    SetTimecycleModifier('default')

    SetCamActive(cam, false)

    DestroyCam(cam, true)

    DisplayHud(true)

    DisplayRadar(true)

    NetworkSetVoiceActive(true)

    NetworkSetTalkerProximity(8.0)

    PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)

    enable = false

    DisplayRadar(true)

    Collision(false)

end





function SpawnCharacter()

    cam2Anim = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 439.115, -986.20, 27.55, 0.00, 0.00, 89.75, 65.00, false, 0)

    PointCamAtCoord(cam2Anim, 435.549, -986.21, 27.41)

    SetCamActiveWithInterp(cam2Anim, camAnim, 5000, true, true)

end



function Collision()

    for _, i in ipairs(GetActivePlayers()) do

        if NetworkIsPlayerActive(i) then

            SetEntityVisible(GetPlayerPed(i), false, false)

            SetEntityVisible(PlayerPedId(), true, true)

            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)

            NetworkSetVoiceActive(false)

            --NetworkSetTalkerProximity(-8.0)

        end

    end

end



function Visible()

    while enable == true do

        Citizen.Wait(0)

        Collision()

    end

end



function LoadScaleform (scaleform)

    local text = RequestScaleformMovie(scaleform)



    if text ~= 0 then

        while not HasScaleformMovieLoaded(text) do

            Citizen.Wait(0)

        end

    end



    return text

end



function CreateNamedRenderTargetForModel(name, model)

    local text = 0

    if not IsNamedRendertargetRegistered(name) then

        RegisterNamedRendertarget(name, 0)

    end

    if not IsNamedRendertargetLinked(model) then

        LinkNamedRendertarget(model)

    end

    if IsNamedRendertargetRegistered(name) then

        text = GetNamedRendertargetRenderId(name)

    end



    return text

end





function AfficherAC(text, temps)

	Citizen.CreateThread(function()

		while wait < temps do

			wait = wait + 1

			DrawAdvancedText(0.588, 0.836, 0.005, 0.0028, 0.4, text, 255, 255, 255, 255, 6, 0)

			Wait(1)

		end

		wait = 0

	end)

end





function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)

	SetTextFont(font)

	SetTextProportional(0)

	SetTextScale(sc, sc)

	N_0x4e096588b13ffeca(jus)

	SetTextColour(r, g, b, a)

	SetTextDropShadow(0, 0, 0, 0,255)

	SetTextEdge(1, 0, 0, 0, 255)

	SetTextDropShadow()

	SetTextOutline()

	SetTextEntry("STRING")

	AddTextComponentString(text)

	DrawText(x - 0.1+w, y - 0.02+h)

end