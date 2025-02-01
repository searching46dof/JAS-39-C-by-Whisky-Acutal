----------------------------------------------------------------------------------------
-- Deka WIP Functions
----------------------------------------------------------------------------------------
local function add_aircraft_prop()
    acprop = {
        { id = "LaserCode100", control = 'spinbox',  label = _('Laser code for ordnance, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
        { id = "LaserCode10",  control = 'spinbox',  label = _('Laser code for ordnance, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
        { id = "LaserCode1",   control = 'spinbox',  label = _('Laser code for ordnance, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
        { id = "AARProbe",     control = 'checkbox', label = _('Remove AAR Probe'),              defValue = false, weight = 0, arg = 901, playerOnly = true},
    }

    return acprop
end

local mech_anime = make_default_mech_animation()
mech_anime["ServiceHatches"] = {
    {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 30.0}}}, {C = {{"Arg", 24, "set", 1.0}}}}},
    {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 5.0}}},  {C = {{"Arg", 24, "set", 0.0}}}}},
}
mech_anime["CrewLadder"] = {
    {Transition = {"Dismantle", "Erect"}, Sequence = {
        {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
        {C = {{"Arg", 499, "set", 1.0}}},
        {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
    }},
    {Transition = {"Erect", "Dismantle"}, Sequence = {
        {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
        {C = {{"Arg", 499, "set", 0.0}}},
        {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
    }},
}

mech_anime["Door0"] = {
    {Transition = {"Close", "Open"},   Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 9.0},},},}, Flags = {"Reversible"},},
    {Transition = {"Open", "Close"},   Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 6.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
    --{Transition = {"Open", "Taxi"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
    --{Transition = {"Taxi", "Open"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
    {Transition = {"Open", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 993, "set", 1.0},},},},},
    {Transition = {"Taxi", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 993, "set", 1.0},},},},},
    {Transition = {"Any", "Bailout"},  Sequence = {{C = {{"Origin", "x", 3.458, "y", 0.703, "z", 0.0}, {"Impulse", 1, "tertiary", 1.0}, {"Impulse", 2, "tertiary", 10.5}, {"Sleep", "for", 0.005},},}, {C = {{"Arg", 993, "set", 1.0},},},},},
}

----------------------------------------------------------------------------------------
-- JF-39
----------------------------------------------------------------------------------------
--mount_vfs_model_path (current_mod_path .. '/Shapes/JF-17')
--mount_vfs_texture_path (current_mod_path .. '/Textures/JF-17')

local wheel_touch_comp = 0.02

-- WOLALIGHT_STROBES          = 1
-- WOLALIGHT_SPOTS            = 2
-- WOLALIGHT_LANDING_LIGHTS   = 2
-- WOLALIGHT_NAVLIGHTS        = 3
-- WOLALIGHT_FORMATION_LIGHTS = 4
-- WOLALIGHT_TIPS_LIGHTS      = 5
-- WOLALIGHT_TAXI_LIGHTS      = 6
-- WOLALIGHT_BEACONS          = 7
-- WOLALIGHT_CABIN_BOARDING   = 8
-- WOLALIGHT_CABIN_NIGHT      = 9
-- WOLALIGHT_REFUEL_LIGHTS    = 10
-- WOLALIGHT_PROJECTORS       = 11
-- WOLALIGHT_AUX_LIGHTS       = 12
-- WOLALIGHT_IR_FORMATION     = 13

local WOLALIGHT_CUSTOM_NAV    = WOLALIGHT_IR_FORMATION + 1
local WOLALIGHT_CUSTOM_ANTI   = WOLALIGHT_CUSTOM_NAV + 1

JF_17 = {
    Name             = 'JF-17',
    DisplayName      = _('JAS-39-C'),
    Picture          = 'jf39.png',
    Rate             = 50, -- RewardPoint in Multiplayer
    Shape            = 'jas39gripen',
    shape_table_data = {
        {
            file        = 'jas39gripen',
            life        = 18, -- lifebar
            vis         = 3, -- visibility gain.
            desrt       = 'JAS39Gripen-oblomok', -- Name of destroyed object file name
            fire        = {300, 2}, -- Fire on the ground after destoyed: 300sec 2m
            username    = 'JF-17',
            index       = WSTYPE_PLACEHOLDER,
            classname   = "lLandPlane",
            positioning = "BYNORMAL",
        },
        {
            name = "JAS39Gripen-oblomok",
            file = "JAS39Gripen-oblomok",
            fire = {240, 2},
        },
    },

    -------------------------
    mapclasskey = "P0091000024",
    WorldID     = WSTYPE_PLACEHOLDER,
    attribute   = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Multirole fighters", "Refuelable", "Datalink", "Link16"},
    Categories  = { CLSID = "{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", Name = "Interceptor",},
    -- Countries   = {'China', 'Pakistan'},
    country_of_origin = 'SWE',
    date_of_introduction = 2002.9, --
    -------------------------
    -- add model draw args for network transmitting to this draw_args table (32 limit)
    net_animation =
    {
        -- light [8]
        83, 190, 191, 192, 200, 201, 208, 209,

        -- canopy/chock
        38, 23,
        -- LEF [4]
        130, 131, 132, 133,
        -- speedbrake [4]
        182, 184, 186, 188,
        -- drag chute
        35, 36, 37, 334, 335,
        611, 612, 613,

        419, 900, 901,

        -- test [10]
        950,
        951,
        952,
        953,
        954,
        955,
        956,
        957,
        958,
        959,

        961,
        962,
        963,
        964,
        965,
        966,
    },

    ColdStartDefaultControls = {
        [9]     =  0.0,     -- Right Flaps
        [10]    =  0.0,     -- Left  Flaps
        [11]    =  0.0,     -- Right Aileron
        [12]    =  0.0,     -- Left  Aileron
        [15]    =  0.0,     -- Right Elevators
        [16]    =  0.0,     -- Left  Elevators
        [18]    =  0.0,     -- Rudder
        [23]    =  1.0,     -- Wheele Choke
        --[38]    =  0.9,     -- Canopy
        [90]    =  1.0,     -- Engine Nozzle
        [130]   =  0.0,     -- Right inner  LEF
        [131]   =  0.0,     -- Right outter LEF
        [132]   =  0.0,     -- Left inner   LEF
        [133]   =  0.0,     -- Left outter  LEF
        --[602]   =  -1.0,    -- Right AoA sensor
        --[604]   =  -1.0,    -- Left AoA sensor
    },

    -- mechanimations = {
        -- Door0 = { -- Canopy
            -- {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.9, "in", 9.0},},},}, --[[Flags = {"Reversible"},]]},
            -- {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 6.0},},},}, --[[Flags = {"Reversible", "StepsBackwards"},]]},
            -- {Transition = {"Open", "Taxi"},   Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 6.0},},},}, --[[Flags = {"Reversible", "StepsBackwards"},]]},
            -- --{Transition = {"Close", "Taxi"},  Sequence = {{C = {{"Arg", 38, "set", 0.0},},},},},
            -- {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Arg", 38, "set", 1.0},},},},},
        -- },
        -- --ServiceHatches = {
        -- --    {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 10.0}}}, {C = {{"Arg", 23, "set", 1.0},},},},},
        -- --    {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 10.0}}}, {C = {{"Arg", 23, "set", 0.0},},},},},
        -- --    {Transition = {"Open", "Taxi"},  Sequence = {{C = {{"PosType", 6}, {"Sleep", "for",  5.0}}}, {C = {{"Arg", 23, "set", 0.0},},},},},
        -- --},
    -- },
    mechanimations = mech_anime,

    -------------------------
    M_empty						=	5700,	-- kg  with pilot and nose load, JAS 39C = 6800 (6586.0-886.35))
	M_nominal					=	8049,	-- kg (Empty Plus Full Internal F) 9430 (8936.0-886.35)
    M_max						=	14000,	-- kg (Maximum Take Off Weight)
	M_fuel_max					=	2325,	-- kg (Internal Fuel Only) --> Can't go over 2325kg /5125lbs using new "internal tank"
	H_max						=	15240,	-- m  (Maximum Operational Ceiling)
	average_fuel_consumption	=	0.004,
    CAS_min                    = 58,        --
    V_opt                      = 220,       --
    V_take_off                 = 65.0,    -- Take off speed in m/s (for AI)
    V_land                     = 60,      -- Land speed in m/s (for AI)
    V_max_sea_level            = 400,     -- Max speed at sea level in m/s (for AI)
    V_max_h                    = 700,     -- Max speed at max altitude in m/s (for AI)
    Vy_max                     = 304,     -- Max climb speed in m/s (for AI)
    Mach_max                   = 1.8,     -- Max speed in Mach (for AI)
    Ny_min                     = -3,        -- Min G (for AI)
    Ny_max                     = 8.0,     -- Max G (for AI)
    Ny_max_e                   = 8.0,     -- Max G (for AI)
    AOA_take_off               = 0.16,    -- AoA in take off (for AI)
    bank_angle_max             = 90,      -- Max bank angle (for AI)
    has_afteburner             = true,    -- AFB yes/no
    has_speedbrake             = true,    -- Speedbrake yes/no
----------------------------------------------------------------------------------------
-- SUSPENSION CODE BEGINS
----------------------------------------------------------------------------------------
    nose_gear_pos 				                = {4.488,	-2.045,	0},   -- nosegear coord 
    nose_gear_amortizer_direct_stroke   		=  0.05,      -- down from nose_gear_pos !!!
    nose_gear_amortizer_reversal_stroke  		=  -0.4,  -- up
    nose_gear_amortizer_normal_weight_stroke 	=  -0.27,   -- up 
    nose_gear_wheel_diameter 	                =   1.0, -- in m

    main_gear_pos 						 	    = {-0.800,	-1.96,	1.25}, -- main gear coords -1.95
    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
    main_gear_amortizer_reversal_stroke  	    =   -0.228, --  up 
    main_gear_amortizer_normal_weight_stroke    =   -0.114,-- down from main_gear_pos
    main_gear_wheel_diameter 				    =   1.0, -- in m
