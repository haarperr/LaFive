
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("AC:Sync")
end)

for i=1, #eventsAdmin, 1 do
	AddEventHandler(eventsAdmin[i], function()
		TriggerServerEvent('AC:AdminDetected', eventsAdmin[i])
	end)
end


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local avert = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		local curPed = PlayerPedId()
		local curHealth = GetEntityHealth( curPed )
		SetEntityHealth( curPed, curHealth-2)
		local curWait = math.random(10,150)

		Citizen.Wait(curWait)

		if not IsPlayerDead(PlayerId()) then
			if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
				avert = avert + 1
			elseif GetEntityHealth(curPed) == curHealth-2 then
				SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
			elseif GetEntityHealth(curPed) > 201 then
				TriggerServerEvent("AC:GodModDetected")
			end
		end

		if avert == 5 then
			TriggerServerEvent("AC:TropDeDetection", 5)
		elseif avert == 10 then
			TriggerServerEvent("AC:TropDeDetection", 10)	
		elseif avert == 15 then
			TriggerServerEvent("AC:TropDeDetection", 15)
		elseif avert == 20 then
			TriggerServerEvent("AC:TropDeDetection", 20)
		elseif avert == 25 then
			TriggerServerEvent("AC:TropDeDetection", 25)
		elseif avert == 30 then
			TriggerServerEvent("AC:TropDeDetection", 30)
		end

	end

end)


-- Detection si le joueurs est dans un véhicule de police
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
     	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local ped = GetPlayerPed(-1)
		local vehicleClass = GetVehicleClass(vehicle)
		PlayerData = ESX.GetPlayerData()
		
		if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == ped then
			if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' and PlayerData.job.name ~= 'sheriff' then
				ClearPedTasksImmediately(ped)
				TaskLeaveVehicle(ped,vehicle,0)
				TriggerServerEvent("AC:PoliceVehicule")
			end
		end
	end
end)
--]]
-- Fin de la détection pour les véhicules

for i=1, #events, 1 do
	AddEventHandler(events[i], function()
		TriggerServerEvent('AC:injectionDetected', events[i])
	end)
end

--Blocks injectors "isis explosion" "explode player" etc (A TEST)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetWeaponDamageModifier(539292904, 0.0)
    end
end)

-- CONFIG --


-- FPS BOOST 

Citizen.CreateThread(function()
	--Wait(2*60000) -- Delay first spawn.
	while true do
		ClearAllBrokenGlass()
		ClearAllHelpMessages()
		LeaderboardsReadClearAll()
		ClearBrief()
		ClearGpsFlags()
		ClearPrints()
		ClearSmallPrints()
		ClearReplayStats()
		LeaderboardsClearCacheData()
		ClearFocus()
		ClearHdArea()
		print("^1LaFive ANTI CHEAT\n^3Analyse terminer\n^3Debug props effectué")
		Wait(1*60000)
	end
end)

local armeBlackList = {
	"WEAPON_RAYMINIGUN",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYPISTOL",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_STICKYBOMB",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_FIREWORK",
	"WEAPON_MINIGUN",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_FLARE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PROXMINE",
}

Citizen.CreateThread(function()
	while true do
		Wait(10)
		local playerPed = GetPlayerPed(-1)
		if playerPed then
			local arme = GetSelectedPedWeapon(playerPed)
			if ArmeDeModdeur(arme) then
				RemoveWeaponFromPed(playerPed, arme)
				RemoveAllPedWeapons(playerPed, 1)
			end
		end
	end
end)

function ArmeDeModdeur(model)
	for _, blacklistedWeapon in pairs(armeBlackList) do
		if model == GetHashKey(blacklistedWeapon) then
			RemoveAllPedWeapons(playerPed, 1)
			return true
		end
	end

	return false
end

