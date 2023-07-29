
local sd10_name  = 'SD-10'
local sd10_mass  = 199.0
local sd10_model = 'pl12'
local pylon_mass = 90.0
local pylon_dual_mass = 160.0

local sd10_warhead = enhanced_a2a_warhead(24, 203)

SD_10_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = sd10_name,
    model           = sd10_model,
    user_name       = _(sd10_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    mass            = sd10_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {5, 5, 5},
    M               = sd10_mass,
    H_max           = 25000.0,
    H_min           = -1.0,
    Diam            = 203.0,
    Cx_pil          = 2.2,
    D_max           = 65000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 120.0,
    Nr_max          = 30,
    v_min           = 140.0,
    v_mid           = 1200.0,
    Mach_max        = 4.0,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 4.0,
    Range_max       = 65000.0,
    H_min_t         = 3.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 1.05,
    OmViz_max       = 0.52,
    exhaust         = tail_solid1;
    X_back          = -1.74,
    Y_back          = -0.11,
    Z_back          = 0.0,
    Reflection      = 0.045,
    KillDistance    = 11.0,

    warhead         = sd10_warhead,
    warhead_air     = sd10_warhead,

    shape_table_data = {
        {
            name     = sd10_name,
            file     = sd10_model,
            life     = 1,
            fire     = {0, 1},
            username = sd10_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    PN_coeffs = { 4,                 -- Number of Entries
                  12000.0, 1.00,
                  18000.0, 0.75,
                  30000.0, 0.50,     -- Less 5 km to target Pn = 1
                  48000.0, 0.20,     -- Between 15 and 5 km  to target, Pn smoothly changes from 0.4 to 1.0. Longer then 15 km Pn = 0.4.
                },

    supersonic_A_coef_skew = 0.1, -- slope of the direct polarity factor of the polar on supersonic
    nozzle_exit_area       = 0.025, -- the nozzle exit area

    class_name      = 'wAmmunitionSelfHoming',
    --scheme          = 'aa_missile_amraam2',
    scheme          = 'aa_missile_amraam',

    controller = {
        boost_start = 0.5,
        march_start = 6.5,
    },

    boost = {
        impulse                             = 242,
        fuel_mass                           = 57.6,
        work_time                           = 6.0,
        nozzle_position                     = {{-1.74, -0.11, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.01219,
        tail_width                          = 0.4,
        smoke_color                         = {1.0, 1.0, 1.0},
        smoke_transparency                  = 0.5,
        custom_smoke_dissipation_factor     = 0.2,
    },

    march = {
        impulse                             = 236,
        fuel_mass                           = 11.6,
        work_time                           = 4.0,
        nozzle_position                     = {{-1.74, -0.11, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.01219,
        tail_width                          = 0.4,
        smoke_color                         = {1.0, 1.0, 1.0},
        smoke_transparency                  = 0.5,
        custom_smoke_dissipation_factor     = 0.2,

    },

    fm = {
        mass                = sd10_mass,
        caliber             = 0.203,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 0,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        draw_fins_conv      = {math.rad(90),1,1},
        L                   = 0.203,
        S                   = 0.0324,
        Ix                  = 1.5,
        Iy                  = 190,
        Iz                  = 190,

        Mxd                 = 0.1 * 57.3,
        Mxw                 = -15.8,

        table_scale         = 0.2,
        table_degree_values = 1,
        -- Mach   | 0.0        0.2        0.4        0.6        0.8         1.0        1.2         1.4         1.6          1.8          2.0          2.2         2.4         2.6         2.8         3.0         3.2         3.4         3.6         3.8         4.0         4.2         4.4         4.6         4.8         5.0 |
        Cx0 = {    0.4727,    0.4727,    0.4727,    0.4727,    0.4838,    0.7609,     0.8869,     0.86198,    0.81793,     0.76899,     0.72481,     0.68476,    0.64836,    0.61529,    0.58515,    0.55744,    0.53195,    0.50829,    0.48624,    0.46561,    0.4461,     0.42772,    0.41035,    0.3941,     0.37898,    0.366    },
        CxB = {    0.021,     0.021,     0.021,     0.021,     0.021,     0.138,      0.153,      0.146,      0.1382,      0.1272,      0.1167,      0.1073,     0.0987,     0.0909,     0.0837,     0.077,      0.0708,     0.065,      0.0595,     0.0544,     0.0495,     0.0449,     0.0406,     0.0364,     0.0324,     0.0286    },
        K1  = {    0.00264,   0.00264,   0.00264,   0.00264,   0.00264,   0.00264,    0.0022,     0.001873,   0.0016435,   0.0014752,   0.0013448,   0.0012436,  0.0011534,  0.0010742,  0.0010149,  0.0009484,  0.0009016,  0.0008476,  0.000795,   0.0007529,  0.0007122,  0.0006727,  0.0006343,  0.0006058,  0.0005781,  0.00056    },
        K2  = {    -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00265,   -0.002274,  -0.002034,  -0.0018241,  -0.0016225,  -0.0014468,  -0.001275,  -0.0011248, -0.0009777, -0.0008514, -0.0007274, -0.0006236, -0.0005217, -0.0004393, -0.0003584, -0.0002968, -0.0002363, -0.0001949, -0.0001546, -0.0001335, -0.000114    },
        Cya = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Cza = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Mya = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Mza = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Myw = {    -9.55874,  -9.55874,  -9.55874,  -9.55874,  -9.81248,  -12.17459,  -10.86314,  -10.80419,  -10.7503,    -10.67431,   -10.57881,   -10.46632,  -10.33913,  -10.19945,  -10.04929,  -9.89055,   -9.72493,   -9.55397,   -9.37918,   -9.20172,   -9.02292,   -8.84372,   -8.66508,   -8.48791,   -8.31347,   -8.14394    },
        Mzw = {    -9.55874,  -9.55874,  -9.55874,  -9.55874,  -9.81248,  -12.17459,  -10.86314,  -10.80419,  -10.7503,    -10.67431,   -10.57881,   -10.46632,  -10.33913,  -10.19945,  -10.04929,  -9.89055,   -9.72493,   -9.55397,   -9.37918,   -9.20172,   -9.02292,   -8.84372,   -8.66508,   -8.48791,   -8.31347,   -8.14394    },
        A1trim = { 27.6,      27.6,      27.6,      27.6,      27.55,     30.38,      31.982,     32.774,     33.234,      33.561,      33.829,      34.07,      34.286,     34.491,     34.687,     34.875,     35.056,     35.232,     35.401,     35.564,     35.721,     35.871,     36.015,     36.151,     36.279,     36.4    },
        A2trim = { 27.6,      27.6,      27.6,      27.6,      27.55,     30.38,      31.982,     32.774,     33.234,      33.561,      33.829,      34.07,      34.286,     34.491,     34.687,     34.875,     35.056,     35.232,     35.401,     35.564,     35.721,     35.871,     36.015,     36.151,     36.279,     36.4    },


        model_roll = math.rad(45),
        fins_stall = 1,
    },

    seeker = {
        delay                       = 1.5,
        op_time                     = 100,
        FOV                         = math.rad(120),
        max_w_LOS                   = math.rad(30),
        sens_near_dist              = 100,
        sens_far_dist               = 30000,
        ccm_k0                      = 0.12,
        aim_sigma                   = 7,
        height_error_k              = 20,
        height_error_max_vel        = 50,
        height_error_max_h          = 300,
        hoj                         = 1,
        rad_correction              = 1,
        active_radar_lock_dist      = 18000.0,
        active_dist_trig_by_default = 1,
    },
    
    gimbal = {
        delay                = 0,
        op_time              = 95,
        pitch_max            = math.rad(60),
        yaw_max              = math.rad(60),
        max_tracking_rate    = math.rad(30),
        tracking_gain        = 40,
    },

    autopilot = {
        delay                = 1.0,
        op_time              = 100,
        Tf                   = 0.1,
        Knav                 = 4.0,
        Kd                   = 180.0,
        Ka                   = 16.0,
        T1                   = 309.0,
        Tc                   = 0.06,
        Kx                   = 0.1,
        Krx                  = 2.0,
        gload_limit          = 30.0,
        fins_limit           = math.rad(24),
        fins_limit_x         = math.rad(5),
        null_roll            = math.rad(45),
        accel_coeffs         = { 0, 11.5,-1.2,-0.25, 24.0,
                                 0.0324 * 0.75 * 0.0091 },

        loft_active          = 1,
        loft_factor          = 4.5,
        loft_sin             = math.sin(30/57.3),
        loft_min_range       = 30000,
        loft_off_range       = 18000,
        dV0                  = 393,
    },

    actuator = {
        Tf                   = 0.005,
        D                    = 250.0,
        T1                   = 0.002,
        T2                   = 0.006,
        max_omega            = math.rad(400),
        max_delta            = math.rad(20),
        fin_stall            = 1,
        sim_count            = 4,
    },

    proximity_fuze = {
        radius      = 10.0,
        arm_delay   = 1.6,
    },

    -- loft   = 1,
    -- hoj    = 1,
    -- ccm_k0 = 0.08,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
    -- rad_correction = 1,
    -- loft_factor = 4.5,

    ModelData = {
        58 ,  -- model params count
        0.9 ,   -- characteristic square (характеристическая площадь)

        -- параметры зависимости Сx
        0.015 , -- планка Сx0 на дозвуке ( M << 1) cx_k0
        0.050 , -- высота пика волнового кризиса cx_k1
        0.012 , -- крутизна фронта на подходе к волновому кризису cx_k2
        0.004 , -- планка Cx0 на сверхзвуке ( M >> 1) cx_k3
        1.20  , -- крутизна спада за волновым кризисом cx_k4
        0.90  , -- коэффициент отвала поляры

        -- параметры зависимости Cy
        0.90 , -- планка Сy0 на дозвуке ( M << 1)
        0.75 , -- планка Cy0 на сверхзвуке ( M >> 1)
        1.20 , -- крутизна спада(фронта) за волновым кризисом

        0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
        0.00, --угловая скорость создаваймая моментом газовых рулей

        --    t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
        -1.0,   -1.0,       6.0,     4.0,      0.0,          0.0,      1.0e9,           -- time interval
        0.0,    0.0,       9.6,     2.8,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
        0.0,    0.0,   22770.0,  6530.0,      0.0,          0.0,        0.0,           -- thrust

        1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
        100.0, -- время работы энергосистемы, сек  Working time of power system, sec
        0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
        1.0, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
        30000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
        18000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
        0.26,  -- синус угла возвышения траектории набора горки
        50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
        1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
        1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
        2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
         
        -- DLZ data. Use numbers below for your implemetation.
        21.0, -- производная дальности по скорости носителя на высоте 1км, ППС
        -23.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
        -3.0, -- производная по высоте производной дальности по скорости цели, ЗПС
        37000.0, -- дальность ракурс 180 град (навстречу), Н=5000м, V=900км/ч, м
        14000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
        80000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м 69km
        25000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
        25000.0, -- дальность ракурс 180 град (навстречу), Н=1000м, V=900км/ч, м
        8500.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м 
        4000.0,
        0.4,
        -0.015,
        0.5,
    },
}

declare_weapon(SD_10_AA)
SD_10_AA.shape_table_data.index = SD_10_AA.wsTypeOfWeapon[4]
--[[
declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = 'DIS_SD-10',
    Picture     = 'pl12.png',
    attribute   = SD_10_AA.wsTypeOfWeapon,
    displayName = _(sd10_name),
    Cx_pil      = 0.000859765625,
    Count       = 1,
    Weight      = sd10_mass + pylon_mass,
    Elements    = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = sd10_model,
        },
    }, -- end of Elements
})


declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'DIS_SD-10_DUAL_L',
    Picture        = 'pl12.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'JF-17_PF12_twin', IsAdapter = true, },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12L', },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12R', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'DIS_SD-10_DUAL_R',
    Picture        = 'pl12.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'JF-17_PF12_twin', IsAdapter = true, },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12R', },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12L', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})
]]

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = 'Jeff_SD-10',
    Picture     = 'pl12.png',
    attribute   = SD_10_AA.wsTypeOfWeapon,
    displayName = _(sd10_name),
    Cx_pil      = 0.000859765625,
    Count       = 1,
    Weight      = sd10_mass + pylon_mass,
    Elements    = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = sd10_model,
        },
    }, -- end of Elements
})


declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'Jeff_SD-10_DUAL_L',
    Picture        = 'pl12.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'JF-17_PF12_twin', IsAdapter = true, },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12L', },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12R', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'Jeff_SD-10_DUAL_R',
    Picture        = 'pl12.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'JF-17_PF12_twin', IsAdapter = true, },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12R', },
        { ShapeName = sd10_model,        connector_name = 'dual_PF12L', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})


--[[
-- PL-12
local pl12_name  = 'PL-12'
local pl12_mass  = 199.0
local pl12_model = 'pl12'

PL_12_AA = {}
copyTable(PL_12_AA, SD_10_AA)
PL_12_AA.name           = pl12_name
PL_12_AA.model          = pl12_model
PL_12_AA.mass           = pl12_mass
PL_12_AA.user_name      = _(pl12_name)
PL_12_AA.wsTypeOfWeapon = {4,4,7,WSTYPE_PLACEHOLDER}
PL_12_AA.shape_table_data[1].name     = pl12_name
PL_12_AA.shape_table_data[1].file     = pl12_model
PL_12_AA.shape_table_data[1].username = pl12_name
PL_12_AA.shape_table_data[1].index    = WSTYPE_PLACEHOLDER
PL_12_AA.seeker.ccm_k0  = 0.11

declare_weapon(PL_12_AA)


declare_loadout({
    category     = CAT_AIR_TO_AIR,
    CLSID        = 'DIS_PL-12',
    Picture      = 'pl12.png',
    attribute    = PL_12_AA.wsTypeOfWeapon,
    displayName  = _(pl12_name),
    Cx_pil       = 0.001959765625,
    Count        = 1,
    Weight       = pl12_mass,
    Elements     = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = pl12_model,
        },
    }, -- end of Elements
})
]]