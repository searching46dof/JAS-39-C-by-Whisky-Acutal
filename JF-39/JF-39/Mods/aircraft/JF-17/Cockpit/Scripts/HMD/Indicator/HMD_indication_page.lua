dofile(LockOn_Options.script_path.."HMD/Indicator/HMD_def.lua")

--[[
"HUD_BRIGHTNESS"
{"opacity_using_parameter", 0}

--]]

----
local HUD_BASE 				= CreateElement "ceSimple"
HUD_BASE.name  				= create_guid_string()
HUD_BASE.init_pos			= {-0.08, 0, 1.5}									--{0, -1.345,0} -- 0,0.7,-1.5
HUD_BASE.element_params     = {"MAINPOWER","HORIZONTAL_VIEW_HMD","VERTICAL_VIEW_HMD", "HMDTOGGLE"}          
HUD_BASE.controllers        = {{"parameter_in_range" ,0,0.9,1.1},{"parameter_in_range" ,1, 23,360},{"parameter_in_range" ,2, -30,220}, {"parameter_in_range" ,3, 0.9,1.1} }
AddHMDElement(HUD_BASE)
----

---Landing mode indicator
local landing_mode_ind 			 	= add_text_HMD("L", -0.0, -1.0, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
landing_mode_ind.element_params  	= {"LANDING_MODE","CANNON_MODE"}
landing_mode_ind.controllers     	= {{"parameter_in_range" ,0,0.9,1.1}, {"parameter_in_range" ,1,-0.1,0.1} } 

local nav_mode_ind 			 		= add_text_HMD("NAV", 0.0, -0.8, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
nav_mode_ind.element_params  		= {"HUD_MODE","CANNON_MODE"}
nav_mode_ind.controllers     		= {{"parameter_in_range" ,0,0.9,1.1}, {"parameter_in_range" ,1,-0.1,0.1} }
	
local bvr_mode_ind 			 		= add_text_HMD("BVR", -0.0, -0.8, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
bvr_mode_ind.element_params  		= {"HUD_MODE","CANNON_MODE"}
bvr_mode_ind.controllers     		= {{"parameter_in_range" ,0,1.9,2.1}, {"parameter_in_range" ,1,-0.1,0.1} }
	
local vs_mode_ind 			 		= add_text_HMD("DOGF", -0.0, -0.8, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
vs_mode_ind.element_params  		= {"HUD_MODE","CANNON_MODE"}
vs_mode_ind.controllers     		= {{"parameter_in_range" ,0,2.9,3.1}, {"parameter_in_range" ,1,-0.1,0.1} }
	
local bore_mode_ind 				= add_text_HMD("BORE", -0.0, -0.8, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
bore_mode_ind.element_params  		= {"HUD_MODE","CANNON_MODE"}
bore_mode_ind.controllers     		= {{"parameter_in_range" ,0,3.9,4.1}, {"parameter_in_range" ,1,-0.1,0.1} }
	
local lngt_mode_ind 				= add_text_HMD("LNGT", -0.0, -0.8, HUD_BASE , "hud_font_g", HMD_strdefs_text, "CenterCenter")
lngt_mode_ind.element_params  		= {"HUD_MODE","CANNON_MODE"}
lngt_mode_ind.controllers     		= {{"parameter_in_range" ,0,5.9,6.1}, {"parameter_in_range" ,1,-0.1,0.1} }


local Left_Side_Indication_base 			= CreateElement "ceSimple"
Left_Side_Indication_base.name  			= create_guid_string()
Left_Side_Indication_base.init_pos			= {-0.033, -0.15,0}
Left_Side_Indication_base.parent_element	= HUD_BASE.name
AddHMDElement(Left_Side_Indication_base)


--HMD Circle

local AltimeterScaleArrow				= create_HMD_Circle(HMD_Circle, 0, 0, 2048, 2048, 0.8) 
AltimeterScaleArrow.name				= create_guid_string()
AltimeterScaleArrow.init_pos			= {0 ,-0.2, 0}
AltimeterScaleArrow.init_rot			= {0, 0, 0}
AltimeterScaleArrow.parent_element		= HUD_BASE.name	
AltimeterScaleArrow.element_params		= {"HUD_BRIGHTNESS"}
AltimeterScaleArrow.controllers			= { {"opacity_using_parameter" ,0}  }
AddHMDElement(AltimeterScaleArrow)

--Indicators

local G_indicator 	= add_text_HMD_param(-0.5, 0.1, "G_HMD","HUD_BRIGHTNESS", "%0.1f", Left_Side_Indication_base, HMD_strdefs_digit, nil)
--[[
local KIAS_box	= create_rect(-0.47, -0.0, 0.6, 0.2, 0.01, Left_Side_Indication_base, "DBG_GREEN")
KIAS_box.element_params		= {"HUD_BRIGHTNESS"}
KIAS_box.controllers			= { {"opacity_using_parameter" ,0}  }
AddHMDElement(KIAS_box)]]


local KIAS_indicator 	= add_text_HMD_param(-0.45, -0.1, "CURR_IAS","HUD_BRIGHTNESS", "%0.0f", Left_Side_Indication_base, HMD_strdefs_digit, nil)

local Right_Side_Indication_base 			= CreateElement "ceSimple"
Right_Side_Indication_base.name  			= create_guid_string()
Right_Side_Indication_base.init_pos			= {0.033, -0.15,0}
Right_Side_Indication_base.parent_element	= HUD_BASE.name
AddHMDElement(Right_Side_Indication_base)

local Altitude_indicator 	= add_text_HMD_param(0.45, -0.1, "ALTITUDE_HMD","HUD_BRIGHTNESS", "%0.0f", Right_Side_Indication_base, HMD_strdefs_digit, nil)


local Bottom_Indication_base 			= CreateElement "ceSimple"
Bottom_Indication_base.name  			= create_guid_string()
Bottom_Indication_base.init_pos			= {0.00, 0.45,0}
Bottom_Indication_base.parent_element	= HUD_BASE.name
AddHMDElement(Bottom_Indication_base)


local Heading_indicator 	= add_text_HMD_param(0.0, -0.1, "HEADING_HMD","HUD_BRIGHTNESS", "%0.0f", Bottom_Indication_base, HMD_strdefs_digit, nil)


--local tester 	= add_text_HMD_param(0, -0.1, "DEBUGPARAM","HUD_BRIGHTNESS", "%0.6f", Left_Side_Indication_base, HMD_strdefs_digit, "Gripen_Font_green")

--[[
local TST_G		 = MakeMaterial(nil,{0,0,100,100})

local AltimeterScaleMask 					= CreateElement "ceMeshPoly"		-- change shape 
AltimeterScaleMask.name 					=  create_guid_string()
AltimeterScaleMask.primitivetype 			= "triangles"
AltimeterScaleMask.material					= TST_G
AltimeterScaleMask.parent_element			= HUD_BASE.name
AltimeterScaleMask.vertices	   	 			= { {0.5, -0.02 }, { 0.8 , -0.02},
												{ 0.8 ,-0.35 }, {0.5 ,-0.35 }, }
AltimeterScaleMask.indices					= {0, 1, 2, 0, 2, 3}
AltimeterScaleMask.init_pos					= {-0.15, 0, 0}
AltimeterScaleMask.init_rot					= {0, 0, 0}
AltimeterScaleMask.h_clip_relation   		= h_clip_relations.INCREASE_IF_LEVEL 
AltimeterScaleMask.level  		 			= HMD_DEFAULT_LEVEL
AltimeterScaleMask.element_params			= {"HUD_MODE"}
AltimeterScaleMask.controllers				= { {"parameter_in_range",0, -1,7}  }
AltimeterScaleMask.isvisible				= false
Add(AltimeterScaleMask)

local AltimeterScaleArrow				= HMD_Horizon_Line(HMD_HORIZON, 793, 987, 912, 1106, 0.5) 
AltimeterScaleArrow.name				= create_guid_string()
AltimeterScaleArrow.init_pos			= {0.41, -0.282, 0}
AltimeterScaleArrow.init_rot			= {-90, 0, 0}
AltimeterScaleArrow.parent_element		= HUD_BASE.name						
AltimeterScaleArrow.h_clip_relation  	= h_clip_relations.DECREASE_IF_LEVEL 
AltimeterScaleArrow.level  		 		= HMD_DEFAULT_LEVEL + 1
AltimeterScaleArrow.element_params		= {"HUD_BRIGHTNESS"}
AltimeterScaleArrow.controllers			= { {"opacity_using_parameter" ,0}  }
AddHMDElement2(AltimeterScaleArrow)]]

--ALTITUDE_MODE:set(1)		-- 1 = barometric, 2 = Radar 
--[[
local Altitude_mode_ind 					= add_text_HMD("77", 0.58, -0.50, HUD_BASE , "Gripen_Font_green", HUD_pitch_digit, "CenterCenter")
Altitude_mode_ind.element_params  			= {"ALTITUDE_MODE","RadarAltAvail"}
Altitude_mode_ind.controllers     			= {{"parameter_in_range" ,0, 1.9, 2.1},{"parameter_in_range" ,1, 0.9, 1.1} }]]

--[[
local ALTIMETER_BASE 				= CreateElement "ceSimple"
ALTIMETER_BASE.name  				= create_guid_string()
ALTIMETER_BASE.init_pos				= {-0.15, 0.782}
ALTIMETER_BASE.parent_element		= HUD_BASE.name
ALTIMETER_BASE.element_params     	= {"ALTITUDE_HMD"}             
ALTIMETER_BASE.controllers        	= {{"move_up_down_using_parameter",0, -0.0001980675} }
AddHMDElement(ALTIMETER_BASE)


local ThousandsOffsetX = 0.655	
local ThousandsOffsetY = -1

local HundredsOffsetX = 0.727
local HundredsOffsetY = -1.005
local AltLineOffset = 0.15
--local AltTextOffset = 0.149955
local AltTextOffset = 0.15

local counter = - 1
local hundreds = 0
local Thousands = 0

for i = 0,810 do
		local AltLine 						= HMD_Heading_Scale(HMD_HeadingScale, 193, 105, 207, 179, 2)
		AltLine.name						= create_guid_string()
		AltLine.init_pos					= {0.6, -1 + i * AltLineOffset, 0}
		AltLine.init_rot					= {90, 0, 0}
		AltLine.parent_element				= ALTIMETER_BASE.name
		AltLine.element_params				= {"HUD_BRIGHTNESS"}
		AltLine.controllers					= { {"opacity_using_parameter" ,0}  }
		AddHMDElement3(AltLine)
		
		local AltLineShort 						= HMD_Heading_Scale(HMD_HeadingScale, 293, 141, 307, 179, 2)
		AltLineShort.name						= create_guid_string()
		AltLineShort.init_pos					= {0.591, -1.075 + i * AltLineOffset, 0}
		AltLineShort.init_rot					= {90, 0, 0}
		AltLineShort.parent_element				= ALTIMETER_BASE.name
		AltLineShort.element_params				= {"HUD_BRIGHTNESS"}
		AltLineShort.controllers				= { {"opacity_using_parameter" ,0}  }
		AddHMDElement3(AltLineShort)
		
		counter = counter + 3.2808399 -- change to feet
		
		if counter == 10 then
			counter = 0
			Thousands = Thousands + 1
		end
		
		hundreds = counter
		if Thousands < 1 then
		
			if hundreds == 0 then
				local Ahundreds		= add_text_HMD2(hundreds, HundredsOffsetX - 0.075, HundredsOffsetY+ i * AltTextOffset, ALTIMETER_BASE , nil, HMD_strdefs_text, "CenterCenter")
			else 
				local Ahundreds		= add_text_HMD2(hundreds .. "00", HundredsOffsetX - 0.05, HundredsOffsetY+ i * AltTextOffset, ALTIMETER_BASE , nil, HMD_strdefs_text, "CenterCenter")
			end
			
		elseif Thousands >= 1 and Thousands < 10 then
		
			local AThousands		= add_text_HMD2(Thousands, ThousandsOffsetX + 0.02, ThousandsOffsetY + i * AltTextOffset, ALTIMETER_BASE , nil, HMD_strdefs_text, "CenterCenter")
			
			local Ahundreds			= add_text_HMD2(hundreds .. "00", HundredsOffsetX, HundredsOffsetY+ i * AltTextOffset, ALTIMETER_BASE , nil, HUD_Heading_digit, "CenterCenter")

		else
			local AThousands		= add_text_HMD2(Thousands, ThousandsOffsetX , ThousandsOffsetY + i * AltTextOffset, ALTIMETER_BASE , nil, HMD_strdefs_text, "CenterCenter")
			
			local Ahundreds			= add_text_HMD2(hundreds .. "00", HundredsOffsetX, HundredsOffsetY+ i * AltTextOffset, ALTIMETER_BASE , nil, HUD_Heading_digit, "CenterCenter")

		end

end]]
--[[
-- air to ground mode altimeter

local A2G_Altitude_BASE 					= CreateElement "ceSimple"
A2G_Altitude_BASE.name  					= create_guid_string()
A2G_Altitude_BASE.parent_element			= HUD_BASE.name
A2G_Altitude_BASE.init_pos					= {0.65, 0 ,0}									--{0, -1.345,0}
A2G_Altitude_BASE.element_params  			= {"HUD_MODE"}
A2G_Altitude_BASE.controllers     			= { {"parameter_compare_with_number",0, 7}  }
AddHMDElement(A2G_Altitude_BASE)

local A2G_Altitude 			 			= add_text_HMD("A", 0, -0.1, A2G_Altitude_BASE  , "Gripen_Font_green", HMD_strdefs_text, "CenterCenter")

local A2G_Altitude_Readout 				= add_text_HMD_param(0, -0.2, "ALTITUDE_HUD","HUD_BRIGHTNESS", "%0.0f", A2G_Altitude_BASE , HMD_strdefs_digit, "Gripen_Font_green")

local GroundCollisionWarning				= create_HUD_GCW(HUD_GroundCollisionWarning, 184, 458, 2682, 1348, 0.333) 
GroundCollisionWarning.name					= create_guid_string()
GroundCollisionWarning.init_pos				= {0, -0.3, 0}
GroundCollisionWarning.init_rot				= {0, 0, 0}
GroundCollisionWarning.parent_element		= HUD_BASE.name		
GroundCollisionWarning.element_params		= {"HUD_BRIGHTNESS","PULLUPQUE", "ROLL_HUD", "VELVEC_HUD_Y","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL", "PULLMORE","VELVEC_HUD_X"}
GroundCollisionWarning.controllers			= { {"opacity_using_parameter" ,0}, {"parameter_in_range",1, -10000,0},{"rotate_using_parameter" ,2, 1.00},
												{"move_up_down_using_parameter",3, 0.322} ,{"parameter_compare_with_number",4, 0},{"parameter_compare_with_number",5, 0},
												{"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},{"parameter_compare_with_number",8, 0},
												{"parameter_compare_with_number",9, 0},{"parameter_compare_with_number",10, 0},{"parameter_compare_with_number",11, 0}, {"parameter_in_range",12, -0.99,0.5},{"move_left_right_using_parameter",13, 0.322} }									
AddHMDElement(GroundCollisionWarning)

local GCW_Arrow_L					= create_HMD_GCW(HMD_GroundCollisionWarning, 23, 23, 508, 443, 0.333) 
GCW_Arrow_L.name					= create_guid_string()
GCW_Arrow_L.init_pos				= {-0.2655, 0.09, 0}
GCW_Arrow_L.init_rot				= {0, 0, 0}
GCW_Arrow_L.parent_element			= GroundCollisionWarning.name	
GCW_Arrow_L.element_params			= {"HUD_BRIGHTNESS","PULLUPQUE", "PULLMORE"}
GCW_Arrow_L.controllers				= { {"opacity_using_parameter" ,0},{"move_up_down_using_parameter",1, -0.000006}, {"parameter_in_range",2, -0.99,0.5}  }									
AddHMDElement(GCW_Arrow_L)

local GCW_Arrow_R					= create_HMD_GCW(HMD_GroundCollisionWarning, 23, 23, 508, 443, 0.333) 
GCW_Arrow_R.name					= create_guid_string()
GCW_Arrow_R.init_pos				= {0.2655, 0.09, 0}
GCW_Arrow_R.init_rot				= {0, 0, 0}
GCW_Arrow_R.parent_element			= GroundCollisionWarning.name	
GCW_Arrow_R.element_params			= {"HUD_BRIGHTNESS","PULLUPQUE", "PULLMORE"}
GCW_Arrow_R.controllers				= { {"opacity_using_parameter" ,0},{"move_up_down_using_parameter",1, -0.000006}, {"parameter_in_range",2, -0.99,0.5}  }									
AddHMDElement(GCW_Arrow_R)]]
--dofile(LockOn_Options.script_path.."HMD/Indicator/HMD_RWR.lua")