ObjectsBL = {
		"stt_prop_ramp_spiral_xxl", 
        "stt_prop_ramp_spiral_s", 
        "stt_prop_ramp_spiral_m", 
        "stt_prop_ramp_spiral_l_xxl", 
        "stt_prop_ramp_spiral_l_s", 
        "stt_prop_ramp_spiral_l_m", 
        "stt_prop_ramp_spiral_l_l", 
        "stt_prop_ramp_spiral_l", 
        "stt_prop_stunt_bblock_qp3", 
        "stt_prop_stunt_bblock_xl3", 
        "stt_prop_stunt_jump15", 
        "stt_prop_stunt_jump30", 
        "stt_prop_stunt_jump45", 
        "stt_prop_stunt_jump_loop", 
        "stt_prop_stunt_landing_zone_01", 
        "stt_prop_stunt_track_bumps", 
        "stt_prop_stunt_track_cutout", 
        "stt_prop_stunt_track_dwlink", 
        "stt_prop_stunt_track_dwlink_02", 
        "stt_prop_stunt_track_dwsh15", 
        "stt_prop_stunt_track_dwshort", 
        "stt_prop_stunt_track_dwslope15", 
        "stt_prop_stunt_track_dwslope30", 
        "stt_prop_stunt_track_dwslope45", 
        "stt_prop_stunt_track_dwturn", 
        "stt_prop_stunt_track_dwuturn", 
        "stt_prop_stunt_track_exshort", 
        "stt_prop_stunt_track_fork", 
        "stt_prop_stunt_track_funlng", 
        "stt_prop_stunt_track_funnel", 
        "stt_prop_stunt_track_hill", 
        "stt_prop_stunt_track_hill2", 
        "stt_prop_stunt_track_jump", 
        "stt_prop_stunt_track_link", 
        "stt_prop_stunt_track_otake", 
        "stt_prop_stunt_track_sh15", 
        "stt_prop_stunt_track_sh30", 
        "stt_prop_stunt_track_sh45", 
        "stt_prop_stunt_track_sh45_a", 
        "stt_prop_stunt_track_short", 
        "stt_prop_stunt_track_slope15",
        "stt_prop_stunt_track_slope30", 
        "stt_prop_stunt_track_slope45", 
        "stt_prop_stunt_track_st_01", 
        "stt_prop_stunt_track_st_02", 
        "stt_prop_stunt_track_start", 
        "stt_prop_stunt_track_start_02", 
        "stt_prop_stunt_track_straight", 
        "stt_prop_stunt_track_straightice", 
        "stt_prop_stunt_track_turn", 
        "stt_prop_stunt_track_turnice", 
        "stt_prop_stunt_track_uturn", 
        "stt_prop_stunt_tube_crn", 
        "stt_prop_stunt_tube_crn2", 
        "stt_prop_stunt_tube_crn_15d",
        "stt_prop_stunt_tube_crn_30d", 
        "stt_prop_stunt_tube_crn_5d", 
        "stt_prop_stunt_tube_cross", 
        "stt_prop_stunt_tube_end", 
        "stt_prop_stunt_tube_ent", 
        "stt_prop_stunt_tube_fn_01", 
        "stt_prop_stunt_tube_fn_02", 
        "stt_prop_stunt_tube_fn_03", 
        "stt_prop_stunt_tube_fn_04", 
        "stt_prop_stunt_tube_fn_05", 
        "stt_prop_stunt_tube_fork", 
        "stt_prop_stunt_tube_gap_01", 
        "stt_prop_stunt_tube_gap_02", 
        "stt_prop_stunt_tube_gap_03", 
        "stt_prop_stunt_tube_hg", 
        "stt_prop_stunt_tube_jmp", 
        "stt_prop_stunt_tube_jmp2", 
        "stt_prop_stunt_tube_l", 
        "stt_prop_stunt_tube_m",
        "stt_prop_stunt_tube_qg", 
        "stt_prop_stunt_tube_s", 
        "stt_prop_stunt_tube_speed", 
        "stt_prop_stunt_tube_speeda", 
        "stt_prop_stunt_tube_speedb", 
        "stt_prop_stunt_tube_xs", 
        "stt_prop_stunt_tube_xxs", 
        "stt_prop_track_tube_02", 
        "stt_prop_track_tube_01", 
        "stt_prop_stunt_track_dwslope30", 
        "stt_prop_stunt_track_slope45", 
        "stt_prop_stunt_track_dwslope45", 
        "stt_prop_stunt_track_slope15", 
        "stt_prop_stunt_track_slope30", 
        "prop_mp_ramp_01", 
        "stt_prop_stunt_track_dwslope15", 
        "prop_mp_ramp_01_tu", 
        "prop_mp_ramp_02", 
        "prop_mp_ramp_02_tu", 
        "prop_mp_ramp_03", 
        "prop_mp_ramp_03_tu", 
        "prop_mp_repair", 
        "prop_rock_4_a", 
        "prop_rock_4_b", 
        "prop_rock_4_big", 
        "prop_rock_4_big2", 
        "prop_rock_4_c", 
        "prop_rock_4_c_2", 
        "prop_rock_4_cl_1", 
        "prop_skate_flatramp_cr", 
        "prop_skate_funbox_cr", 
        "prop_skate_halfpipe_cr", 
        "prop_skate_kickers_cr", 
        "prop_skate_quartpipe_cr", 
        "prop_skate_spiner_cr", 
        "stt_prop_race_start_line_01", 
        "stt_prop_race_start_line_01b", 
        "stt_prop_race_start_line_02", 
        "stt_prop_race_start_line_02b", 
        "stt_prop_race_start_line_03", 
        "stt_prop_race_start_line_03b", 
        "stt_prop_ramp_adj_flip_m", 
        "stt_prop_ramp_adj_flip_mb", 
        "stt_prop_ramp_adj_flip_s", 
        "stt_prop_ramp_adj_hloop", 
        "stt_prop_ramp_adj_loop", 
        "stt_prop_stunt_bblock_huge_01", 
        "stt_prop_stunt_bblock_huge_02", 
        "stt_prop_stunt_bblock_huge_03", 
        "stt_prop_stunt_bblock_huge_04", 
        "stt_prop_stunt_bblock_huge_05", 
        "stt_prop_stunt_bblock_hump_01", 
        "stt_prop_stunt_bblock_hump_02", 
        "stt_prop_stunt_bblock_qp", 
        "stt_prop_stunt_bblock_qp2", 
        "stt_prop_stunt_bblock_qp3", 
        "stt_prop_stunt_landing_zone_01", 
        "stt_prop_stunt_track_dwslope15", 
        "stt_prop_stunt_track_dwslope30", 
        "stt_prop_stunt_track_dwslope45", 
        "stt_prop_stunt_track_dwturn", 
        "stt_prop_stunt_track_dwuturn", 
        "stt_prop_stunt_track_exshort", 
        "stt_prop_stunt_track_fork", 
        "stt_prop_stunt_track_funlng", 
        "stt_prop_stunt_track_funnel", 
        "stt_prop_stunt_track_hill", 
        "stt_prop_stunt_track_hill2", 
        "stt_prop_stunt_track_jump", 
        "stt_prop_stunt_track_link", 
        "stt_prop_stunt_track_otake", 
        "stt_prop_stunt_track_sh15", 
        "stt_prop_stunt_track_sh30", 
        "stt_prop_stunt_track_sh45", 
        "stt_prop_stunt_track_sh45_a", 
        "stt_prop_stunt_track_short", 
        "stt_prop_stunt_track_slope15", 
        "stt_prop_stunt_track_st_02", 
        "stt_prop_stunt_track_st_01", 
        "prop_med_jet_01", 
        "prop_dog_cage_01", 
        "prop_dog_cage_02", 
        "prop_contr_03b_ld", 
        "prop_container_old1", 
        "prop_container_ld_pu", 
        "prop_container_ld_d", 
        "prop_container_ld2", 
        "prop_container_hole", 
        "prop_container_ld", 
        "prop_container_05a", 
        "prop_container_03mb", 
        "prop_container_03b", 
        "prop_container_03_ld", 
        "prop_container_01mb", 
        "prop_asteroid_01", 
        "p_tram_crash_s", 
        "p_spinning_anus_s", 
        "p_med_jet_01_s", 
        "p_cs_mp_jet_01_s", 
        "hei_prop_heist_tug", 
        "hei_prop_carrier_jet", 
        "prop_gascage01", 
        "hei_prop_carrier_radar_1_l1",
        "v_res_mexball", 
        "prop_rock_1_a", 
        "prop_rock_1_b", 
        "prop_rock_1_c", 
        "prop_rock_1_d", 
        "prop_rock_1_e", 
        "prop_rock_1_f", 
        "prop_rock_1_g", 
        "prop_rock_1_h", 
        "prop_test_boulder_01", 
        "prop_test_boulder_02", 
        "prop_test_boulder_03", 
        "prop_test_boulder_04", 
        "apa_mp_apa_crashed_usaf_01a", 
        "ex_prop_exec_crashdp", 
        "apa_mp_apa_yacht_o1_rail_a", 
        "apa_mp_apa_yacht_o1_rail_b", 
        "apa_mp_h_yacht_armchair_01", 
        "apa_mp_h_yacht_armchair_03", 
        "apa_mp_h_yacht_armchair_04", 
        "apa_mp_h_yacht_barstool_01", 
        "apa_mp_h_yacht_bed_01", 
        "apa_mp_h_yacht_bed_02", 
        "apa_mp_h_yacht_coffee_table_01", 
        "apa_mp_h_yacht_coffee_table_02", 
        "apa_mp_h_yacht_floor_lamp_01", 
        "apa_mp_h_yacht_side_table_01", 
        "apa_mp_h_yacht_side_table_02", 
        "apa_mp_h_yacht_sofa_01", 
        "apa_mp_h_yacht_sofa_02", 
        "apa_mp_h_yacht_stool_01", 
        "apa_mp_h_yacht_strip_chair_01", 
        "apa_mp_h_yacht_table_lamp_01", 
        "apa_mp_h_yacht_table_lamp_02", 
        "apa_mp_h_yacht_table_lamp_03", 
        "prop_flag_columbia", 
        "apa_mp_apa_yacht_o2_rail_a",
        "apa_mp_apa_yacht_o2_rail_b", 
        "apa_mp_apa_yacht_o3_rail_a", 
        "apa_mp_apa_yacht_o3_rail_b", 
        "apa_mp_apa_yacht_option1", 
        "proc_searock_01", 
        "apa_mp_h_yacht_", 
        "apa_mp_apa_yacht_option1_cola", 
        "apa_mp_apa_yacht_option2", 
        "apa_mp_apa_yacht_option2_cola", 
        "apa_mp_apa_yacht_option2_colb", 
        "apa_mp_apa_yacht_option3", 
        "apa_mp_apa_yacht_option3_cola", 
        "apa_mp_apa_yacht_option3_colb", 
        "apa_mp_apa_yacht_option3_colc", 
        "apa_mp_apa_yacht_option3_cold", 
        "apa_mp_apa_yacht_option3_cole", 
        "prop_crashed_heli", 
        "prop_shamal_crash", 
        "xm_prop_x17_shamal_crash", 
        "prop_planer_01", 
        "v_44_planeticket", 
        "prop_mk_plane", 
        "prop_dummy_plane", 
        "hei_prop_hei_pic_pb_plane", 
        "ch3_12_animplane2_lod", 
        "ch3_12_animplane1_lod", 
        "mp_player_int_rock", 
        "mp_player_introck", 
        "maverick", 
        "Miljet", 
        "proc_stones_01", 
        "proc_stones_02", 
        "proc_stones_03", 
        "stt_prop_stunt_soccer_ball", 
        "stt_prop_stunt_track_dwuturn", 
        "stt_prop_stunt_tube_l", 
        "p_cablecar_s",
        "cs_x_rubweec", 
        "cs_x_rubweed", 
        "cs_x_rubweee", 
        "cs_x_weesmlb", 
        "cs_x_rubweea",
        "prop_cs_plane_int_01", 
        "prop_cs_crisps_01", 
        "prop_cs_credit_card", 
        "prop_tool_box_01", 
        "prop_roadcone02a", 
        "prop_ld_health_pack", 
        "prop_cs_shopping_bag",
        "prop_gun_case_01", 
        "prop_ecola_can", 
        "p_amb_coffeecup_01", 
        "prop_ld_flow_bottle", 
        "prop_cs_burger_01", 
        "prop_cs_cuffs_01", 
        "p_cs_cuffs_02_s", 
        "prop_acc_guitar_01", 
        "stt_prop_stunt_track_start", 
        "prop_gold_cont_01", 
        "p_crahsed_heli_s", 
        "prop_rock_4_big2", 
        "prop_beachflag_le", 
        "prop_fnclink_05crnr1", 
        "xs_prop_hamburgher_wl", 
        "sr_prop_spec_tube_xxs_01a", 
        "cargoplane", 
        "prop_beach_fire"
	}

    function ReqAndDelete(object, detach)
        if DoesEntityExist(object) then
            NetworkRequestControlOfEntity(object)
            while not NetworkHasControlOfEntity(object) do
                Citizen.Wait(1)
            end
            if detach then
                DetachEntity(object, 0, false)
            end
            SetEntityCollision(object, false, false)
            SetEntityAlpha(object, 0.0, true)
            SetEntityAsMissionEntity(object, true, true)
            SetEntityAsNoLongerNeeded(object)
            DeleteEntity(object)
        end
    end

-- BLACKLISTED OBJECT CHECK
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			if IsEntityAttached(object) and DoesEntityExist(object) then
				if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
					ReqAndDelete(object, true)
				end
			end
			for i=1,#ObjectsBL do
				if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
					ReqAndDelete(object, false)
				end
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
                TriggerEvent('esx:showAdvancedStreamedNotification', 'LaFive', 'Top-serveur', 'Gagnez plus de 2000$ et une chance de gagner un véhicule moddé. !vote sur discord pour voter', 'CHAR_FLOYD', 'lafive', 8)
                Citizen.Wait(5 * 60000)
    end
end)