----------------------------------------------------------------------------------------
-- SUSPENSION CODE ENDS
----------------------------------------------------------------------------------------

    --brakeshute_name           = 4,        -- Landing - brake chute visual shape after separation
    brakeshute_name           = "JF-17_dragchute",

    tanker_type               = 4,        -- Tanker type if the plane is airrefuel capable (same type as F-14, aka drogue basket)
    is_tanker                 = false,    -- Tanker yes/no
    air_refuel_receptacle_pos = {4.308656, 0.799409, -0.920103}, -- refuel coords

    wing_tip_pos              = {-2.9, -0.08, 4.48}, -- wingtip coords for visual effects
    wing_area                 = 30,        -- JF-17 wing area in m2
    wing_span                 = 8.40,        -- JF-17 wing spain in m,
    wing_type                 = 0,        -- Fixed wing
    flaps_maneuver            = 1.0,        -- Max flaps in take-off and maneuver (0.5 = 1st stage, 1.0 = 2nd stage) (for AI)

    thrust_sum_max            = 5200,
    thrust_sum_ab             = 8566,

    length                    = 14.1,    -- JF-17 full lenght in m
    height                    = 4.5,        -- JF-17 height in m
    range                     = 2540,        -- Max range in km (for AI)
    RCS                       = 2,        -- Radar Cross Section m2
    IR_emission_coeff         = 0.375,        -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
    IR_emission_coeff_ab      = 2.0,        -- With afterburner
    --sound_name = "aircraft\JF-17\Sounds",

   engines_count   = 1, -- Engines count
   engines_nozzles = 
		{
			[1] = 
			{
				pos = 	{-6.231,	0.268,	0},-- Tribwerke   -5.231,	-0.468,	0
				elevation	=	0,-- AFB cone elevation  winkel nach oben unten
				diameter    =   1.05,-- AFB cone diameter   Kreis Ø --1.0
                exhaust_length_ab   =   10,--lenght in m  Kreis Ø kegel efekt
                exhaust_length_ab_K =   0.707,--animation geschwindigkeit
                smokiness_level     =   0.01, --0.05
				afterburner_circles_count = 11,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 0.95,
				afterburner_effect_texture = "afterburner_gripen",
			}, -- end of [1]
		}, -- end of engines_nozzles		
    apu_rpm_delay_ = 4, -- launch delay (for sound)

    crew_size    = 1,
    crew_members = {
        [1] = {
            ejection_through_canopy = true,
            ejection_play_arg   = 993,
            ejection_seat_name  = "pilot_f15_00_seat", -- temp
            pilot_name          = "pilot_f15_00", -- temp
            drop_parachute_name = "JF-17_parachute",
            drop_canopy_name    = "jas39gripen-fonar",
            pos                 = {4.45, 0.180, 0.00},
            canopy_pos          = {4.282, 0.620, 0.00},
            g_suit              = 5,
            bailout_arg         = -1,
        }, -- end of [1]
    }, -- end of crew_members

    Navpoint_Panel = true,
    Fixpoint_Panel = true,

    --dataCartridge = true,

    HumanRadio = {
        editable     = true,
        frequency    = 243.0,
        minFrequency = 30.000,
        maxFrequency = 399.975,
        rangeFrequency = {
            {min =  30.0, max =  87.995, modulation = MODULATION_FM},
            {min = 118.0, max = 135.995, modulation = MODULATION_AM},
            {min = 136.0, max = 155.995, modulation = MODULATION_AM_AND_FM},
            {min = 156.0, max = 173.995, modulation = MODULATION_FM},
            {min = 225.0, max = 399.975, modulation = MODULATION_AM_AND_FM}
        },
        modulation = MODULATION_AM,
    },

    TACAN_AA = true,

    panelRadio = {
        [1] = {
            name = _("COMM 1/2 Preset"),
            range = {
                -- {min =  30.0, max =  87.995, modulation = MODULATION_FM},
                -- {min = 118.0, max = 135.995, modulation = MODULATION_AM},
                -- {min = 136.0, max = 155.995, modulation = MODULATION_AM_AND_FM},
                -- {min = 156.0, max = 173.995, modulation = MODULATION_FM},
                -- {min = 225.0, max = 399.975, modulation = MODULATION_AM_AND_FM},
                {min =  30.0, max = 399.995, modulation = MODULATION_AM_AND_FM},
            },
            channels = {
                [1]  = { name = _("Channel 1"),     default = 108.0, modulation = _("AM") },
                [2]  = { name = _("Channel 2"),     default = 108.5, modulation = _("AM") },
                [3]  = { name = _("Channel 3"),     default = 109.0, modulation = _("AM") },
                [4]  = { name = _("Channel 4"),     default = 109.5, modulation = _("AM") },
                [5]  = { name = _("Channel 5"),     default = 110.0, modulation = _("AM") },
                [6]  = { name = _("Channel 6"),     default = 110.5, modulation = _("AM") },
                [7]  = { name = _("Channel 7"),     default = 111.0, modulation = _("AM") },
                [8]  = { name = _("Channel 8"),     default = 111.5, modulation = _("AM") },
                [9]  = { name = _("Channel 9"),     default = 112.0, modulation = _("AM") },
                [10] = { name = _("Channel 10"),    default = 112.5, modulation = _("AM") },
                [11] = { name = _("Channel 11"),    default = 113.0, modulation = _("AM") },
                [12] = { name = _("Channel 12"),    default = 113.5, modulation = _("AM") },
                [13] = { name = _("Channel 13"),    default = 114.0, modulation = _("AM") },
                [14] = { name = _("Channel 14"),    default = 114.5, modulation = _("AM") },
                [15] = { name = _("Channel 15"),    default = 115.0, modulation = _("AM") },
                [16] = { name = _("Channel 16"),    default = 115.5, modulation = _("AM") },
                [17] = { name = _("Channel 17"),    default = 116.0, modulation = _("AM") },
                [18] = { name = _("Channel 18"),    default = 116.5, modulation = _("AM") },
                [19] = { name = _("Channel 19"),    default = 117.0, modulation = _("AM") },
                [20] = { name = _("Channel 20"),    default = 117.5, modulation = _("AM") },
            }
        },
    },
----------------------------------------------------------------------------------------
-- Aircraft Additional Properties
----------------------------------------------------------------------------------------   
    AddPropAircraft = add_aircraft_prop(),

    -- Countermeasures
    --[[Countermeasures = {
        ECM = "AN/ALQ-135",
    },]]
    
	passivCounterm 		= {
	CMDS_Edit 			= true,
	SingleChargeTotal 	= 220,
	chaff 				= {default = 160, increment = 20, chargeSz = 1},
	flare 				= {default = 080, increment = 10, chargeSz = 1}
	},

    chaff_flare_dispenser = 
		{
		[1] = { dir = {0, 1.0, 0}, pos = {-3.25, 0.35, 0.8}, },	-- fuselage top	x, y, z = f/b, u/d, l/r
        [2] = { dir = {0, 1.0, 0}, pos = {-3.50, 0.35, 0.8}, },
        [3] = { dir = {0, 1.0, 0}, pos = {-3.75, 0.35, 0.8}, },
        [4] = { dir = {0, -1.0, 0}, pos = {-2.5, -1.0, 0.8}, }, -- fuselage bottom

        [5] = { dir = {-1, 0, 0}, pos = {-0.991, -0.206, -2.779}, }, -- BOP/B Outer left
        [6] = { dir = {-1, 0, 0}, pos = {0.366, -0.226, -1.890}, }, -- BOP/B Inner left
        [7] = { dir = {-1, 0, 0}, pos = {0.366, -0.226, 1.890}, }, -- BOP/B Inner right
        [8] = { dir = {-1, 0, 0}, pos = {-0.991, -0.206, 2.779}, }, -- BOP/B outer right

		[9] = { dir = {-1, 0, 0}, pos = {-0.991, -0.506, -2.779}, }, -- BOL Outer left
        [10] = { dir = {-1, 0, 0}, pos = {0.366, -0.526, -1.890}, }, -- BOL Inner left
        [11] = { dir = {-1, 0, 0}, pos = {0.366, -0.526, 1.890}, },  -- BOL Inner right
        [12] = { dir = {-1, 0, 0}, pos = {-0.991, -0.506, 2.779}, }, -- BOL outer right

		}, -- end of chaff_flare_dispenser -- end of chaff_flare_dispenser  
----------------------------------------------------------------------------------------
-- Sensors
----------------------------------------------------------------------------------------
    Sensors = {
        RADAR = "AN/APG-63",
        RWR   = "Abstract RWR",
    },
    detection_range_max   = 180.0,
    radar_can_see_ground  = true,
    EPLRS                 = true,

    CanopyGeometry = {
        azimuth   = {-160.0, 160.0}, --
        elevation = {-50.0, 90.0} --
    },

    Guns = {
        gun_mount("GSh_23_2",
        {
            count = 120
        },
        {
            muzzle_pos_connector   = "Gun_point",
            supply_position        = {0, 0, 0},
            drop_cartridge         = 203,
            ejector_pos_connector  = "Gun_point",
            ejector_dir            = {0, -1, 0},
            elevation_initial      = -0.0,
        }),
    },
----------------------------------------------------------------------------------------
-- Pylons	
----------------------------------------------------------------------------------------
    Pylons = {
        -- LEFT WING TIP --> STATION 1
        pylon(1, 0, 0, 0, 0,
            {
                DisplayName = "1",
                use_full_connector_position = true,
                connector = "Pylon1",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.0, 0.0, 0.0}, arg_increment = 0.0 }, 
							
--				==== SMOKE PODS ===
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" ,arg_value = -0.1},
            }
        ),
        -- LEFT OUTER PYLON --> STATION 2
		pylon(2, 0, 0, 0, 0,
            {
                arg = 309,
                arg_value = 0,
                DisplayName = "2",
                use_full_connector_position = true,
                connector = "Pylon2",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.30, -0.14, 0.0}, arg_increment = 0.0 },

