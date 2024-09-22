-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Description:
-- Flaps and Taxi lights not working on score raiting by OnAir for HotStart Challenger 650
-- So this script will read the CL650 values and set it for OnAir that he can regonise the status.
-- This is not a fake script. You still have to handle the stuff correct !
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- AUTHOR: thWelly
-- Date: 16. September 2024
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- USAGE:
-- Install FlyWithLUA plugin, copy this script to the "Scripts" subfolder of FlyWithLUA plugins
-- Restart X-Plane
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

if PLANE_ICAO == "CL60" and AIRCRAFT_FILENAME == "CL650.acf" then

	function onair_cl650_enhancer()
		-- FIX FLAPS (Maybe this works for other aircrafts too)
		FLAP_RATO = get("sim/flightmodel/controls/flaprqst")
		FLAP_RATO_ONAIR = get("sim/flightmodel2/controls/flap_handle_deploy_ratio")  --mail antoine onair

		if FLAP_RATO < FLAP_RATO_ONAIR or FLAP_RATO > FLAP_RATO_ONAIR then
			logMsg ("Flaps Rato old = " .. FLAP_RATO_ONAIR .. " / Flap Rato new = " .. FLAP_RATO .. "")
			if FLAP_RATO <= 0.01 and FLAP_RATO > 0 then
				logMsg ("Flaps Rato is allmost 0 ... set to 0")
				set("sim/flightmodel/controls/flaprqst", 0)
				set ("sim/flightmodel2/controls/flap_handle_deploy_ratio", 0)
			else
				if FLAP_RATO > 0.9 and FLAP_RATO < 1  then
					logMsg ("Flaps Rato allmost 1 ... set to 1")
					set("sim/flightmodel/controls/flaprqst", 1)
					set ("sim/flightmodel2/controls/flap_handle_deploy_ratio", 1)
				else
					set ("sim/flightmodel2/controls/flap_handle_deploy_ratio", FLAP_RATO)
				end
			end
		end

		-- FIX TAXI (I guess that must be set for each aircraft)
		TAXI_VALUE = get("CL650/overhead/land_lts/recog_taxi")
		TAXI_VALUE_ONAIR = get("sim/cockpit/electrical/taxi_light_on") --mail antoine onair

		if TAXI_VALUE < TAXI_VALUE_ONAIR or TAXI_VALUE > TAXI_VALUE_ONAIR then
			logMsg ("Taxi value old = " .. TAXI_VALUE_ONAIR .. " / Taxi value new = " .. TAXI_VALUE .. "")
			set ("sim/cockpit/electrical/taxi_light_on", TAXI_VALUE)
		end
		
	end

	do_often ("onair_cl650_enhancer()")
end
