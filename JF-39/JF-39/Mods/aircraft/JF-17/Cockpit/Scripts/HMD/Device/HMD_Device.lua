dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
local update_time_step = 0.01 --update will be called 100 times per second
make_default_activity(update_time_step)
dev = GetSelf()
-------------------------------------------------------
-- Local Variables
-------------------------------------------------------
local sensor_data = get_base_data()
local HORIZONTAL_VIEW_HMD = get_param_handle("HORIZONTAL_VIEW_HMD")
local VERTICAL_VIEW_HMD = get_param_handle("VERTICAL_VIEW_HMD")
local HMD_LIGHT = get_param_handle("HMD_LIGHT")
local HUD_MODE = get_param_handle("HUD_MODE")
local CANNON_MODE = get_param_handle("CANNON_MODE")
local HMDTOGGLE = get_param_handle("HMDTOGGLE")
local RAD_TO_DEGREE  = 57.29577951308233
local MainPower = get_param_handle("MAINPOWER")

local HUD_BRIGHTNESS = get_param_handle("HUD_BRIGHTNESS")
MainPower:set(1.0)
local button_depress = false
local first_run = true
-------------------------------------------------------
-- Initialization Functions	
-------------------------------------------------------

-------------------------------------------------------
-- Params
-------------------------------------------------------
dev:listen_command(2142) -- -162 to 162 degrees
dev:listen_command(2143) -- -90 to 110
-------------------------------------------------------
-- Complexe Functions
-------------------------------------------------------
--dev:listen_command(device_commands.HMDTOGGLE)
function post_initialize()
    HORIZONTAL_VIEW_HMD:set(0)
    VERTICAL_VIEW_HMD:set(0)
    --HMD_LIGHT:set(1)
    HMDTOGGLE:set(1)
    CANNON_MODE:set(1)
	MainPower:set(1.0)
	HUD_BRIGHTNESS:set(1.0)
	HUD_MODE:set(1.0)
end

function SetCommand(command,value)
--[[
    if command == device_commands.HMDTOGGLE then

    if HMDTOGGLE:get() == 0 then
        HMDTOGGLE:set(1)
        HMD_LIGHT:set(1) 
    else
        HMDTOGGLE:set(0)
        HMD_LIGHT:set(0) 
    end
end]]
    if command == 2142 then
       -- print_message_to_user(value)

       if VERTICAL_VIEW_HMD:get() < 40 then
            HORIZONTAL_VIEW_HMD:set(math.abs(value))
       else
            HORIZONTAL_VIEW_HMD:set(25)
           -- print_message_to_user(HORIZONTAL_VIEW:get())
       --HEAD_ROT:set(value/-180)
       end
    end

    if command == 2143 then
        --HEAD_TILT:set(value/90)
        if HORIZONTAL_VIEW_HMD:get() < 45 then
             VERTICAL_VIEW_HMD:set(value*2)
        else
            VERTICAL_VIEW_HMD:set(value)
        end
      -- print_message_to_user(VERTICAL_VIEW_HMD:get())

    end
end 

function update()
	if first_run then
		HMDTOGGLE:set(0)
		first_run = false
	end
	--print_message_to_user(get_cockpit_draw_argument_value(915))
	if get_cockpit_draw_argument_value(915) > 0.0 then
		--print_message_to_user('Clicked')
		button_depress = true
	else
		--if clicked
		if button_depress == true  then
			if HMDTOGGLE:get() == 0 then
				print_message_to_user('On')
				HMDTOGGLE:set(1)
				HMD_LIGHT:set(1) 
			else	
				print_message_to_user('Off')
				HMDTOGGLE:set(0)
				HMD_LIGHT:set(0) 
			end		
		end
		
		button_depress = false
	end 
--[[
	--get HMD toggle pos
	if get_cockpit_draw_argument_value(264) > 0.5 then
		HMDTOGGLE:set(1.0)
	else
		HMDTOGGLE:set(0.0)
	end]]
	
	--get HMD brightness
	if get_cockpit_draw_argument_value(729) > 0.0 then
		HUD_BRIGHTNESS:set(get_cockpit_draw_argument_value(729))
	else
		HUD_BRIGHTNESS:set(0.0)
	end
	
end
need_to_be_closed = false