--				=== BVR AIR TO AIR MISSILES ===
--				{ CLSID = "DIS_PL-12", attach_point_position = {0.30, -0.13, 0.0}, arg_increment = 0.0},   -- Meteor x1
                { CLSID = "DIS_SD-10", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.0}, -- AIM-120C-7 x1
                { CLSID = "DIS_SD-10_DUAL_L", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x2
                { CLSID = "DIS_SD-10_DUAL_R", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x3
				
--				=== AIR TO GROUND MISSILES ===
                { CLSID = "DIS_C-701T", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65K TV
				{ CLSID = "DIS_C-701IR", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65G IR
                { CLSID = "DIS_C-802AK", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- Rb15F Mk4 Antiship missiles
                { CLSID = 'DIS_CM-802AKG', attach_point_position ={ -0.0, 0.01, 0.0}, arg_value = 0.9, Type = 1},	--KEPD 350 
                { CLSID = "DIS_LD-10", attach_point_position ={ 0.0, 0.0, 0.0}, arg_value = 0.9, Type = 1}, -- SPEAR EW Anti radiation missiles
                { CLSID = "DIS_LD-10_DUAL_R", attach_point_position ={-0.30, -0.125, 0.0}, arg_value = 0.9, Type = 1}, -- MAR-1 Anti radiation missiles x1
                { CLSID = "DIS_LD-10_DUAL_L", attach_point_position ={0.0, -0.12, 0.0}, arg_value = 0.2}, -- MAR-1 Anti radiation missiles x2	
        
					
--			    === GUIDED BOMBS ===
                { CLSID = "DIS_GBU_10", arg_value = 0.69 }, -- GBU-10

				{ CLSID = "DIS_GBU_12", arg_value = 0.69 }, -- GBU-12
				{ CLSID = "DIS_GBU_12_DUAL", arg_value = 0.69, Type = 1 }, -- GBU-12 x 2
                { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_L", arg_value = 0.69, Type = 1 }, -- GBU-12 x2
--              { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_R", arg_value = 0.69, Type = 1 }, -- GBU-12 x3
                
                { CLSID = "DIS_GBU_16", arg_value = 0.69 }, -- GBU-16
				               
                { CLSID = "DIS_GB6", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-A
                { CLSID = "DIS_GB6_HE", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- AGM154-B
                { CLSID = "DIS_GB6_TSP", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-C		

                { CLSID = "DIS_LS_6_100", arg_value = 0.5 },-- GBU-31 BLU-109
                { CLSID = "DIS_LS_6_100_DUAL_L", arg_value = 0.5, Type = 1 },-- WIP
--              { CLSID = "DIS_LS_6_100_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_250", arg_value = 0.5, Type = 1 },-- GBU-39 SDBx2
 				{ CLSID = "DIS_LS_6_250_DUAL_L", arg_value = 0.3, Type = 1 },-- GBU-39 SDBx4
--              { CLSID = "DIS_LS_6_250_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_500", arg_increment = 0.5, Type = 1}, -- DWS39/BK90	
								
--				=== UNGUIDED BOMBS ===
				{ CLSID = "DIS_MK_20", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye (can we make this the M71 LD)
                { CLSID = "DIS_MK_20_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19
--              { CLSID = "DIS_MK_20_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19

                { CLSID = "{Mk82SNAKEYE}", arg_increment = 0.5, Type = 1 }, -- Mk-82S
                { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19
--              { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19

                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_increment = 0.5, Type = 1}, -- Mk-82
                { CLSID = "{BRU33_2X_MK-82}", arg_increment = 0.5, Type = 1}, -- Mk-82 x 2
                { CLSID = "DIS_MK_82_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19
--              { CLSID = "DIS_MK_82_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19

                { CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", arg_increment = 0.5, Type = 1}, -- Mk-83
				
				{ CLSID = "DIS_TYPE200", arg_increment = 0.5, Type = 1}, -- M71 LD
				{ CLSID = "DIS_TYPE200_DUAL_L", arg_increment = 0.5, Type = 1}, -- M71 LD
--				{ CLSID = "DIS_TYPE200_DUAL_R", arg_increment = 0.5, Type = 1}, -- M71 LD

--              === ROCKETS ===
                { CLSID = "DIS_BRM1_90", attach_point_position = {-0.15, 0.02, 0.0}, arg_value = 0.5 }, -- Brimstone x3
                { CLSID = "DIS_RKT_90_UG", arg_value = 0.5 }, -- M70B AP
                { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_L", arg_value = 0.5 },
--              { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_R", arg_value = 0.5 },
				
--				=== OTHERS ===   
                { CLSID = "DIS_WMD7", arg_value = 0.5 },
                { CLSID = "DIS_SPJ_POD", arg_value = 0.55 },
                { CLSID = "DIS_AKG_DLPOD", arg_value = 0.7, forbidden = {{station = 2, loadout = {"DIS_AKG_DLPOD"}},{station = 4, loadout = {"DIS_AKG_DLPOD"}}} },

                { CLSID = 'DIS_SMOKE_GENERATOR_R', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_G', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_B', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_W', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_Y', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_O', arg_value = 0.3},

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
        pylon(3, 0, 0, 0, 0,
            {
                arg = 310,
                arg_value = 0,
                DisplayName = "3",
                use_full_connector_position = true,
                connector = "Pylon3",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.30, -0.14, 0.0}, arg_increment = 0.0 },

--				=== BVR AIR TO AIR MISSILES ===
--				{ CLSID = "DIS_PL-12", attach_point_position = {0.30, -0.13, 0.0}, arg_increment = 0.0},   -- Meteor x1
                { CLSID = "DIS_SD-10", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.0}, -- AIM-120C-7 x1
                { CLSID = "DIS_SD-10_DUAL_L", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x2
                { CLSID = "DIS_SD-10_DUAL_R", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x3
				
--				=== AIR TO GROUND MISSILES ===
                { CLSID = "DIS_C-701T", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65K TV
				{ CLSID = "DIS_C-701IR", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65G IR
                { CLSID = "DIS_C-802AK", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- Rb15F Mk4 Antiship missiles
                { CLSID = 'DIS_CM-802AKG', attach_point_position ={ -0.0, 0.01, 0.0}, arg_value = 0.9, Type = 1},	--KEPD 350 
                { CLSID = "DIS_LD-10", attach_point_position ={ 0.0, 0.0, 0.0}, arg_value = 0.9, Type = 1}, -- SPEAR EW Anti radiation missiles
                { CLSID = "DIS_LD-10_DUAL_R", attach_point_position ={-0.30, -0.125, 0.0}, arg_value = 0.9, Type = 1}, -- MAR-1 Anti radiation missiles x1
                { CLSID = "DIS_LD-10_DUAL_L", attach_point_position ={0.0, -0.12, 0.0}, arg_value = 0.2}, -- MAR-1 Anti radiation missiles x2	
					
--			    === GUIDED BOMBS ===
                { CLSID = "DIS_GBU_10", arg_value = 0.69 }, -- GBU-10

				{ CLSID = "DIS_GBU_12", arg_value = 0.69 }, -- GBU-12
				{ CLSID = "DIS_GBU_12_DUAL", arg_value = 0.69, Type = 1 }, -- GBU-12 x 2
                { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_L", arg_value = 0.69, Type = 1 }, -- GBU-12 x2
--              { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_R", arg_value = 0.69, Type = 1 }, -- GBU-12 x3
                
                { CLSID = "DIS_GBU_16", arg_value = 0.69 }, -- GBU-16
				               
                { CLSID = "DIS_GB6", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-A
                { CLSID = "DIS_GB6_HE", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- AGM154-B
                { CLSID = "DIS_GB6_TSP", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-C		

                { CLSID = "DIS_LS_6_100", arg_value = 0.5 },-- GBU-31 BLU-109
                { CLSID = "DIS_LS_6_100_DUAL_L", arg_value = 0.5, Type = 1 },-- WIP
--              { CLSID = "DIS_LS_6_100_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_250", arg_value = 0.5, Type = 1 },-- GBU-39 SDBx2
 				{ CLSID = "DIS_LS_6_250_DUAL_L", arg_value = 0.3, Type = 1 },-- GBU-39 SDBx4
--              { CLSID = "DIS_LS_6_250_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_500", arg_increment = 0.5, Type = 1}, -- DWS39/BK90	
								
--				=== UNGUIDED BOMBS ===
				{ CLSID = "DIS_MK_20", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye (can we make this the M71 LD)
                { CLSID = "DIS_MK_20_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19
--              { CLSID = "DIS_MK_20_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19

                { CLSID = "{Mk82SNAKEYE}", arg_increment = 0.5, Type = 1 }, -- Mk-82S
                { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19
--              { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19

                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_increment = 0.5, Type = 1}, -- Mk-82
                { CLSID = "{BRU33_2X_MK-82}", arg_increment = 0.5, Type = 1}, -- Mk-82 x 2
                { CLSID = "DIS_MK_82_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19
--              { CLSID = "DIS_MK_82_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19

                { CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", arg_increment = 0.5, Type = 1}, -- Mk-83
				
				{ CLSID = "DIS_TYPE200", arg_increment = 0.5, Type = 1}, -- M71 LD
				{ CLSID = "DIS_TYPE200_DUAL_L", arg_increment = 0.5, Type = 1}, -- M71 LD
--				{ CLSID = "DIS_TYPE200_DUAL_R", arg_increment = 0.5, Type = 1}, -- M71 LD

--              === ROCKETS ===
                { CLSID = "DIS_BRM1_90", attach_point_position = {-0.15, 0.02, 0.0}, arg_value = 0.5 }, -- Brimstone x3
                { CLSID = "DIS_RKT_90_UG", arg_value = 0.5 }, -- M70B AP
                { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_L", arg_value = 0.5 },
--              { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_R", arg_value = 0.5 },
				
--				=== OTHERS ===   
                { CLSID = "DIS_WMD7", arg_value = 0.5 },
                { CLSID = "DIS_SPJ_POD", arg_value = 0.55 },
                { CLSID = "DIS_AKG_DLPOD", arg_value = 0.7, forbidden = {{station = 2, loadout = {"DIS_AKG_DLPOD"}},{station = 4, loadout = {"DIS_AKG_DLPOD"}}} },

                { CLSID = 'DIS_SMOKE_GENERATOR_R', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_G', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_B', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_W', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_Y', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_O', arg_value = 0.3},

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
        -- CENTER PYLON --> STATION 4
		pylon(4, 0, -0.300, -0.336, 2.85,
            {
                DisplayName = "4",
				use_full_connector_position = true, connector = "Pylon6", arg = 313, arg_value = 0
            },

            {	
--				=== AIR TO GROUND MISSILES ===
 
                { CLSID = "DIS_C-802AK", arg_value = 0.9, Type = 1, attach_point_position ={ -0.38, -0.27, 0.0} }, -- Rb15F Mk4 Antiship missiles
                { CLSID = 'DIS_CM-802AKG', arg_value = 0.9, Type = 1 },	--KEPD 350 *Make this*	
					
--			    === GUIDED BOMBS ===
                { CLSID = "DIS_GBU_10", arg_value = 0.5 }, -- GBU-10

				{ CLSID = "DIS_GBU_12", arg_value = 0.5 }, -- GBU-12
				{ CLSID = "DIS_GBU_12_DUAL", arg_value = 0.5 }, -- GBU-12 x 2
                { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_L", arg_value = 0.3 }, -- GBU-12 x2 gjd-ii19
--              { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_R", arg_value = 0.3 }, -- GBU-12 x2 gjd-ii19

                { CLSID = "DIS_GBU_16", arg_value = 0.5 }, -- GBU-16
				               
                { CLSID = "DIS_GB6", arg_value = 0.4, Type = 1 },-- Storm Shadow
                { CLSID = "DIS_GB6_TSP", arg_value = 0.4, Type = 1 },---- BK90 MJ2 / dws39 *Make this*	
                { CLSID = "DIS_GB6_HE", arg_value = 0.5, Type = 1 }, -- BK90 MJ2 / dws39 *Make this*	

                { CLSID = "DIS_LS_6_100", arg_value = 0.5 }, --GBU-39 SDB
                { CLSID = "DIS_LS_6_100_DUAL_L", arg_value = 0.5, Type = 1 }, --GBU-39 SDB
--              { CLSID = "DIS_LS_6_100_DUAL_R", arg_value = 0.5, Type = 1 }, --GBU-39 SDB

                { CLSID = "DIS_LS_6_250", arg_value = 0.5, Type = 1 },--SPEAR-3
				{ CLSID = "DIS_LS_6_250_DUAL_L", arg_value = 0.5, Type = 1 },--SPEAR-3
--              { CLSID = "DIS_LS_6_250_DUAL_R", arg_value = 0.3, Type = 1 },--SPEAR-3

                { CLSID = "DIS_LS_6_500", arg_increment = 0.5, Type = 1}, -- AGM154 / Storm Shadow		
								
--				=== UNGUIDED BOMBS ===
				{ CLSID = "DIS_MK_20", arg_value = 0.5 }, -- Mk-20 Rockeye (can we make this the M71 LD)
                { CLSID = "DIS_MK_20_DUAL_GDJ_II19_L",  arg_value = 0.3 }, -- Mk-20 Rockeye x2 gjd-ii19
--              { CLSID = "DIS_MK_20_DUAL_GDJ_II19_R",  arg_value = 0.3 }, -- Mk-20 Rockeye x2 gjd-ii19

                { CLSID = "{Mk82SNAKEYE}", arg_value = 0.5 }, -- Mk-82S
                { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_L", arg_value = 0.3 }, -- Mk-82 Snakeye x2 gjd-ii19
--              { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R", arg_value = 0.3 }, -- Mk-82 Snakeye x2 gjd-ii19

                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.5 }, -- Mk-82
                { CLSID = "{BRU33_2X_MK-82}", arg_value = 0.5 }, -- Mk-82 x 2
                { CLSID = "DIS_MK_82_DUAL_GDJ_II19_L",  arg_value = 0.3 }, -- Mk-82 x2 gjd-ii19
--              { CLSID = "DIS_MK_82_DUAL_GDJ_II19_R",  arg_value = 0.3 }, -- Mk-82 x2 gjd-ii19

                { CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", arg_value = 0.5 }, -- Mk-83
				
				{ CLSID = "DIS_TYPE200", arg_value = 0.5 }, -- M71
				{ CLSID = "DIS_TYPE200_DUAL_L", arg_value = 0.3 },  -- M71
--              === Drop tanks ===
                { CLSID = "DIS_TANK800", arg_value = 0.1 }, -- External drop tank 1100 litre
                { CLSID = "DIS_TANK1100", arg_value = 0.1, --[[required = {{station = 3,loadout = {"DIS_TANK1100"}}}]] },
                { CLSID = "DIS_TANK800_EMPTY", arg_value = 0.1, },
                { CLSID = "DIS_TANK1100_EMPTY", arg_value = 0.1, },
					
--				=== Guided rockets ===
				{ CLSID = "DIS_BRM1_90", attach_point_position = {0.0, 0.02, 0.0}, arg_value = 0.5 }, -- Brimstone
				
--              ==== PODS ===
                { CLSID = "DIS_WMD7", arg_value = 0.5 },
                { CLSID = "DIS_SPJ_POD", arg_value = 0.55 },
                { CLSID = "DIS_AKG_DLPOD", arg_value = 0.7, forbidden = {{station = 2, loadout = {"DIS_AKG_DLPOD"}},{station = 4, loadout = {"DIS_AKG_DLPOD"}}} },

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
        -- RIGHT INNER PYLON --> STATION 5
		pylon(5, 0, 0, 0, 0,
            {
                arg = 316,
                arg_value = 0,
                DisplayName = "5",
                use_full_connector_position = true,
                connector = "Pylon9",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.30, -0.14, 0.0}, arg_increment = 0.0 },


--				=== BVR AIR TO AIR MISSILES ===
--				{ CLSID = "DIS_PL-12", attach_point_position = {0.30, -0.13, 0.0}, arg_increment = 0.0},   -- Meteor x1
                { CLSID = "DIS_SD-10", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.0}, -- AIM-120C-7 x1
                { CLSID = "DIS_SD-10_DUAL_L", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x2
                { CLSID = "DIS_SD-10_DUAL_R", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x3
				
--				=== AIR TO GROUND MISSILES ===
                { CLSID = "DIS_C-701T", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65K TV
				{ CLSID = "DIS_C-701IR", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65G IR
                { CLSID = "DIS_C-802AK", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- Rb15F Mk4 Antiship missiles
                { CLSID = 'DIS_CM-802AKG', attach_point_position ={ -0.0, 0.01, 0.0}, arg_value = 0.9, Type = 1},	--KEPD 350 
                { CLSID = "DIS_LD-10", attach_point_position ={ 0.0, 0.0, 0.0}, arg_value = 0.9, Type = 1}, -- SPEAR EW Anti radiation missiles
                { CLSID = "DIS_LD-10_DUAL_R", attach_point_position ={-0.30, -0.125, 0.0}, arg_value = 0.9, Type = 1}, -- MAR-1 Anti radiation missiles x1
                { CLSID = "DIS_LD-10_DUAL_L", attach_point_position ={0.0, -0.12, 0.0}, arg_value = 0.2}, -- MAR-1 Anti radiation missiles x2	
					
--			    === GUIDED BOMBS ===
                { CLSID = "DIS_GBU_10", arg_value = 0.69 }, -- GBU-10

				{ CLSID = "DIS_GBU_12", arg_value = 0.69 }, -- GBU-12
				{ CLSID = "DIS_GBU_12_DUAL", arg_value = 0.69, Type = 1 }, -- GBU-12 x 2
                { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_L", arg_value = 0.69, Type = 1 }, -- GBU-12 x2
--              { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_R", arg_value = 0.69, Type = 1 }, -- GBU-12 x3
                
                { CLSID = "DIS_GBU_16", arg_value = 0.69 }, -- GBU-16
				               
                { CLSID = "DIS_GB6", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-A
                { CLSID = "DIS_GB6_HE", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- AGM154-B
                { CLSID = "DIS_GB6_TSP", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-C		

                { CLSID = "DIS_LS_6_100", arg_value = 0.5 },-- GBU-31 BLU-109
                { CLSID = "DIS_LS_6_100_DUAL_L", arg_value = 0.5, Type = 1 },-- WIP
--              { CLSID = "DIS_LS_6_100_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_250", arg_value = 0.5, Type = 1 },-- GBU-39 SDBx2
 				{ CLSID = "DIS_LS_6_250_DUAL_L", arg_value = 0.3, Type = 1 },-- GBU-39 SDBx4
--              { CLSID = "DIS_LS_6_250_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_500", arg_increment = 0.5, Type = 1}, -- DWS39/BK90	
								
--				=== UNGUIDED BOMBS ===
				{ CLSID = "DIS_MK_20", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye (can we make this the M71 LD)
                { CLSID = "DIS_MK_20_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19
--              { CLSID = "DIS_MK_20_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19

                { CLSID = "{Mk82SNAKEYE}", arg_increment = 0.5, Type = 1 }, -- Mk-82S
                { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19
--              { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19

                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_increment = 0.5, Type = 1}, -- Mk-82
                { CLSID = "{BRU33_2X_MK-82}", arg_increment = 0.5, Type = 1}, -- Mk-82 x 2
                { CLSID = "DIS_MK_82_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19
--              { CLSID = "DIS_MK_82_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19

                { CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", arg_increment = 0.5, Type = 1}, -- Mk-83
				
				{ CLSID = "DIS_TYPE200", arg_increment = 0.5, Type = 1}, -- M71 LD
				{ CLSID = "DIS_TYPE200_DUAL_L", arg_increment = 0.5, Type = 1}, -- M71 LD
--				{ CLSID = "DIS_TYPE200_DUAL_R", arg_increment = 0.5, Type = 1}, -- M71 LD

--              === ROCKETS ===
                { CLSID = "DIS_BRM1_90", attach_point_position = {-0.15, 0.02, 0.0}, arg_value = 0.5 }, -- Brimstone x3
                { CLSID = "DIS_RKT_90_UG", arg_value = 0.5 }, -- M70B AP
--              { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_L", arg_value = 0.5 },
                { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_R", arg_value = 0.5 },
				
--				=== OTHERS ===   
                { CLSID = "DIS_WMD7", arg_value = 0.5 },
                { CLSID = "DIS_SPJ_POD", arg_value = 0.55 },
                { CLSID = "DIS_AKG_DLPOD", arg_value = 0.7, forbidden = {{station = 2, loadout = {"DIS_AKG_DLPOD"}},{station = 4, loadout = {"DIS_AKG_DLPOD"}}} },

                { CLSID = 'DIS_SMOKE_GENERATOR_R', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_G', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_B', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_W', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_Y', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_O', arg_value = 0.3},

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
        -- RIGHT OUTER PYLON --> STATION 6
		pylon(6, 0, 0, 0, 0,
            {
                arg = 317,
                arg_value = 0,
                DisplayName = "6",
                use_full_connector_position = true,
                connector = "Pylon10",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.30, -0.14, 0.0}, arg_increment = 0.0 },

--				=== BVR AIR TO AIR MISSILES ===
--				{ CLSID = "DIS_PL-12", attach_point_position = {0.30, -0.13, 0.0}, arg_increment = 0.0},   -- Meteor x1
                { CLSID = "DIS_SD-10", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.0}, -- AIM-120C-7 x1
                { CLSID = "DIS_SD-10_DUAL_L", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x2
                { CLSID = "DIS_SD-10_DUAL_R", attach_point_position = {0.0, -0.20, 0.0}, arg_value = 0.75}, -- AIM-120C-7 x3
				
--				=== AIR TO GROUND MISSILES ===
                { CLSID = "DIS_C-701T", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65K TV
				{ CLSID = "DIS_C-701IR", attach_point_position = {0.37, -0.3, 0.0}, arg_value = 0.1}, -- AGM-65G IR
                { CLSID = "DIS_C-802AK", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- Rb15F Mk4 Antiship missiles
                { CLSID = 'DIS_CM-802AKG', attach_point_position ={ -0.0, 0.01, 0.0}, arg_value = 0.9, Type = 1},	--KEPD 350 
                { CLSID = "DIS_LD-10", attach_point_position ={ 0.0, 0.0, 0.0}, arg_value = 0.9, Type = 1}, -- SPEAR EW Anti radiation missiles
                { CLSID = "DIS_LD-10_DUAL_R", attach_point_position ={-0.30, -0.125, 0.0}, arg_value = 0.9, Type = 1}, -- MAR-1 Anti radiation missiles x1
                { CLSID = "DIS_LD-10_DUAL_L", attach_point_position ={0.0, -0.12, 0.0}, arg_value = 0.2}, -- MAR-1 Anti radiation missiles x2	
					
--			    === GUIDED BOMBS ===
                { CLSID = "DIS_GBU_10", arg_value = 0.69 }, -- GBU-10

				{ CLSID = "DIS_GBU_12", arg_value = 0.69 }, -- GBU-12
				{ CLSID = "DIS_GBU_12_DUAL", arg_value = 0.69, Type = 1 }, -- GBU-12 x 2
                { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_L", arg_value = 0.69, Type = 1 }, -- GBU-12 x2
--              { CLSID = "DIS_GBU_12_DUAL_GDJ_II19_R", arg_value = 0.69, Type = 1 }, -- GBU-12 x3
                
                { CLSID = "DIS_GBU_16", arg_value = 0.69 }, -- GBU-16
				               
                { CLSID = "DIS_GB6", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-A
                { CLSID = "DIS_GB6_HE", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1}, -- AGM154-B
                { CLSID = "DIS_GB6_TSP", attach_point_position ={ -0.38, -0.27, 0.0}, arg_value = 0.9, Type = 1},-- AGM154-C		

                { CLSID = "DIS_LS_6_100", arg_value = 0.5 },-- GBU-31 BLU-109
                { CLSID = "DIS_LS_6_100_DUAL_L", arg_value = 0.5, Type = 1 },-- WIP
--              { CLSID = "DIS_LS_6_100_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_250", arg_value = 0.5, Type = 1 },-- GBU-39 SDBx2
 				{ CLSID = "DIS_LS_6_250_DUAL_L", arg_value = 0.3, Type = 1 },-- GBU-39 SDBx4
--              { CLSID = "DIS_LS_6_250_DUAL_R", arg_value = 0.5, Type = 1 },-- WIP

                { CLSID = "DIS_LS_6_500", arg_increment = 0.5, Type = 1}, -- DWS39/BK90	
								
--				=== UNGUIDED BOMBS ===
				{ CLSID = "DIS_MK_20", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye (can we make this the M71 LD)
                { CLSID = "DIS_MK_20_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19
--              { CLSID = "DIS_MK_20_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-20 Rockeye x2 gjd-ii19

                { CLSID = "{Mk82SNAKEYE}", arg_increment = 0.5, Type = 1 }, -- Mk-82S
                { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19
--              { CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 Snakeye x2 gjd-ii19

                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_increment = 0.5, Type = 1}, -- Mk-82
                { CLSID = "{BRU33_2X_MK-82}", arg_increment = 0.5, Type = 1}, -- Mk-82 x 2
                { CLSID = "DIS_MK_82_DUAL_GDJ_II19_L", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19
--              { CLSID = "DIS_MK_82_DUAL_GDJ_II19_R", arg_increment = 0.5, Type = 1}, -- Mk-82 x2 gjd-ii19

                { CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}", arg_increment = 0.5, Type = 1}, -- Mk-83
				
				{ CLSID = "DIS_TYPE200", arg_increment = 0.5, Type = 1}, -- M71 LD
				{ CLSID = "DIS_TYPE200_DUAL_L", arg_increment = 0.5, Type = 1}, -- M71 LD
--				{ CLSID = "DIS_TYPE200_DUAL_R", arg_increment = 0.5, Type = 1}, -- M71 LD

--              === ROCKETS ===
                { CLSID = "DIS_BRM1_90", attach_point_position = {-0.15, 0.02, 0.0}, arg_value = 0.5 }, -- Brimstone x3
                { CLSID = "DIS_RKT_90_UG", arg_value = 0.5 }, -- M70B AP
--              { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_L", arg_value = 0.5 },
                { CLSID = "DIS_LAU68_MK5_DUAL_GDJ_II19_R", arg_value = 0.5 },
				
--				=== OTHERS ===   
                { CLSID = "DIS_WMD7", arg_value = 0.5 },
                { CLSID = "DIS_SPJ_POD", arg_value = 0.55 },
                { CLSID = "DIS_AKG_DLPOD", arg_value = 0.7, forbidden = {{station = 2, loadout = {"DIS_AKG_DLPOD"}},{station = 4, loadout = {"DIS_AKG_DLPOD"}}} },

                { CLSID = 'DIS_SMOKE_GENERATOR_R', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_G', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_B', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_W', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_Y', arg_value = 0.3},
                { CLSID = 'DIS_SMOKE_GENERATOR_O', arg_value = 0.3},

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
        -- RIGHT WING TIP --> STATION 7
		pylon(7, 0, 0, 0, 0,
            {
                DisplayName = "7",
                use_full_connector_position = true,
                connector = "Pylon11",
            },
            {
--				=== INFRARED AIR TO AIR MISSILES ===
                { CLSID = "DIS_PL-5EII", attach_point_position = {0.0, 0.0, 0.0}, arg_increment = 0.0 },
					
--				==== SMOKE PODS ===
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" , arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" ,arg_value = -0.1},
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" ,arg_value = -0.1},
            }
        ),
		-- RECON PYLON --> LDP
		pylon(8, 0, 0, 0, 0,
            {
                DisplayName = "LDP",
                use_full_connector_position = true,
                connector = "Pylon7",
            },
            {
--				=== Pods ===
                { CLSID = "DIS_WMD7", arg_value = 0.5 },

--				=== Remove pylon ===		
				{ CLSID = "<CLEAN>", arg_value = 1},
            }
        ),
    },
----------------------------------------------------------------------------------------
-- Tasks
----------------------------------------------------------------------------------------
    Tasks = {
        aircraft_task(Intercept), -- 10
        aircraft_task(CAP), -- 11
    --  aircraft_task(Nothing), -- 15
        aircraft_task(AFAC), -- 16
        aircraft_task(Reconnaissance), -- 17
        aircraft_task(Escort), -- 18
        aircraft_task(FighterSweep), -- 19
        aircraft_task(SEAD), -- 29
        aircraft_task(AntishipStrike), -- 30
        aircraft_task(CAS), -- 31
        aircraft_task(GroundAttack), -- 32
        aircraft_task(PinpointStrike), -- 33
        aircraft_task(RunwayAttack), -- 34
    },

    DefaultTask = aircraft_task(CAP),
----------------------------------------------------------------------------------------
-- SFM Data
----------------------------------------------------------------------------------------
    SFM_Data = {
        aerodynamics = { -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
            Cy0        = 0,      -- zero AoA lift coefficient
            Mzalfa     = 5.5,  -- coefficients for pitch agility
            Mzalfadt   = 0.8,    -- coefficients for pitch agility
            kjx        = 4.20,		--- roll inertia
            kjz        = 0.00125,	--- pitch inertia
            Czbe       = -0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear    = 0.08,    -- coefficient, drag, gear
            cx_flap    = 0.010,   -- coefficient, drag, full flaps
            cy_flap    = 0.56,    -- coefficient, normal force, lift, flaps
            cx_brk     = 0.12,   -- coefficient, drag, breaks
            table_data = {
                  --  	 Mach    Cx0   		 Cya     B    		 B4     Omxmax   Aldop      Cymax
					{ 0.000,	 0.0470,	0.078,	0.0310,		 0.19,	 0.68,	 25.000,	 1.14 },
					{ 0.050, 	 0.0475, 	0.078, 	0.0310, 	 0.19, 	 0.95, 	 25.000, 	 1.15 }, 
					{ 0.100, 	 0.0475, 	0.078, 	0.0310, 	 0.19, 	 1.20, 	 25.000, 	 1.16 },
					{ 0.200,	 0.0475,	0.078,	0.0295,		 0.19,	 2.15,	 25.000,	 1.170 },
					{ 0.300,	 0.0475,	0.076,	0.0295,		 0.19,	 2.80,	 25.000,	 1.177 },
					{ 0.400,	 0.0454,	0.075,	0.0280,		 0.15,	 3.70, 	 25.000,	 1.184 },
					{ 0.500,	 0.0430,	0.074,	0.0250,		 0.11,	 4.45, 	 25.000,	 1.192 },
					{ 0.600,	 0.0410,	0.073,	0.0250,		 0.11,	 4.55,	 25.000,	 1.200 },
					{ 0.700,	 0.0390,	0.070,	0.0290,		 0.11,	 4.55,	 25.000,	 1.200 },
					{ 0.800,	 0.0380,	0.068,	0.0318,		 0.13,	 4.50,	 25.000,	 1.200 },
					{ 0.850,	 0.0370,	0.065,	0.0348,		 0.16,	 4.47,	 25.000,	 1.210 },
					{ 0.900,	 0.0370,	0.055,	0.0370,		 0.16,	 4.45,	 25.000,	 1.220 },
																							
					{ 1.000,	 0.0370,	0.053,	0.0400, 	 0.16,	 4.10, 	 25.000,	 9.300 },
					{ 1.050,	 0.0370,	0.052,	0.0428,		 0.16,	 4.07,	 25.000,	 9.300 },
					{ 1.100,	 0.0370,	0.050, 	0.0459, 	 0.16,	 4.05,	 25.000,	 9.300 },
					{ 1.200,	 0.0370,	0.049, 	0.0500, 	 0.15,	 4.00, 	 25.000,	 9.300 },
					{ 1.300,	 0.0370,	0.049, 	0.0529, 	 0.15,	 3.97,	 25.000,	 9.300 },
					{ 1.500,	 0.0372,	0.049, 	0.0569, 	 0.14,	 3.84,	 25.000,	 9.300 },
					{ 1.700,	 0.0375,	0.048, 	0.0600, 	 0.13,	 3.76,	 25.000,	 9.300 },
					{ 1.850,	 0.0377,	0.048, 	0.0629, 	 0.12,	 3.69,	 25.000,	 9.300 },
					{ 2.000,	 0.0384,	0.048, 	0.0659, 	 0.12,	 3.56,	 25.000,	 9.300 },
					{ 2.200,	 0.0390,	0.048, 	0.0689, 	 0.12, 	 3.45,	 25.000,	 9.300 }, 
																								
					{ 2.400,	 0.3300,	0.090, 	1.149, 		 1.69,	 0.70,	 25.000,	 9.300 },
					{ 2.500,	 0.6900,	0.040, 	1.35,		 1.10,	 0.70,	 25.000,	 9.300 },
					{ 3.900,	 0.6900,	0.040, 	1.35,		6.380,	 0.70,	 25.000, 	 9.300 },
            }, -- end of table
            -- M    - Mach number
            -- Cx0    - Coefficient, drag, profile, of the airplane
            -- Cya    - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
            -- B    - Polar quad coeff
            -- B4    - Polar 4th power coeff
            -- Omxmax    - roll rate, rad/s
            -- Aldop    - Alfadop Max AOA at current M - departure threshold
            -- Cymax    - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
        }, -- end of aerodynamics

        engine = {
            Nmg        = 60.05,    -- RPM at idle
            MinRUD     = 0,    -- Min state of the throttle
            MaxRUD     = 1,    -- Max state of the throttle
            MaksRUD    = 0.85,    -- Military power state of the throttle
            ForsRUD    = 0.91,    -- Afterburner state of the throttle
            typeng     = 1,
                --[[
                    E_TURBOJET = 0
                    E_TURBOJET_AB = 1
                    E_PISTON = 2
                    E_TURBOPROP = 3
                    E_TURBOFAN    = 4
                    E_TURBOSHAFT = 5
                --]]
            hMaxEng    = 17,        -- Max altitude for safe engine operation in km
            dcx_eng    = 0.0124,    -- Engine drag coeficient
            cemax      = 1.24,      -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            cefor      = 2.56,      -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            dpdh_m     = 2500,      --  altitude coefficient for max thrust. Higher value means lower thrust at high altitudes
            dpdh_f     = 2500,      --  altitude coefficient for AB thrust
            table_data = {
            --            M     Pmax    	 Pfor
                [1]  =  { 0.00, 44453*1.45,  75230 },
                [2]  =  { 0.20, 43262*1.40,  75230 },
                [3]  =  { 0.30, 44896*1.33,  75230 },
                [4]  =  { 0.40, 45535*1.33,  81230 },
                [5]  =  { 0.50, 47803*1.33,  85230 },
                [6]  =  { 0.60, 49979*1.33,  85230 },
                [7]  =  { 0.70, 51133*1.33,  97896 },
                [8]  =  { 0.80, 52093*1.33,  98147 },
                [9]  =  { 0.97, 49117*1.0,  99727 },
                [10] =  { 1.00, 49651*0.8,  100451 },
                [11] =  { 1.05, 48569*0.9,  111151 },
                [12] =  { 1.10, 43486*0.9,  111121 },
                [13] =  { 1.15, 40698*0.9,  115076 },
                [14] =  { 1.20, 36910*0.9,  117101 },
                [15] =  { 1.30, 33933*0.9,  118449 },
                [16] =  { 1.40, 32150*0.9,  113915 },
                [17] =  { 1.50, 30362*0.9,  110733 },
                [18] =  { 1.60, 28579*0.9,  110436 },
                [19] =  { 1.70, 26791*0.9,  114836 },
                [20] =  { 1.85, 25003*0.9,  114436 },
                [21] =  { 1.90, 24220*0.9,  110917 },
				[22] =  { 2.00, 23220*0.9,  109117 },
                [23] =  { 2.20, 19649*0.9,  98079 },
				[24] =  { 3.90, 16649*0.9,  61279 },
            }, -- end of table_data
            -- M    - Mach number
            -- Pmax    - Engine thrust at military power
            -- Pfor    - Engine thrust at AFB
        }, -- end of engine
    },


    fires_pos = {
        [1] = {-3.484, -0.004, -0.149}, -- After maingear, fuselage bottom
        [2] = {-2.518,  0.055,  1.216}, -- Wing inner Left
        [3] = {-2.518,  0.055, -1.216}, -- Wing inner Right
        [4] = {-6.250,  0.525,  0.000}, -- Engine damage big
        [5] = {-6.750,  0.525,  0.000}, -- Engine damage small
        [6] = {-2.346, -0.448,  0.000}, -- Air intake bottom L
        [7] = { 2.346, -0.448,  0.000}, -- Air intake bottom R
    }, -- end of fires_pos

    effects_presets = {
        { effect = 'OVERWING_VAPOR',    file = current_mod_path .. '/Effects/JF-17_overwingVapor.lua', preset = "JF17" },

        -- TODO: NOT WORK
        --{ effect = "APU_STARTUP_BLAST", file = current_mod_path .. '/Effects/JF-17_JFS_Blast.lua', preset = "JF17", ttl = 3.0, },
        --{ effect = 'LERX_VORTEX',       file = current_mod_path .. '/Effects/JF-17_LERXVortex.lua', preset = 'JF17', },
    },
----------------------------------------------------------------------------------------
-- Damage
----------------------------------------------------------------------------------------
    Damage = {
        [0]   = {critical_damage =    3, args = {82}},                                 -- NOSE_CENTER             /雷达罩
        [1]   = {critical_damage =    3, args = {150}},                                -- NOSE_LEFT_SIDE          /机头左侧
        [2]   = {critical_damage =    3, args = {149}},                                -- NOSE_RIGHT_SIDE         /机头右侧
        [3]   = {critical_damage =    2, args = {65}},                                 -- COCKPIT                 /座舱盖区域
        [4]   = {critical_damage =    2, args = {298}},                                -- CABIN_LEFT_SIDE         /座舱左侧
        [5]   = {critical_damage =    2, args = {301}},                                -- CABIN_RIGHT_SIDE        /座舱右侧
        [6]   = {critical_damage =    3, args = {299}},                                -- CABIN_BOTTOM            /座舱底部
        [7]   = {critical_damage =    2, args = {296}},                                -- GUN                     /机炮
        [8]   = {critical_damage =    2, args = {265}},                                -- FRONT_GEAR_BOX          /前起落架舱
        [9]   = {critical_damage =    3, args = {154}},                                -- FUSELAGE_LEFT_SIDE      /机身左侧
        [10]  = {critical_damage =    3, args = {153}},                                -- FUSELAGE_RIGHT_SIDE     /机身右侧
        [11]  = {critical_damage =  1.5, args = {271}},                                -- ENGINE                  /发动机喷口
        [13]  = {critical_damage =    2, args = {166}},                                -- MTG_L_BOTTOM            /发动机左下侧蒙皮
        [14]  = {critical_damage =    2, args = {160}},                                -- MTG_R_BOTTOM            /发动机右下侧蒙皮
        [15]  = {critical_damage =    2, args = {267}},                                -- LEFT_GEAR_BOX           /左主起落架舱盖
        [16]  = {critical_damage =    2, args = {266}},                                -- RIGHT_GEAR_BOX          /右主起落架舱盖
        [17]  = {critical_damage =    2, args = {168}},                                -- MTG_L                   /发动机左上侧蒙皮
        [18]  = {critical_damage =    2, args = {162}},                                -- MTG_R                   /发动机右上侧蒙皮
        [19]  = {critical_damage =    1, args = {189}},                                -- AIR_BRAKE_L             /左下侧减速板
        [20]  = {critical_damage =    1, args = {187}},                                -- AIR_BRAKE_R             /右下侧减速板
        [21]  = {critical_damage =  1.5, args = {232},
                droppable = true,  droppable_shape = "JF-17-oblomok-L-part"},          -- WING_L_PART_OUT         /左翼外侧前缘襟翼
        [22]  = {critical_damage =  1.5, args = {222},
                droppable = true,  droppable_shape = "JF-17-oblomok-R-part"},          -- WING_R_PART_OUT         /右翼外侧前缘襟翼
        [23]  = {critical_damage =    4, args = {223}, deps_cells = {21,25}},          -- WING_L_OUT              /左翼外侧
        [24]  = {critical_damage =    4, args = {213}, deps_cells = {22,26}},          -- WING_R_OUT              /右翼外侧
        [25]  = {critical_damage =    2, args = {226},
                droppable = true,  droppable_shape = "JF-17-oblomok-L-part"},          -- AILERON_L               /左侧副翼
        [26]  = {critical_damage =    2, args = {216},
                droppable = true,  droppable_shape = "JF-17-oblomok-R-part"},          -- AILERON_R               /右侧副翼
        [27]  = {critical_damage =    1, args = {185}},                                -- WING_L_PART_CENTER      /左上侧减速板
        [28]  = {critical_damage =    1, args = {183}},                                -- WING_R_PART_CENTER      /右上侧减速板
        [29]  = {critical_damage =    5, args = {224}, deps_cells = {23,33,37}},       -- WING_L_CENTER           /左翼中间
        [30]  = {critical_damage =    5, args = {214}, deps_cells = {24,34,38}},       -- WING_R_CENTER           /右翼中间
        [33]  = {critical_damage =  1.5, args = {230},
                droppable = true,  droppable_shape = "JF-17-oblomok-L-part"},          -- WING_L_PART_IN          /左翼内侧前缘襟翼
        [34]  = {critical_damage =  1.5, args = {220},
                droppable = true,  droppable_shape = "JF-17-oblomok-R-part"},          -- WING_R_PART_IN          /右翼内侧前缘襟翼
        [35]  = {critical_damage =    6, args = {225}, deps_cells = {29},
                droppable = true,  droppable_shape = "JF-17-oblomok-wing-L"},          -- WING_L_IN               /左翼内侧
        [36]  = {critical_damage =    6, args = {215}, deps_cells = {30},
                droppable = true,  droppable_shape = "JF-17-oblomok-wing-R"},          -- WING_R_IN               /右翼内侧
        [37]  = {critical_damage =    2, args = {228},
                droppable = true,  droppable_shape = "JF-17-oblomok-L-part"},          -- FLAP_L                  /左侧襟翼
        [38]  = {critical_damage =    2, args = {218},
                droppable = true,  droppable_shape = "JF-17-oblomok-R-part"},          -- FLAP_R                  /右侧襟翼
        [40]  = {critical_damage =    2, args = {241}, deps_cells = {53},
                droppable = false},                                                    -- FIN_R_TOP               /垂尾顶部
        [42]  = {critical_damage =    3, args = {242}, deps_cells = {40},},            -- FIN_R_CENTER            /垂尾根部
        [43]  = {critical_damage =    2, args = {246}},                                -- Line_KIL_L              /左侧腹鳍
        [44]  = {critical_damage =    2, args = {243}},                                -- Line_KIL_R              /右侧腹鳍
        [49]  = {critical_damage =  1.5, args = {239}},                                -- ELEVATOR_L_OUT          /左侧平尾外侧
        [50]  = {critical_damage =  1.5, args = {237}},                                -- ELEVATOR_R_OUT          /右侧平尾外侧
        [51]  = {critical_damage =    2, args = {240}, deps_cells = {49}},             -- ELEVATOR_L_IN           /左侧平尾内侧
        [52]  = {critical_damage =    2, args = {238}, deps_cells = {50}},             -- ELEVATOR_R_IN           /右侧平尾内侧
        [53]  = {critical_damage =    2, args = {247},},                               -- RUDDER                  /方向舵
        [55]  = {critical_damage =    4, args = {155}, deps_cells = {42,58}},          -- TAIL                    /垂尾根部尾椎
        [56]  = {critical_damage =    3, args = {158}},                                -- TAIL_LEFT_SIDE          /发动机左侧尾椎
        [57]  = {critical_damage =    3, args = {157}},                                -- TAIL_RIGHT_SIDE         /发动机右侧尾椎
        [58]  = {critical_damage =    1, args = {159}},                                -- TAIL_BOTTOM             /减速伞盖
        [59]  = {critical_damage =    3, args = {148}},                                -- NOSE_BOTTOM             /机头底部
        [61]  = {critical_damage =    3, args = {303}},                                -- FUEL_TANK_LEFT_SIDE     /机背油箱处左侧蒙皮
        [62]  = {critical_damage =    3, args = {302}},                                -- FUEL_TANK_RIGHT_SIDE    /机背油箱处右侧蒙皮
        [63]  = {critical_damage =    2, args = {147}},                                -- ROTOR                   /机头顶部
        [64]  = {critical_damage =    3, args = {227}},                                -- BLADE_1_IN              /左上侧进气道
        [65]  = {critical_damage =  1.5, args = {231}},                                -- BLADE_1_CENTER          /左侧边条
        [66]  = {critical_damage =    3, args = {229}},                                -- BLADE_1_OUT             /左下侧进气道
        [67]  = {critical_damage =    3, args = {217}},                                -- BLADE_2_IN              /右上侧进气道
        [68]  = {critical_damage =  1.5, args = {221}},                                -- BLADE_2_CENTER          /右侧边条
        [69]  = {critical_damage =    3, args = {219}},                                -- BLADE_2_OUT             /右下侧进气道
        [71]  = {critical_damage =    3, args = {156}},                                -- BLADE_3_CENTER          /进气道处机腹
        [82]  = {critical_damage =    3, args = {152}},                                -- FUSELAGE_BOTTOM         /机身底部
        [83]  = {critical_damage =    2, args = {134}},                                -- WHEEL_F                 /前起落架
        [84]  = {critical_damage =    3, args = {136}},                                -- WHEEL_L                 /左侧主起落架
        [85]  = {critical_damage =    3, args = {135}},                                -- WHEEL_R                 /右侧主起落架
        [90]  = {critical_damage =    1},                                              -- PILOT
        [99]  = {critical_damage =    2, args = {151}},                                -- FUSELAGE_TOP            /前部脊背
        [100] = {critical_damage =    2, args = {300}},                                -- TAIL_TOP                /后部脊背
    },

    DamageParts =
    {
        [1] = "JF-17-oblomok-wing-L",
        [2] = "JF-17-oblomok-wing-R",
        [3] = "JF-17-oblomok-L-part",
        [4] = "JF-17-oblomok-R-part",
        -- [5] = "JF-17-oblomok-tail",
        -- [6] = "JF-17-oblomok-Rudder",
    },
----------------------------------------------------------------------------------------
-- Failures
----------------------------------------------------------------------------------------
    Failures = {
        -- power system
        {
            id = 'EMMC_FAILURE_BATTERY_DC1',
            label = _('EMMC_FAILURE_BATTERY_DC1'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_BATTERY_DC2',
            label = _('EMMC_FAILURE_BATTERY_DC2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_BATTERY_FCS1',
            label = _('EMMC_FAILURE_BATTERY_FCS1'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_BATTERY_FCS2',
            label = _('EMMC_FAILURE_BATTERY_FCS2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DC_GENERATOR_VOLTAGE_LOW',
            label = _('EMMC_FAILURE_DC_GENERATOR_VOLTAGE_LOW'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DC_GENERATOR_VOLTAGE_HIGH',
            label = _('EMMC_FAILURE_DC_GENERATOR_VOLTAGE_HIGH'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DC_GENERATOR',
            label = _('EMMC_FAILURE_DC_GENERATOR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DC_GENERATOR_CONTROLLER',
            label = _('EMMC_FAILURE_DC_GENERATOR_CONTROLLER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DC_GENERATOR_SUBSYSTEM',
            label = _('EMMC_FAILURE_DC_GENERATOR_SUBSYSTEM'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_AC_GENERATOR_FEED_LINE',
            label = _('EMMC_FAILURE_AC_GENERATOR_FEED_LINE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_AC_GENERATOR_CONTROLLER',
            label = _('EMMC_FAILURE_AC_GENERATOR_CONTROLLER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_AC_GENERATOR',
            label = _('EMMC_FAILURE_AC_GENERATOR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_AC_GENERATOR_SUBSYSTEM',
            label = _('EMMC_FAILURE_AC_GENERATOR_SUBSYSTEM'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_TRU_AC2DC28V',
            label = _('EMMC_FAILURE_TRU_AC2DC28V'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_SCU_AC2AC36V',
            label = _('EMMC_FAILURE_SCU_AC2AC36V'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_SCU_DC2AC36V',
            label = _('EMMC_FAILURE_SCU_DC2AC36V'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_SCU_DC2AC115V',
            label = _('EMMC_FAILURE_SCU_DC2AC115V'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_AC_GROUND',
            label = _('EMMC_FAILURE_AC_GROUND'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- ext light failures
        {
            id = 'FAILURE_EXT_LIGHT_NAV_LEFT',
            label = _('FAILURE_EXT_LIGHT_NAV_LEFT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_NAV_RIGHT',
            label = _('FAILURE_EXT_LIGHT_NAV_RIGHT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_NAV_TAIL',
            label = _('FAILURE_EXT_LIGHT_NAV_TAIL'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_ANTICOL',
            label = _('FAILURE_EXT_LIGHT_ANTICOL'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_FORMATION_LEFT',
            label = _('FAILURE_EXT_LIGHT_FORMATION_LEFT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_FORMATION_RIGHT',
            label = _('FAILURE_EXT_LIGHT_FORMATION_RIGHT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_TAXI',
            label = _('FAILURE_EXT_LIGHT_TAXI'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_EXT_LIGHT_LAND',
            label = _('FAILURE_EXT_LIGHT_LAND'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- Hydro failures
        {
            id = 'FAILURE_HYDRAULICS_EMERGE',
            label = _('FAILURE_HYDRAULICS_EMERGE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_EMERGE_ACCU',
            label = _('FAILURE_HYDRAULICS_EMERGE_ACCU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_1_PUMP',
            label = _('FAILURE_HYDRAULICS_1_PUMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_1_ACCU',
            label = _('FAILURE_HYDRAULICS_1_ACCU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_1_EXTERNAL_LEAKAGE',
            label = _('FAILURE_HYDRAULICS_1_EXTERNAL_LEAKAGE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_1_EXTERNAL_LEAKAGE_SEVERE',
            label = _('FAILURE_HYDRAULICS_1_EXTERNAL_LEAKAGE_SEVERE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_1_INTERNAL_LEAKAGE',
            label = _('FAILURE_HYDRAULICS_1_INTERNAL_LEAKAGE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_2_PUMP',
            label = _('FAILURE_HYDRAULICS_2_PUMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_2_ACCU',
            label = _('FAILURE_HYDRAULICS_2_ACCU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_2_EXTERNAL_LEAKAGE',
            label = _('FAILURE_HYDRAULICS_2_EXTERNAL_LEAKAGE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_2_EXTERNAL_LEAKAGE_SEVERE',
            label = _('FAILURE_HYDRAULICS_2_EXTERNAL_LEAKAGE_SEVERE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_HYDRAULICS_2_INTERNAL_LEAKAGE',
            label = _('FAILURE_HYDRAULICS_2_INTERNAL_LEAKAGE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- Oxygen failures
        {
            id = 'OXY_FAILURE_AUTO_100_O2',
            label = _('OXY_FAILURE_AUTO_100_O2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_AIR_O2_SWITCH',
            label = _('OXY_FAILURE_AIR_O2_SWITCH'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_HIGH_PRESS',
            label = _('OXY_FAILURE_HIGH_PRESS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_L_LEAK',
            label = _('OXY_FAILURE_L_LEAK'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_L_LEAK_SEVERE',
            label = _('OXY_FAILURE_L_LEAK_SEVERE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_R_LEAK',
            label = _('OXY_FAILURE_R_LEAK'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OXY_FAILURE_R_LEAK_SEVERE',
            label = _('OXY_FAILURE_R_LEAK_SEVERE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        ---- Nav related failures
        -- SHARS failure
        {
            id = 'SHARS_FAILURE_SENSOR',
            label = _('SHARS_FAILURE_SENSOR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- INS failure
        {
            id = 'INS_FAILURE_GYRO',
            label = _('INS_FAILURE_GYRO'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_FAILURE_ACC',
            label = _('INS_FAILURE_ACC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_FAILURE_DATA_INVALID',
            label = _('INS_FAILURE_DATA_INVALID'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        --[[{
            id = 'INS_GPS_NAV_MODE_ACTIVE',
            label = _('INS_GPS_NAV_MODE_ACTIVE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },]]
        {
            id = 'INS_FAILURE_ALGNMENT',
            label = _('INS_FAILURE_ALGNMENT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_FAILURE_ALT_INVALID',
            label = _('INS_FAILURE_ALT_INVALID'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_DATA_DEGRADED',
            label = _('INS_DATA_DEGRADED'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_WIND_INVALID',
            label = _('INS_WIND_INVALID'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_FAILURE_GPS_RECEIVER',
            label = _('INS_FAILURE_GPS_RECEIVER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'INS_PU_REJECTED',
            label = _('INS_PU_REJECTED'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- SNS receiver failures
        {
            id = 'SNS_FAILURE_ANTENNA',
            label = _('SNS_FAILURE_ANTENNA'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SNS_CABLE',
            label = _('SNS_FAILURE_CABLE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SNS_FAILURE_COMPUTER',
            label = _('SNS_FAILURE_COMPUTER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        ---- Defense
        -- RWR failures
        {
            id = 'RWR_FAILURE_ANTENNA_FRONT_LEFT',
            label = _('RWR_FAILURE_ANTENNA_FRONT_LEFT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_ANTENNA_REAR_LEFT',
            label = _('RWR_FAILURE_ANTENNA_REAR_LEFT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_ANTENNA_FRONT_RIGHT',
            label = _('RWR_FAILURE_ANTENNA_FRONT_RIGHT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_ANTENNA_REAR_RIGHT',
            label = _('RWR_FAILURE_ANTENNA_REAR_RIGHT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_RECEIVER_XX1',
            label = _('RWR_FAILURE_RECEIVER_XX1'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_RECEIVER_XX2',
            label = _('RWR_FAILURE_RECEIVER_XX2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_RECEIVER_XX3',
            label = _('RWR_FAILURE_RECEIVER_XX3'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_DB_NOT_LOADED',
            label = _('RWR_FAILURE_DB_NOT_LOADED'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RWR_FAILURE_COMPUTER',
            label = _('RWR_FAILURE_COMPUTER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- OESP failures
        {
            id = 'OESP_FAILURE_FL_DISP_L',
            label = _('OESP_FAILURE_FL_DISP_L'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OESP_FAILURE_FL_DISP_R',
            label = _('OESP_FAILURE_FL_DISP_R'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OESP_FAILURE_CH_DISP_L',
            label = _('OESP_FAILURE_CH_DISP_L'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OESP_FAILURE_CH_DISP_R',
            label = _('OESP_FAILURE_CH_DISP_R'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OESP_FAILURE_MAWS_L',
            label = _('OESP_FAILURE_MAWS_L'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'OESP_FAILURE_MAWS_R',
            label = _('OESP_FAILURE_MAWS_R'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        ---- Weapon
        -- SMS failures
        {
            id = 'FAILURE_SMS_PYLON_1',
            label = _('FAILURE_SMS_PYLON_1'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_2',
            label = _('FAILURE_SMS_PYLON_2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_3',
            label = _('FAILURE_SMS_PYLON_3'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_4',
            label = _('FAILURE_SMS_PYLON_4'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_5',
            label = _('FAILURE_SMS_PYLON_5'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_6',
            label = _('FAILURE_SMS_PYLON_6'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'FAILURE_SMS_PYLON_7',
            label = _('FAILURE_SMS_PYLON_7'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        ---- Misc
        -- DTC failures
        {
            id = 'DTC_FAILURE_CARD_BROKEN',
            label = _('DTC_FAILURE_CARD_BROKEN'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'DTC_FAILURE_DATA_CRC',
            label = _('DTC_FAILURE_DATA_CRC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'DTC_FAILURE_DATA_DECIPHER',
            label = _('DTC_FAILURE_DATA_DECIPHER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'DTC_FAILURE_READER_BROKEN',
            label = _('DTC_FAILURE_READER_BROKEN'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- radar
        {
            id = 'RDR_FAILURE_ARRAY',
            label = _('RDR_FAILURE_ARRAY'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_PEDESTAL',
            label = _('RDR_FAILURE_PEDESTAL'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_SERVOLOOP',
            label = _('RDR_FAILURE_SERVOLOOP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_RX_FRONT_END',
            label = _('RDR_FAILURE_RX_FRONT_END'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_RECEIVER',
            label = _('RDR_FAILURE_RECEIVER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_TRANSMITTER',
            label = _('RDR_FAILURE_TRANSMITTER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_PROCESSOR',
            label = _('RDR_FAILURE_PROCESSOR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_ANTENNA_DEGRATION',
            label = _('RDR_FAILURE_ANTENNA_DEGRATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_RX_FRONT_END_DEGRATION',
            label = _('RDR_FAILURE_RX_FRONT_END_DEGRATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_RECEIVER_DEGRATION',
            label = _('RDR_FAILURE_RECEIVER_DEGRATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_TRANSMITTER_DEGRATION',
            label = _('RDR_FAILURE_TRANSMITTER_DEGRATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_PROCESSOR_DEGRATION',
            label = _('RDR_FAILURE_PROCESSOR_DEGRATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_TRANSMITTER_OVERHEAT',
            label = _('RDR_FAILURE_TRANSMITTER_OVERHEAT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_PROCESSOR_OVERHEAT',
            label = _('RDR_FAILURE_PROCESSOR_OVERHEAT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_SERVO_OVERHEAT',
            label = _('RDR_FAILURE_SERVO_OVERHEAT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_PREESURIZATION',
            label = _('RDR_FAILURE_PREESURIZATION'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'RDR_FAILURE_DEGRATED_PERFORMANCE',
            label = _('RDR_FAILURE_DEGRATED_PERFORMANCE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- WCS
        {
            id = 'MWMMC_FAILURE',
            label = _('MWMMC_FAILURE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_CPU',
            label = _('MWMMC_FAILURE_CPU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_IOC',
            label = _('MWMMC_FAILURE_IOC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_MBI',
            label = _('MWMMC_FAILURE_MBI'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_AVI',
            label = _('MWMMC_FAILURE_AVI'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_DMP',
            label = _('MWMMC_FAILURE_DMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_PS',
            label = _('MWMMC_FAILURE_PS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_EMMC',
            label = _('MWMMC_FAILURE_1553B_EMMC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_FCS',
            label = _('MWMMC_FAILURE_1553B_FCS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_IFF',
            label = _('MWMMC_FAILURE_1553B_IFF'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_ILS',
            label = _('MWMMC_FAILURE_1553B_ILS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_INS',
            label = _('MWMMC_FAILURE_1553B_INS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_LMFCD',
            label = _('MWMMC_FAILURE_1553B_LMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_CMFCD',
            label = _('MWMMC_FAILURE_1553B_CMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_RMFCD',
            label = _('MWMMC_FAILURE_1553B_RMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_RDR',
            label = _('MWMMC_FAILURE_1553B_RDR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_OESP',
            label = _('MWMMC_FAILURE_1553B_OESP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_RALT',
            label = _('MWMMC_FAILURE_1553B_RALT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_RWR',
            label = _('MWMMC_FAILURE_1553B_RWR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_SAIU',
            label = _('MWMMC_FAILURE_1553B_SAIU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_HUD',
            label = _('MWMMC_FAILURE_1553B_HUD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_SPJ',
            label = _('MWMMC_FAILURE_1553B_SPJ'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'MWMMC_FAILURE_1553B_TACAN',
            label = _('MWMMC_FAILURE_1553B_TACAN'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE',
            label = _('SWMMC_FAILURE'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_CPU',
            label = _('SWMMC_FAILURE_CPU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_IOC',
            label = _('SWMMC_FAILURE_IOC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_MBI',
            label = _('SWMMC_FAILURE_MBI'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_AVI',
            label = _('SWMMC_FAILURE_AVI'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_DMP',
            label = _('SWMMC_FAILURE_DMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_PS',
            label = _('SWMMC_FAILURE_PS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_CTVS',
            label = _('SWMMC_FAILURE_CTVS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_HUD',
            label = _('SWMMC_FAILURE_HUD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_LMFCD',
            label = _('SWMMC_FAILURE_LMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_CMFCD',
            label = _('SWMMC_FAILURE_CMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_RMFCD',
            label = _('SWMMC_FAILURE_RMFCD'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_AAP_NO_RS422_COMM',
            label = _('SWMMC_AAP_NO_RS422_COMM'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_AAP',
            label = _('SWMMC_FAILURE_AAP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_DVR_NO_RS422_COMM',
            label = _('SWMMC_DVR_NO_RS422_COMM'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_DVR',
            label = _('SWMMC_FAILURE_DVR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_CSU_NO_RS422_COMM',
            label = _('SWMMC_CSU_NO_RS422_COMM'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'SWMMC_FAILURE_CSU',
            label = _('SWMMC_FAILURE_CSU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        ---- EMMC MISC
        {
            id = 'EMMC_FAILURE_DADS',
            label = _('EMMC_FAILURE_DADS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_LANDING_GEAR',
            label = _('EMMC_FAILURE_LANDING_GEAR'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_FUEL_LOW_LEVEL',
            label = _('EMMC_FAILURE_FUEL_LOW_LEVEL'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_FUEL_START_PUMP',
            label = _('EMMC_FAILURE_FUEL_START_PUMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_FUEL_LOWER_PUMP',
            label = _('EMMC_FAILURE_FUEL_LOWER_PUMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_FUEL_UPPER_PUMP',
            label = _('EMMC_FAILURE_FUEL_UPPER_PUMP'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_CANOPY_UNLOCK',
            label = _('EMMC_FAILURE_CANOPY_UNLOCK'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_COCKPIT_PRESSURE_LOW',
            label = _('EMMC_FAILURE_COCKPIT_PRESSURE_LOW'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_TRU',
            label = _('EMMC_FAILURE_TRU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_LWC',
            label = _('EMMC_FAILURE_LWC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_EMMC',
            label = _('EMMC_FAILURE_EMMC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_PROBES_HEATING',
            label = _('EMMC_FAILURE_PROBES_HEATING'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_STATIC_INVERTER',
            label = _('EMMC_FAILURE_STATIC_INVERTER'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_ECS_OFF',
            label = _('EMMC_FAILURE_ECS_OFF'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_ELECT_EQUIP_HOT',
            label = _('EMMC_FAILURE_ELECT_EQUIP_HOT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_SHARS',
            label = _('EMMC_FAILURE_SHARS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_BAU',
            label = _('EMMC_FAILURE_BAU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DADS_RPTU',
            label = _('EMMC_FAILURE_DADS_RPTU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DADS_LPTU',
            label = _('EMMC_FAILURE_DADS_LPTU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'EMMC_FAILURE_DADS_MPTU',
            label = _('EMMC_FAILURE_DADS_MPTU'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },

        -- CNI
        {
            id = 'CNI_FAILURE_COM1',
            label = _('CNI_FAILURE_COM1'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_COM1_SECOS',
            label = _('CNI_FAILURE_COM1_SECOS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_COM2',
            label = _('CNI_FAILURE_COM2'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_COM2_SECOS',
            label = _('CNI_FAILURE_COM2_SECOS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_TACAN',
            label = _('CNI_FAILURE_TACAN'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_ILS',
            label = _('CNI_FAILURE_ILS'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_IFF_TX',
            label = _('CNI_FAILURE_IFF_TX'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_IFF_RX',
            label = _('CNI_FAILURE_IFF_RX'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        {
            id = 'CNI_FAILURE_RALT',
            label = _('CNI_FAILURE_RALT'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        -- ZCP
        {
            id = 'ZCP_FAILURE_MALFUNC',
            label = _('ZCP_FAILURE_MALFUNC'),
            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100
        },
        { id = 'FCS_FAILURE_COMP_1', label = _('FCS_FAILURE_COMP_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_COMP_2', label = _('FCS_FAILURE_COMP_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_COMP_3', label = _('FCS_FAILURE_COMP_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_COMP_4', label = _('FCS_FAILURE_COMP_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_ELEC_A', label = _('FCS_FAILURE_L_ELEVATOR_ELEC_A'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_ELEC_B', label = _('FCS_FAILURE_L_ELEVATOR_ELEC_B'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_ELEC_C', label = _('FCS_FAILURE_L_ELEVATOR_ELEC_C'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_ELEC_D', label = _('FCS_FAILURE_L_ELEVATOR_ELEC_D'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_ELEC_A', label = _('FCS_FAILURE_R_ELEVATOR_ELEC_A'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_ELEC_B', label = _('FCS_FAILURE_R_ELEVATOR_ELEC_B'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_ELEC_C', label = _('FCS_FAILURE_R_ELEVATOR_ELEC_C'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_ELEC_D', label = _('FCS_FAILURE_R_ELEVATOR_ELEC_D'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_HYD_1', label = _('FCS_FAILURE_L_ELEVATOR_HYD_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_L_ELEVATOR_HYD_2', label = _('FCS_FAILURE_L_ELEVATOR_HYD_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_HYD_1', label = _('FCS_FAILURE_R_ELEVATOR_HYD_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_R_ELEVATOR_HYD_2', label = _('FCS_FAILURE_R_ELEVATOR_HYD_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_ELEC_SERVO_1', label = _('FCS_FAILURE_ROLL_ELEC_SERVO_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_ELEC_SERVO_2', label = _('FCS_FAILURE_ROLL_ELEC_SERVO_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_ELEC_SERVO_1', label = _('FCS_FAILURE_YAW_ELEC_SERVO_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_ELEC_SERVO_2', label = _('FCS_FAILURE_YAW_ELEC_SERVO_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_RATE_GYRO_1', label = _('FCS_FAILURE_PITCH_RATE_GYRO_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_RATE_GYRO_2', label = _('FCS_FAILURE_PITCH_RATE_GYRO_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_RATE_GYRO_3', label = _('FCS_FAILURE_PITCH_RATE_GYRO_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_RATE_GYRO_4', label = _('FCS_FAILURE_PITCH_RATE_GYRO_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_RATE_GYRO_1', label = _('FCS_FAILURE_ROLL_RATE_GYRO_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_RATE_GYRO_2', label = _('FCS_FAILURE_ROLL_RATE_GYRO_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_RATE_GYRO_1', label = _('FCS_FAILURE_YAW_RATE_GYRO_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_RATE_GYRO_2', label = _('FCS_FAILURE_YAW_RATE_GYRO_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NZ_SENSOR_1', label = _('FCS_FAILURE_NZ_SENSOR_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NZ_SENSOR_2', label = _('FCS_FAILURE_NZ_SENSOR_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NZ_SENSOR_3', label = _('FCS_FAILURE_NZ_SENSOR_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NZ_SENSOR_4', label = _('FCS_FAILURE_NZ_SENSOR_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NY_SENSOR_1', label = _('FCS_FAILURE_NY_SENSOR_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_NY_SENSOR_2', label = _('FCS_FAILURE_NY_SENSOR_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_LVDT_1', label = _('FCS_FAILURE_PITCH_LVDT_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_LVDT_2', label = _('FCS_FAILURE_PITCH_LVDT_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_LVDT_3', label = _('FCS_FAILURE_PITCH_LVDT_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_PITCH_LVDT_4', label = _('FCS_FAILURE_PITCH_LVDT_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_LVDT_1', label = _('FCS_FAILURE_ROLL_LVDT_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_LVDT_2', label = _('FCS_FAILURE_ROLL_LVDT_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_LVDT_1', label = _('FCS_FAILURE_YAW_LVDT_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_LVDT_2', label = _('FCS_FAILURE_YAW_LVDT_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_AOA_SENSOR_1', label = _('FCS_FAILURE_AOA_SENSOR_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_AOA_SENSOR_2', label = _('FCS_FAILURE_AOA_SENSOR_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_AOA_SENSOR_3', label = _('FCS_FAILURE_AOA_SENSOR_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_Q_SENSOR_1', label = _('FCS_FAILURE_Q_SENSOR_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_Q_SENSOR_2', label = _('FCS_FAILURE_Q_SENSOR_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_Q_SENSOR_3', label = _('FCS_FAILURE_Q_SENSOR_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_Q_SENSOR_4', label = _('FCS_FAILURE_Q_SENSOR_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_P_SENSOR_1', label = _('FCS_FAILURE_P_SENSOR_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_P_SENSOR_2', label = _('FCS_FAILURE_P_SENSOR_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_P_SENSOR_3', label = _('FCS_FAILURE_P_SENSOR_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_P_SENSOR_4', label = _('FCS_FAILURE_P_SENSOR_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_AUGD_1', label = _('FCS_FAILURE_ROLL_AUGD_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_ROLL_AUGD_2', label = _('FCS_FAILURE_ROLL_AUGD_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_AUGD_1', label = _('FCS_FAILURE_YAW_AUGD_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_YAW_AUGD_2', label = _('FCS_FAILURE_YAW_AUGD_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_EFCS_1', label = _('FCS_FAILURE_EFCS_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_EFCS_2', label = _('FCS_FAILURE_EFCS_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_WOW_1', label = _('FCS_FAILURE_WOW_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_WOW_2', label = _('FCS_FAILURE_WOW_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_WOW_3', label = _('FCS_FAILURE_WOW_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_WOW_4', label = _('FCS_FAILURE_WOW_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_LG_1', label = _('FCS_FAILURE_LG_1'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_LG_2', label = _('FCS_FAILURE_LG_2'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_LG_3', label = _('FCS_FAILURE_LG_3'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'FCS_FAILURE_LG_4', label = _('FCS_FAILURE_LG_4'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

        { id = 'ENGINE_FAILURE_AB_IGNITION_UNIT', label = _('ENGINE_FAILURE_AB_IGNITION_UNIT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_APD88_STARTER', label = _('ENGINE_FAILURE_APD88_STARTER'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_N1_COMPRESSOR', label = _('ENGINE_FAILURE_N1_COMPRESSOR'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_N2_COMPRESSOR', label = _('ENGINE_FAILURE_N2_COMPRESSOR'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_N1_TURBINE', label = _('ENGINE_FAILURE_N1_TURBINE'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_N2_TURBINE', label = _('ENGINE_FAILURE_N2_TURBINE'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_COMBUSTOR', label = _('ENGINE_FAILURE_COMBUSTOR'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_NOZZLE_CONTROLLER', label = _('ENGINE_FAILURE_NOZZLE_CONTROLLER'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'ENGINE_FAILURE_DEEC', label = _('ENGINE_FAILURE_DEEC'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
    },
----------------------------------------------------------------------------------------
-- Lights
----------------------------------------------------------------------------------------
    lights_data = {
        typename = 'collection',
        lights = {
            [WOLALIGHT_STROBES] = {
                typename = 'collection',
                lights   = {
                }
            },
            [WOLALIGHT_SPOTS] = { -- spot/landing
                typename = 'collection',
                lights   = {
                    {
                        typename = 'argumentlight',
                        argument = 208,
                    },
                    {
                        typename = 'argumentlight',
                        argument = 210,
                    },
                    {
                        typename = 'argumentlight',
                        argument = 211,
                    },
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {

            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = 'collection',
                lights   = {
                    { -- left wing
                        typename  = 'argumentlight', -- 'argumentlight',
                        argument  = 200,
                    },
                    { -- right wing
                        typename  = 'argumentlight', -- 'argumentlight',
                        argument  = 201,
                    },
                },
            },
            [WOLALIGHT_TIPS_LIGHTS] = {

            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = 'collection',
                lights   = {
                    {
                        typename = 'argumentlight',
                        argument = 209,
                    },
                    {
                        typename = 'argumentlight',
                        argument = 210,
                    },
                    {
                        typename = 'argumentlight',
                        argument = 211,
                    },
                },
            },
            -- customized
            [WOLALIGHT_CUSTOM_NAV] = {
                typename = 'collection',
                lights   = {
                    { -- tail
                        typename  = 'argumentlight',
                        argument  = 192,
                    },
                    { -- left inlet
                        typename  = 'argumentlight',
                        argument  = 190,
                    },
                    { -- right inlet
                        typename  = 'argumentlight',
                        argument  = 191,
                    },
                },
            },
            [WOLALIGHT_CUSTOM_ANTI] = {
                typename = 'collection',
                lights   = {
                    {
                        typename = 'argumentlight',
                        argument = 83,
                    },
                }
            },
        }, -- end of lights_data.lights
    }, -- end lights_data
}
add_aircraft(JF_17)
----------------------------------------------------------------------------------------
--                    File by whisky.actual@gmail.com - v.1.1.2                       --
----------------------------------------------------------------------------------------