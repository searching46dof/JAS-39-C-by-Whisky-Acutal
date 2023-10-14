
local jas_meteor_name = 'Meteor BVRAAM Active Rdr AAM'
local jas_meteor_mass = 190.0
local pylon_mass = 1.0

local jas_meteor_warhead = enhanced_a2a_warhead(24, 203)

JAS_MBDA_METEOR = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_meteor_name,
    model           = 'jf39_meteor',
    user_name       = _(jas_meteor_name),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    mass            = jas_meteor_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {4, 4, 4},
    M               = jas_meteor_mass,
    H_max           = 20000.0,
    H_min           = 1.0,
    Diam            = 203.0,
    Cx_pil          = 2.5,
    D_max           = 80000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 180.0,
    Nr_max          = 35,
    v_min           = 140.0,
    v_mid           = 2575.0,
    Mach_max        = 4.5,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 50.0,
    Range_max       = 160000.0,
    H_min_t         = 1.0,
    Fi_start        = 0.780,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.0472,
    Fi_search       = 1.05,
    OmViz_max       = 0.6981,
    exhaust         = { 1, 1, 1, 0.3 };
	X_back          = -1.54,
    Y_back          = 0.0, -- -0.11
    Z_back          = 0.0,
    Reflection      = 0.03,
    KillDistance    = 15.0,
	loft 			= 1,
	hoj 			= 1,
	ccm_k0 			= 0.025,
	
    warhead         = jas_meteor_warhead,
    warhead_air     = jas_meteor_warhead,

    shape_table_data = {
        {
            name     = jas_meteor_name,
            file     = 'jf39_meteor',
            life     = 1,
            fire     = {0, 1},
            username = "METEOR",
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    ModelData = {
        58 ,  -- model params count
        0.4 ,   -- characteristic square (характеристическая площадь) -- 9

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
        -1.0,   -1.0,       8.0,     30.0,      0.0,          0.0,      1.0e9,           -- time interval
        0.0,    0.0,       6.0,     0.4,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
        0.0,    0.0,   19000.0,  1000.0,      0.0,          0.0,        0.0,           -- thrust

        1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
        180.0, -- время работы энергосистемы, сек  Working time of power system, sec
        0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
        0.5, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
        30000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
        18000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
        0.26,  -- синус угла возвышения траектории набора горки
        50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
        1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
        1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
        2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
        0.0, --30000.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
        0.0, --3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
        0.0, --3.2,
        0.0, --0.75, -- безразмерный коэф. эффективности САУ ракеты
        0,0, --70.0, -- расчет времени полета
        -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
        80000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
        80000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
        25000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(JAS_MBDA_METEOR)

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "DIS_PL-12",
    Picture     = 'jf39_meteor.png',
    wsTypeOfWeapon   = JAS_MBDA_METEOR.wsTypeOfWeapon,
    displayName = _(jas_meteor_name),
	attribute	=	{4,	4,	32,	102,	WSTYPE_PLACEHOLDER},
    Count       = 1,
    Weight      = jas_meteor_mass + pylon_mass,
    Elements    =
	{
		{
		
			ShapeName	=	"jf39_meteor",
			Position	=	{0,	0,	0}
		},
	},	
})
--[[
declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "DIS_SD-10",
    Picture     = 'jf39_meteor.png',
    wsTypeOfWeapon   = JAS_MBDA_METEOR.wsTypeOfWeapon,
    displayName = _(jas_meteor_name),
	attribute	=	{4,	4,	32,	102,	WSTYPE_PLACEHOLDER},
    Count       = 1,
    Weight      = jas_meteor_mass + pylon_mass,
    Elements    =
	{
		{
		
			ShapeName	=	"jf39_meteor",
			Position	=	{0,	0,	0}
		},
	},	
})

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "DIS_SD-10_DUAL_L",
    Picture     = 'jf39_meteor.png',
    wsTypeOfWeapon   = JAS_MBDA_METEOR.wsTypeOfWeapon,
    displayName = _('2 x ' ..jas_meteor_name),
	attribute	=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
    Count       = 2,
    Weight      = 2 * jas_meteor_mass + pylon_mass,
   Elements = { {
			IsAdapter = true,
			ShapeName = "TER-9A"
		}, {
			ShapeName = "jf39_meteor",
			connector_name = "Point02"
		}, {
			ShapeName = "jf39_meteor",
			connector_name = "Point03"
		} },
})

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "DIS_SD-10_DUAL_R",
    Picture     = 'jf39_meteor.png',
    wsTypeOfWeapon   = JAS_MBDA_METEOR.wsTypeOfWeapon,
    displayName = _('3 x ' ..jas_meteor_name),
	attribute	=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
    Count       = 3,
    Weight      = 3 * jas_meteor_mass + pylon_mass,
   Elements = { {
			IsAdapter = true,
			ShapeName = "TER-9A"
		}, {
			ShapeName = "jf39_meteor",
			connector_name = "Point03"
		}, {
			ShapeName = "jf39_meteor",
			connector_name = "Point02"
        }, {
			ShapeName = "jf39_meteor",
			connector_name = "Point01"
		} },
})
]]--