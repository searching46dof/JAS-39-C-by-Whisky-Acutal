
local ft1100_name = '1100L Tank'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft1100_name,
        displayName = _(ft1100_name),
        Picture     = "tank1100.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK1100",
        
        Weight_Empty = 75 + pylon_mass,
        Weight = 1064 + pylon_mass,
        Capacity = 1064 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = ft1100_name,
                file = "tank1100",
                life = 1,
                fire = { 0, 1},
                username = ft1100_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "tank1100",
            },
        },
    }
)

local ft1100_empty_name = '1100L Tank Empty'
declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft1100_empty_name,
        displayName = _(ft1100_empty_name),
        Picture     = "tank1100.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK1100_EMPTY",
        
        Weight_Empty = 75 + pylon_mass,
        Weight = 75 + pylon_mass,
        Capacity = 1064 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = ft1100_empty_name,
                file = "tank1100",
                life = 1,
                fire = { 0, 1},
                username = ft1100_empty_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "tank1100",
            },
        },
    }
)