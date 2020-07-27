% gagent defines
-define(GERVER_RETRY_DELAY, 3000).      % every 3  seconds
-define(GERVER_KEEPALIVE_DELAY, 10000). % every 30 seconds
-define(ZIGBEE_RETRY_DELAY, 3000).      % every 3  seconds
-define(DETS_AUTO_SAVE_DELAY, 7000).    % every 7  seconds
-define(ZIGBEE_PAIR_DURATION, 16#78).    % 120 seconds

-define(ROC_APPID_CAMERA, <<16#C38A:16>>).
-define(ROC_APPID_IPConnection, <<16#C38F:16>>).

-define(ROC_CLUSTER_ID_BP, <<16#CA8A:16>>).
-define(ROC_CLUSTER_ID_GRULES, <<16#CA8B:16>>).
-define(ROC_CLUSTER_ID_CONFIG, <<16#CA8C:16>>).
-define(ROC_CLUSTER_ID_SECRUITY_GROUPS, <<16#CA8D:16>>).
-define(ROC_CLUSTER_ID_RAW_WEB, <<16#FFEB:16>>).

-define(ROC_CLUSTER_ID_CAMERA_VIDEO, <<16#C38A:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_QUALITY,<<16#0001:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_FLIP,<<16#0002:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_MIRROR,<<16#0003:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_MOTION_SENSING,<<16#0004:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_MOTION_SENSITIVITY,<<16#0005:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_SD_RECORDING,<<16#0006:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_MIRROR_CAPABILITY,<<16#0007:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_PRIVACY_MODE, <<16#0008:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_LED_MODE, <<16#0009:16>>).
-define(ROC_CAMERA_VIDEO_ATTID_VIEWERS_COUNT,<<16#0010:16>>).


-define(ROC_CLUSTER_ID_CAMERA_CONTROL,<<16#C38B:16>>).
-define(ROC_CLUSTER_ID_CAMERA_AUDIO_CONTROL, <<16#C38C:16>>).
-define(ROC_CAMERA_VIDEO_CMD_STARTSTREAMING, <<1>>).
-define(ROC_CAMERA_VIDEO_CMD_STARTMJPEG, <<2>>).
-define(ROC_CAMERA_VIDEO_CMD_STARTHLS, <<3>>).
-define(ROC_CAMERA_VIDEO_CMD_STARTWEBRTC, <<4>>).
-define(ROC_CAMERA_AUDIO_CONTROL_ATTID_MIC,<<16#0001:16>>).
-define(ROC_CAMERA_CONTROL_CMD_REBOOT,<<0>>).
-define(ROC_CAMERA_PAN_TILT_CMD_Pan, <<0>>).
-define(ROC_CAMERA_PAN_TILT_CMD_Tilt, <<1>>).
-define(ROC_CAMERA_PAN_TILT_CMD_GoHome, <<2>>).
-define(ROC_CAMERA_PAN_TILT_CMD_Pan_Relative, <<3>>).
-define(ROC_CAMERA_PAN_TILT_CMD_Tilt_Relative, <<4>>).
-define(ROC_CAMERA_PAN_TILT_CMD_Move_Absolute, <<2>>).

-define(ROC_CLUSTER_ID_CAMERA_PAN_TILT, <<16#C38B:16>>).
-define(ROC_CLUSTER_ID_CAMERA_AUDIO, <<16#C38C:16>>).
-define(ROC_CLUSTER_ID_CAMERA_TWO_WAY_AUDIO, <<16#C38D:16>>).
-define(ROC_PUBLIC_CAM_IP_PTZ, "192.168.99.105").
-define(ROC_PUBLIC_CAM_IP, "82.218.167.12").
-define(ROC_GAGENT_APIVER, <<"0.0.4">>).
-define(ROC_PROFILEID, <<16#FFCE:16>>).
-define(ROC_APPID_BULB_GROUP, <<16#A001:16>>).
-define(ROC_APPID_PLUG_GROUP, <<16#A002:16>>).
-define(ROC_APPID_RGB_GROUP, <<16#A003:16>>).
-define(ROC_APPID_ZW_THERMOSTAT, <<16#A004:16>>).
-define(ROC_APPID_ZW_SHADES, <<16#A005:16>>).
-define(ROC_APPID_MIXED_GROUP, <<16#A000:16>>).
-define(ROC_APPID_EMPTY_GROUP, <<16#A999:16>>).
-define(ROC_APPID_WALL_SWITCH_BATTERY, <<16#D001:16>>).
-define(ROC_APPID_WALL_SWITCH_GROUNDED, <<16#D002:16>>).
-define(ROC_APPID_IRRIGATION_ORBIT_1, <<16#B0A1:16>>).
-define(ROC_APPID_IRRIGATION_ORBIT_12, <<16#B0A2:16>>).
-define(GREGORIAN_SECONDS_1970, 62167219200).
-define(Y30_YEARS_IN_SECONDS, 946080000).

% ROCID Description initial seed
-define(ROCIDVER, 4).
-define(ROCIDSEED,
	[
		{
			<<"FFFF">>,
			#{
				category  => <<"dc_lights">>,
				color  => <<"#B0BBBFFF">>,
				device_details_native  => true,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_under_construction">>,
				icon_a  => <<"di_under_construction_a">>,
				icon_b  => <<"di_under_construction_b">>,
				pairing_category  => <<"pc_lights">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_bulb_white_e27">>,
				pairing_name  => <<"pn_smart_bulb_white_e27">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"FFFF">>,
				tags  => <<"WIP">>,
				type  => <<"WIP">>
			}
		},
		{
			<<"0001">>,
			#{
				category  => <<"dc_lights">>,
				color  => <<"#EACE73FF">>,
				device_details_native  => true,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_bulb_white">>,
				icon_a  => <<"di_smart_bulb_white_a">>,
				icon_b  => <<"di_smart_bulb_white_b">>,
				pairing_category  => <<"pc_lights">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_bulb_white_e27">>,
				pairing_name  => <<"pn_smart_bulb_white_e27">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0001">>,
				tags  => <<"A">>,
				type  => <<"dt_smart_bulb_white">>
			}
		},
		{
			<<"0002">>,
			#{
				category  => <<"dc_lights">>,
				color  => <<"#EACE73FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_bulb_color">>,
				icon_a  => <<"di_smart_bulb_color_a">>,
				icon_b  => <<"di_smart_bulb_color_b">>,
				pairing_category  => <<"pc_lights">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_bulb_color">>,
				pairing_name  => <<"pn_smart_bulb_color">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0002">>,
				tags  => <<"-">>,
				type  => <<"dt_smart_bulb_color">>
			}},
		{<<"0003">>,
			#{
				category  => <<"dc_lights">>,
				color  => <<"#EACE73FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_bulb_white">>,
				icon_a  => <<"di_smart_bulb_white_a">>,
				icon_b  => <<"di_smart_bulb_white_b">>,
				pairing_category  => <<"pc_lights">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_bulb_white_gu10">>,
				pairing_name  => <<"pn_smart_bulb_white_gu10">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0003">>,
				tags  => <<"-">>,
				type  => <<"dt_smart_bulb_white">>
			}},
		{<<"0004">>,
			#{
				category  => <<"dc_lights">>,
				color  => <<"#EACE73FF">>,
				device_details_native  => false,
				endpoint  => <<"03">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_bulb_color">>,
				icon_a  => <<"di_smart_bulb_color_a">>,
				icon_b  => <<"di_smart_bulb_color_b">>,
				pairing_category  => <<"pc_lights">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_gardenspot_color">>,
				pairing_name  => <<"pn_gardenspot_color">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0004">>,
				tags  => <<"-">>,
				type  => <<"dt_smart_bulb_color">>
			}},
		{<<"0005">>,
			#{
				category  => <<"dc_cameras">>,
				color  => <<"#988FD8FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_camera">>,
				icon_a  => <<"di_camera_a">>,
				icon_b  => <<"di_camera_b">>,
				pairing_category  => <<"pc_cameras">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_camera_indoor">>,
				pairing_name  => <<"pn_camera_indoor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0005">>,
				tags  => <<"-">>,
				type  => <<"dt_camera_indoor">>
			}},
		{<<"0006">>,
			#{
				category  => <<"dc_cameras">>,
				color  => <<"#988FD8FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_camera">>,
				icon_a  => <<"di_camera_a">>,
				icon_b  => <<"di_camera_b">>,
				pairing_category  => <<"pc_cameras">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_camera_outdoor">>,
				pairing_name  => <<"pn_camera_outdoor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0006">>,
				tags  => <<"-">>,
				type  => <<"dt_camera_outdoor">>
			}},
		{<<"0007">>,
			#{
				category  => <<"dc_cameras">>,
				color  => <<"#988FD8FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_camera">>,
				icon_a  => <<"di_camera_a">>,
				icon_b  => <<"di_camera_b">>,
				pairing_category  => <<"pc_cameras">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_camera_pantilt">>,
				pairing_name  => <<"pn_camera_pantilt">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0007">>,
				tags  => <<"-">>,
				type  => <<"dt_camera_pantilt">>
			}},
		{<<"0008">>,
			#{
				category  => <<"dc_smart_plugs">>,
				color  => <<"#85C98AFF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_plug">>,
				icon_a  => <<"di_smart_plug_a">>,
				icon_b  => <<"di_smart_plug_b">>,
				pairing_category  => <<"pc_plugs_switches">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_plug">>,
				pairing_name  => <<"pn_smart_plug">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0008">>,
				tags  => <<"-">>,
				type  => <<"dt_smart_plug">>
			}},
		{<<"0009">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#0FC3E8FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_water_sensor">>,
				icon_a  => <<"di_water_sensor_a">>,
				icon_b  => <<"di_water_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_water_sensor">>,
				pairing_name  => <<"pn_water_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0009">>,
				tags  => <<"-">>,
				type  => <<"dt_water_sensor">>
			}},
		{<<"0010">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#BC6F83FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_contact_sensor">>,
				icon_a  => <<"di_contact_sensor_a">>,
				icon_b  => <<"di_contact_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_contact_sensor">>,
				pairing_name  => <<"pn_contact_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0010">>,
				tags  => <<"-">>,
				type  => <<"dt_contact_sensor">>
			}},
		{<<"0011">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#189690FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_co_sensor">>,
				icon_a  => <<"di_co_sensor_a">>,
				icon_b  => <<"di_co_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_co_sensor">>,
				pairing_name  => <<"pn_co_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0011">>,
				tags  => <<"-">>,
				type  => <<"dt_co_sensor">>
			}},
		{<<"0012">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#B2937BFF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smoke_sensor">>,
				icon_a  => <<"di_smoke_sensor_a">>,
				icon_b  => <<"di_smoke_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smoke_sensor">>,
				pairing_name  => <<"pn_smoke_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0012">>,
				tags  => <<"-">>,
				type  => <<"dt_smoke_sensor">>
			}},
		{<<"0013">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#3EC9A7FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_motion_sensor">>,
				icon_a  => <<"di_motion_sensor_a">>,
				icon_b  => <<"di_motion_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_motion_sensor">>,
				pairing_name  => <<"pn_motion_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0013">>,
				tags  => <<"-">>,
				type  => <<"dt_motion_sensor">>
			}},
		{<<"0014">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#7AA7D6FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_smart_button">>,
				icon_a  => <<"di_smart_button_a">>,
				icon_b  => <<"di_smart_button_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_smart_button">>,
				pairing_name  => <<"pn_smart_button">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0014">>,
				tags  => <<"-">>,
				type  => <<"dt_smart_button">>
			}},
		{<<"0015">>,
			#{
				category  => <<"dc_comfort">>,
				color  => <<"#FF9C5BFF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_room_sensor">>,
				icon_a  => <<"di_room_sensor_a">>,
				icon_b  => <<"di_room_sensor_b">>,
				pairing_category  => <<"pc_sensors">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_room_sensor">>,
				pairing_name  => <<"pn_room_sensor">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0015">>,
				tags  => <<"-">>,
				type  => <<"dt_room_sensor">>
			}},
		{<<"0016">>,
			#{
				category  => <<"dc_pom">>,
				color  => <<"#FB6066FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_siren">>,
				icon_a  => <<"di_siren_a">>,
				icon_b  => <<"di_siren_b">>,
				pairing_category  => <<"pc_sirens">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_siren">>,
				pairing_name  => <<"pn_siren">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0016">>,
				tags  => <<"-">>,
				type  => <<"dt_siren">>
			}},
		{<<"0017">>,
			#{
				category  => <<"dc_access">>,
				color  => <<"#FF4E50FF">>,
				device_details_native  => false,
				endpoint  => <<"02">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_door_lock">>,
				icon_a  => <<"di_door_lock_a">>,
				icon_b  => <<"di_door_lock_b">>,
				pairing_category  => <<"pc_locks">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_door_lock">>,
				pairing_name  => <<"pn_door_lock">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0017">>,
				tags  => <<"-">>,
				type  => <<"dt_door_lock">>
			}},
		{<<"0018">>,
			#{
				category  => <<"dc_irrigation">>,
				color  => <<"#006666FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_orbit_1">>,
				icon_a  => <<"di_orbit_1_a">>,
				icon_b  => <<"di_orbit_1_b">>,
				pairing_category  => <<"pc_irrigation">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_orbit_1">>,
				pairing_name  => <<"pn_orbit_1">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0018">>,
				tags  => <<"-">>,
				type  => <<"dt_orbit_1">>
			}},
		{<<"0019">>,
			#{
				category  => <<"dc_irrigation">>,
				color  => <<"#006666FF">>,
				device_details_native  => false,
				endpoint  => <<"64">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_orbit_12">>,
				icon_a  => <<"di_orbit_12_a">>,
				icon_b  => <<"di_orbit_12_b">>,
				pairing_category  => <<"pc_irrigation">>,
				pairing_help  => <<"https://docs.ozom.me/...">>,
				pairing_icon  => <<"pi_orbit_12">>,
				pairing_name  => <<"pn_orbit_12">>,
				pairing_video  => <<"https://youtu.be/sw0miuPLhoA">>,
				rocid  => <<"0019">>,
				tags  => <<"-">>,
				type  => <<"dt_orbit_12">>
			}},
		{<<"0020">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_bulb">>,
				icon_a  => <<"di_group_bulb_a">>,
				icon_b  => <<"di_group_bulb_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0020">>,
				tags  => <<"-">>,
				type  => <<"dt_group_bulb">>
			}},
		{<<"0021">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_bulb_color">>,
				icon_a  => <<"di_group_bulb_color_a">>,
				icon_b  => <<"di_group_bulb_color_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0021">>,
				tags  => <<"-">>,
				type  => <<"dt_group_bulb_color">>
			}},
		{<<"0022">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_plug">>,
				icon_a  => <<"di_group_plug_a">>,
				icon_b  => <<"di_group_plug_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0022">>,
				tags  => <<"-">>,
				type  => <<"dt_group_plug">>
			}},
		{<<"0023">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_lock">>,
				icon_a  => <<"di_group_lock_a">>,
				icon_b  => <<"di_group_lock_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0023">>,
				tags  => <<"-">>,
				type  => <<"dt_group_lock">>
			}},
		{<<"0024">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_mixed">>,
				icon_a  => <<"di_group_mixed_a">>,
				icon_b  => <<"di_group_mixed_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0024">>,
				tags  => <<"-">>,
				type  => <<"dt_group_mixed">>
			}},
		{<<"0025">>,
			#{
				category  => <<"dc_groups">>,
				color  => <<"#B8A361FF">>,
				device_details_native  => false,
				endpoint  => <<"01">>,
				help  => <<"https://docs.ozom.me/...">>,
				icon  => <<"di_group_empty">>,
				icon_a  => <<"di_group_empty_a">>,
				icon_b  => <<"di_group_empty_b">>,
				pairing_category  => <<"-">>,
				pairing_help  => <<"-">>,
				pairing_icon  => <<"-">>,
				pairing_name  => <<"-">>,
				pairing_video  => <<"-">>,
				rocid  => <<"0025">>,
				tags  => <<"-">>,
				type  => <<"dt_group_empty">>
			}}

	]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%APPROVAL IDS TAKE CARE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%approval ids checked in gagent when building the json    Sanity line 210 ,gagent line 1505
-define(ROCBPVER, 3).

-define(ROCBPSEED,
	[
		{?ROC__DCS_2330L_, <<"0006">>},
		{?ROC__DCS_5222LB1_, <<"0007">>},
		{?ROC__DCS_930L_, <<"0005">>},
		{?ROC__DCS_942L_, <<"0005">>},
		{?ROC__DCS_942LB1_, <<"0005">>},
		{?ROC__Virtual_Group_Device_, <<"FFFF">>},
		{?ROC__WANSVIEW_PT_, <<"0007">>},
		{?ROC_CentraLite_3200_Sgb_, <<"FFFF">>},
		{?ROC_CentraLite_3300_eu_, <<"FFFF">>},
		{?ROC_CentraLite_3300_S, <<"FFFF">>},
		{?ROC_CentraLite_3305_eu, <<"FFFF">>},
		{?ROC_CentraLite_3305_S_, <<"FFFF">>},
		{?ROC_CentraLite_3310_eu_, <<"FFFF">>},
		{?ROC_CentraLite_3315_eu_, <<"FFFF">>},
		{?ROC_CentraLite_3315_S_, <<"FFFF">>},
		{?ROC_ClimaxTechnology_CO_00_00_00_15TC_20140714________, <<"0011">>},
		{?ROC_ClimaxTechnology_CO_00_00_00_22TC_20141015________, <<"0011">>},
		{?ROC_ClimaxTechnology_CO_00_00_00_28TC_20141219________, <<"0011">>},
		{?ROC_ClimaxTechnology_CO_00_00_02_04TC_20150317________, <<"0011">>},
		{?ROC_ClimaxTechnology_IR_00_00_00_24TC_20140709________, <<"0013">>},
		{?ROC_ClimaxTechnology_IR_00_00_00_26TC_20140715________, <<"0013">>},
		{?ROC_ClimaxTechnology_IR_00_00_00_27TC_20140717________, <<"0013">>},
		{?ROC_ClimaxTechnology_IR_00_00_00_35TC_20140916________, <<"0013">>},
		{?ROC_ClimaxTechnology_IR_00_00_02_03TC_20150129________, <<"0013">>},
		{?ROC_ClimaxTechnology_LMHT_00_00_03_02TC_20150812________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_PSM_00_00_00_22TC_20140627________, <<"0008">>},
		{?ROC_ClimaxTechnology_PSM_00_00_00_25TC_20140709________, <<"0008">>},
		{?ROC_ClimaxTechnology_PSM_00_00_00_28TC_20140716________, <<"0008">>},
		{?ROC_ClimaxTechnology_PSM_00_00_00_35TC_20140922________, <<"0008">>},
		{?ROC_ClimaxTechnology_PSMP5_00_00_00_16TC_20150119, <<"0008">>},
		{?ROC_ClimaxTechnology_PSMP5_00_00_02_02TC_20150421, <<"0008">>},
		{?ROC_ClimaxTechnology_PSMP5_00_00_03_09TC_20151124, <<"0008">>},
		{?ROC_ClimaxTechnology_PSS_00_00_02_06TC_20150617________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_RS_00_00_00_15TC_20140127________, <<"0015">>},
		{?ROC_ClimaxTechnology_RS_00_00_00_27TC_20140714________, <<"0015">>},
		{?ROC_ClimaxTechnology_RS_00_00_00_32TC_20140916________, <<"0015">>},
		{?ROC_ClimaxTechnology_RS_00_00_02_06TC_20150331________, <<"0015">>},
		{?ROC_ClimaxTechnology_RS_00_00_03_03TC_20150907________, <<"0015">>},
		{?ROC_ClimaxTechnology_SCM_00_00_02_10T_20150428________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SD8SC_00_00_00_25TC_20140709________, <<"0012">>},
		{?ROC_ClimaxTechnology_SD8SC_00_00_00_29TC_20140715________, <<"0012">>},
		{?ROC_ClimaxTechnology_SD8SC_00_00_00_40TC_20141008________, <<"0012">>},
		{?ROC_ClimaxTechnology_SD8SC_00_00_02_02TC_20150129________, <<"0012">>},
		{?ROC_ClimaxTechnology_SD8SC_00_00_02_06TC_20150423________, <<"0012">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_01_20131217________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_03TC_20140619________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_07TC_20140709________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_08TC_20140717________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_16TC_20141008________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_00_25TC_20141226________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SRAC_00_00_02_07TC_20150504________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_SVGS_00_00_03_07TC_20151021________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_WCS_00_00_02_02TC_20150514________, <<"FFFF">>},
		{?ROC_ClimaxTechnology_WS15_00_00_00_10TC_20140714________, <<"0009">>},
		{?ROC_ClimaxTechnology_WS15_00_00_00_14TC_20140926________, <<"0009">>},
		{?ROC_ClimaxTechnology_WS15_00_00_00_20TC_20141217________, <<"0009">>},
		{?ROC_ClimaxTechnology_WS15_00_00_02_05TC_20150407________, <<"0009">>},
		{?ROC_ClimaxTechnology_WS_00_00_00_05TC_20131029________, <<"0009">>},
		{?ROC_Fidure_A1730RT_HA12_20140314, <<"FFFF">>},
		{?ROC_GE_Appliances_ZLL_Light_20140812, <<"0001">>},
		{?ROC_Kwikset_Smartcode_, <<"FFFF">>},
		{?ROC_Kwikset_SMARTCODE_DEADBOLT_5_, <<"0017">>},
		{?ROC_Kwikset_SMARTCODE_DEADBOLT_5_2, <<"0017">>},
		{?ROC_LEEDARSON_LIGHTING_5ZB_A806ST_Q1G_20150810_186, <<"0001">>},
		{?ROC_LEEDARSON_LIGHTING_A806S_Q1R_06_20150203, <<"0001">>},
		{?ROC_LEEDARSON_LIGHTING_A_Bulb_20141128, <<"0001">>},
		{?ROC_LEEDARSON_LIGHTING_M350ST_W1R_01_20150203, <<"0001">>},
		{?ROC_Marvell_ZHA_Door_Sensor_20150330, <<"FFFF">>},
		{?ROC_Marvell_ZHA_Gas_Sensor_20150330, <<"FFFF">>},
		{?ROC_Marvell_ZHA_PIR_Sensor_20150330, <<"FFFF">>},
		{?ROC_Marvell_ZHA_THP_Sensor___Temperature_20150330, <<"FFFF">>},
		{?ROC_Marvell_ZHA_Water_Sensor_20150330, <<"FFFF">>},
		{?ROC_netvox_Z308E3ED_20131227, <<"0014">>},
		{?ROC_netvox_Z311AE3ED_20131227, <<"0010">>},
		{?ROC_netvox_Z809AE3R_20130826, <<"FFFF">>},
		{?ROC_NXP_ZHA_DimmableLight_20130926, <<"0001">>},
		{?ROC_Leedarson_DimmableLight_20141022, <<"0001">>},
		{?ROC_Orbit_legacy__HT8_ZB_2013111200005179, <<"0018">>},
		{?ROC_Orbit_HT8_ZB_2013111200005179, <<"0018">>},
		{?ROC_Orbit_WT15ZB_12_2014011700000000, <<"0019">>},
		{?ROC_OSRAM_Classic_A60_TW_20140331CNLS, <<"0001">>},
		{?ROC_OSRAM_Flex_RGBW_20140331CNWT, <<"0004">>},
		{?ROC_WAXMAN_House_Water_Valve___MDL_8810300L_20131212, <<"FFFF">>},
		{?ROC_WAXMAN_leakSMART_Water_Valve_v2_10_20150723, <<"FFFF">>},
		{?ROC_Yale_YRL220_TS_LL_, <<"0017">>},
		{?ROC_Zen_Within_Zen_01_, <<"FFFF">>}
	]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%APPROVAL IDS TAKE CARE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%approval ids checked in gagent when building the json    Sanity line 210 ,gagent line 1505
-define(ROC__DCS_2330L_, [<<"DCS-2330L">>]).
-define(ROC__DCS_5222LB1_, [<<"DCS-5222LB1">>]).
-define(ROC__DCS_930L_, [<<"DCS-930L">>]).
-define(ROC__DCS_942L_, [<<"DCS-942L">>]).
-define(ROC__DCS_942LB1_, [<<"DCS-942LB1">>]).
-define(ROC__Virtual_Group_Device_, [<<"Virtual Group Device">>]).
-define(ROC__WANSVIEW_PT_, [<<"WANSVIEW-PT">>]).
-define(ROC_CentraLite_3200_Sgb_, [<<"????????????????">>, <<"CentraLite">>, <<"3200-Sgb">>]).
-define(ROC_CentraLite_3300_eu_, [<<"????????????????">>, <<"CentraLite">>, <<"3300-eu">>]).

-define(ROC_CentraLite_3300_S, [<<"????????????????">>, <<"CentraLite">>, <<"3300-S">>]).
-define(ROC_CentraLite_3305_eu, [<<"????????????????">>, <<"CentraLite">>, <<"3305-eu">>]).
-define(ROC_CentraLite_3305_S_, [<<"????????????????">>, <<"CentraLite">>, <<"3305-S">>]).
-define(ROC_CentraLite_3310_eu_, [<<"????????????????">>, <<"CentraLite">>, <<"3310-eu">>]).
-define(ROC_CentraLite_3315_eu_, [<<"????????????????">>, <<"CentraLite">>, <<"3315-eu">>]).
-define(ROC_CentraLite_3315_S_, [<<"????????????????">>, <<"CentraLite">>, <<"3315-S">>]).
-define(ROC_ClimaxTechnology_CO_00_00_00_15TC_20140714________, [<<"20140714        ">>, <<"ClimaxTechnology">>, <<"CO_00.00.00.15TC">>]).
-define(ROC_ClimaxTechnology_CO_00_00_00_22TC_20141015________, [<<"20141015        ">>, <<"ClimaxTechnology">>, <<"CO_00.00.00.22TC">>]).
-define(ROC_ClimaxTechnology_CO_00_00_00_28TC_20141219________, [<<"20141219        ">>, <<"ClimaxTechnology">>, <<"CO_00.00.00.28TC">>]).
-define(ROC_ClimaxTechnology_CO_00_00_02_04TC_20150317________, [<<"20150317        ">>, <<"ClimaxTechnology">>, <<"CO_00.00.02.04TC">>]).
-define(ROC_ClimaxTechnology_IR_00_00_00_24TC_20140709________, [<<"20140709        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.24TC">>]).
-define(ROC_ClimaxTechnology_IR_00_00_00_26TC_20140715________, [<<"20140715        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.26TC">>]).
-define(ROC_ClimaxTechnology_IR_00_00_00_27TC_20140717________, [<<"20140717        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.27TC">>]).
-define(ROC_ClimaxTechnology_IR_00_00_00_35TC_20140916________, [<<"20140916        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.35TC">>]).
-define(ROC_ClimaxTechnology_IR_00_00_02_03TC_20150129________, [<<"20150129        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.02.03TC">>]).
-define(ROC_ClimaxTechnology_LMHT_00_00_03_02TC_20150812________, [<<"20150812        ">>, <<"ClimaxTechnology">>, <<"LMHT_00.00.03.02TC">>]).
-define(ROC_ClimaxTechnology_PSM_00_00_00_22TC_20140627________, [<<"20140627        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.22TC">>]).
-define(ROC_ClimaxTechnology_PSM_00_00_00_25TC_20140709________, [<<"20140709        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.25TC">>]).
-define(ROC_ClimaxTechnology_PSM_00_00_00_28TC_20140716________, [<<"20140716        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.28TC">>]).
-define(ROC_ClimaxTechnology_PSM_00_00_00_35TC_20140922________, [<<"20140922        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.35TC">>]).
-define(ROC_ClimaxTechnology_PSMP5_00_00_00_16TC_20150119, [<<"20150119">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.00.16TC">>]).
-define(ROC_ClimaxTechnology_PSMP5_00_00_02_02TC_20150421, [<<"20150421">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.02.02TC">>]).
-define(ROC_ClimaxTechnology_PSMP5_00_00_03_09TC_20151124, [<<"20151124">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.03.09TC">>]).
-define(ROC_ClimaxTechnology_PSS_00_00_02_06TC_20150617________, [<<"20150617        ">>, <<"ClimaxTechnology">>, <<"PSS_00.00.02.06TC">>]).
-define(ROC_ClimaxTechnology_RS_00_00_00_15TC_20140127________, [<<"20140127        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.00.15TC">>]).
-define(ROC_ClimaxTechnology_RS_00_00_00_27TC_20140714________, [<<"20140714        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.00.27TC">>]).
-define(ROC_ClimaxTechnology_RS_00_00_00_32TC_20140916________, [<<"20140916        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.00.32TC">>]).
-define(ROC_ClimaxTechnology_RS_00_00_02_06TC_20150331________, [<<"20150331        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.02.06TC">>]).
-define(ROC_ClimaxTechnology_RS_00_00_03_03TC_20150907________, [<<"20150907        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.03.03TC">>]).
-define(ROC_ClimaxTechnology_SCM_00_00_02_10T_20150428________, [<<"20150428        ">>, <<"ClimaxTechnology">>, <<"SCM_00.00.02.10T">>]).
-define(ROC_ClimaxTechnology_SD8SC_00_00_00_25TC_20140709________, [<<"20140709        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.00.25TC">>]).
-define(ROC_ClimaxTechnology_SD8SC_00_00_00_29TC_20140715________, [<<"20140715        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.00.29TC">>]).
-define(ROC_ClimaxTechnology_SD8SC_00_00_00_40TC_20141008________, [<<"20141008        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.00.40TC">>]).
-define(ROC_ClimaxTechnology_SD8SC_00_00_02_02TC_20150129________, [<<"20150129        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.02.02TC">>]).
-define(ROC_ClimaxTechnology_SD8SC_00_00_02_06TC_20150423________, [<<"20150423        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.02.06TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_01_20131217________, [<<"20131217        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.01">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_03TC_20140619________, [<<"20140619        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.03TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_07TC_20140709________, [<<"20140709        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.07TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_08TC_20140717________, [<<"20140717        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.08TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_16TC_20141008________, [<<"20141008        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.16TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_00_25TC_20141226________, [<<"20141226        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.25TC">>]).
-define(ROC_ClimaxTechnology_SRAC_00_00_02_07TC_20150504________, [<<"20150504        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.02.07TC">>]).
-define(ROC_ClimaxTechnology_SVGS_00_00_03_07TC_20151021________, [<<"20151021        ">>, <<"ClimaxTechnology">>, <<"SVGS_00.00.03.07TC">>]).
-define(ROC_ClimaxTechnology_WCS_00_00_02_02TC_20150514________, [<<"20150514        ">>, <<"ClimaxTechnology">>, <<"WCS_00.00.02.02TC">>]).
-define(ROC_ClimaxTechnology_WS15_00_00_00_10TC_20140714________, [<<"20140714        ">>, <<"ClimaxTechnology">>, <<"WS15_00.00.00.10TC">>]).
-define(ROC_ClimaxTechnology_WS15_00_00_00_14TC_20140926________, [<<"20140926        ">>, <<"ClimaxTechnology">>, <<"WS15_00.00.00.14TC">>]).
-define(ROC_ClimaxTechnology_WS15_00_00_00_20TC_20141217________, [<<"20141217        ">>, <<"ClimaxTechnology">>, <<"WS15_00.00.00.20TC">>]).
-define(ROC_ClimaxTechnology_WS15_00_00_02_05TC_20150407________, [<<"20150407        ">>, <<"ClimaxTechnology">>, <<"WS15_00.00.02.05TC">>]).
-define(ROC_ClimaxTechnology_WS_00_00_00_05TC_20131029________, [<<"20131029        ">>, <<"ClimaxTechnology">>, <<"WS_00.00.00.05TC">>]).
-define(ROC_Fidure_A1730RT_HA12_20140314, [<<"20140314">>, <<"Fidure">>, <<"A1730RT_HA12">>]).
-define(ROC_GE_Appliances_ZLL_Light_20140812, [<<"20140812">>, <<"GE_Appliances">>, <<"ZLL Light">>]).
-define(ROC_Kwikset_Smartcode_, [<<"Kwikset">>, <<"Smartcode">>]).
-define(ROC_Kwikset_SMARTCODE_DEADBOLT_5_, [<<"Kwikset">>, <<"SMARTCODE_DEADBOLT_5">>]).
-define(ROC_Kwikset_SMARTCODE_DEADBOLT_5_2, [<<"Kwikset">>, <<"SMARTCODE_DEADBOLT_5">>, <<"error:86">>]).
-define(ROC_LEEDARSON_LIGHTING_5ZB_A806ST_Q1G_20150810_186, [<<"20150810-186">>, <<"LEEDARSON LIGHTING">>, <<"5ZB-A806ST-Q1G">>]).
-define(ROC_LEEDARSON_LIGHTING_A806S_Q1R_06_20150203, [<<"20150203 ">>, <<"LEEDARSON LIGHTING">>, <<"A806S-Q1R-06        ">>]).
-define(ROC_LEEDARSON_LIGHTING_A_Bulb_20141128, [<<"20141128">>, <<"LEEDARSON LIGHTING">>, <<"A-Bulb      ">>]).
-define(ROC_LEEDARSON_LIGHTING_M350ST_W1R_01_20150203, [<<"20150203 ">>, <<"LEEDARSON LIGHTING">>, <<"M350ST-W1R-01       ">>]).
-define(ROC_Marvell_ZHA_Door_Sensor_20150330, [<<"20150330">>, <<"Marvell">>, <<"ZHA Door Sensor">>]).
-define(ROC_Marvell_ZHA_Gas_Sensor_20150330, [<<"20150330">>, <<"Marvell">>, <<"ZHA Gas Sensor">>]).
-define(ROC_Marvell_ZHA_PIR_Sensor_20150330, [<<"20150330">>, <<"Marvell">>, <<"ZHA PIR Sensor">>]).
-define(ROC_Marvell_ZHA_THP_Sensor___Temperature_20150330, [<<"20150330">>, <<"Marvell">>, <<"ZHA THP Sensor - Temperature">>]).
-define(ROC_Marvell_ZHA_Water_Sensor_20150330, [<<"20150330">>, <<"Marvell">>, <<"ZHA Water Sensor">>]).
-define(ROC_netvox_Z308E3ED_20131227, [<<"20131227">>, <<"netvox">>, <<"Z308E3ED">>]).
-define(ROC_netvox_Z311AE3ED_20131227, [<<"20131227">>, <<"netvox">>, <<"Z311AE3ED">>]).
-define(ROC_netvox_Z809AE3R_20130826, [<<"20130826">>, <<"netvox">>, <<"Z809AE3R">>]).
-define(ROC_NXP_ZHA_DimmableLight_20130926, [<<"20130926">>, <<"NXP">>, <<"ZHA-DimmableLight">>]).
-define(ROC_Leedarson_DimmableLight_20141022, [<<"20141022">>, <<"DimmableLight D-">>, <<"Leedarson">>]).
-define(ROC_Orbit_HT8_ZB_2013111200005179, [<<"2013111200005179">>, <<"HT8-ZB">>, <<"Orbit">>]).
-define(ROC_Orbit_legacy__HT8_ZB_2013111200005179, [<<"2013111200005179">>, <<"Orbit">>, <<"HT8-ZB">>]).

-define(ROC_Orbit_WT15ZB_12_2014011700000000, [<<"2014011700000000">>, <<"Orbit">>, <<"WT15ZB-12">>]).
-define(ROC_OSRAM_Classic_A60_TW_20140331CNLS, [<<"20140331CNLS****">>, <<"OSRAM">>, <<"Classic A60 TW">>]).
-define(ROC_OSRAM_Flex_RGBW_20140331CNWT, [<<"20140331CNWT****">>, <<"OSRAM">>, <<"Flex RGBW">>]).
-define(ROC_WAXMAN_House_Water_Valve___MDL_8810300L_20131212, [<<"20131212">>, <<"WAXMAN">>, <<"House Water Valve - MDL-8810300L">>]).
-define(ROC_WAXMAN_leakSMART_Water_Valve_v2_10_20150723, [<<"20150723">>, <<"WAXMAN">>, <<"leakSMART Water Valve v2.10">>]).
-define(ROC_Yale_YRL220_TS_LL_, [<<"Yale">>, <<"YRL220 TS LL">>]).
-define(ROC_Zen_Within_Zen_01_, [<<"Zen Within">>, <<"Zen-01">>]).
-define(ROC_OS_GARDENRGB_20140331CNEF_APPROVAL, [<<"20140331CNEF****">>, <<"Gardenspot RGB">>, <<"OSRAM">>]).


%% -define(ROC_NXP_BULB_20130926_APPROVAL, [<<"20130926">>, <<"NXP">>, <<"ZHA-DimmableLight">>]).
%% -define(ROC_CT_WS14_20140926_APPROVAL, [<<"20140926        ">>, <<"ClimaxTechnology">>, <<"WS15_00.00.00.14TC">>]).
%% -define(ROC_CT_CO22_20141015_APPROVAL, [<<"20141015        ">>, <<"CO_00.00.00.22TC">>, <<"ClimaxTechnology">>]).
%% -define(ROC_CT_IR35_20140916_APPROVAL, [<<"20140916        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.35TC">>]).
%% -define(ROC_CT_PSM22_20140627_APPROVAL, [<<"20140627        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.22TC">>]).
%% -define(ROC_NV_Z311A_20131227_APPROVAL, [<<"20131227">>, <<"Z311AE3ED">>, <<"netvox">>]).
%% -define(ROC_CT_PSM28_20140716_APPROVAL, [<<"20140716        ">>, <<"ClimaxTechnology">>, <<"PSM_00.00.00.28TC">>]).
%% -define(ROC_CT_RS27_20140714_APPROVAL, [<<"20140714        ">>, <<"ClimaxTechnology">>, <<"RS_00.00.00.27TC">>]).
%% -define(ROC_CT_CO15_20140714_APPROVAL, [<<"20140714        ">>, <<"CO_00.00.00.15TC">>, <<"ClimaxTechnology">>]).
%% -define(ROC_CT_SRAC08_20140717_APPROVAL, [<<"20140717        ">>, <<"ClimaxTechnology">>, <<"SRAC_00.00.00.08TC">>]).
%% -define(ROC_CT_SD8SC29_20140715_APPROVAL, [<<"20140715        ">>, <<"ClimaxTechnology">>, <<"SD8SC_00.00.00.29TC">>]).
%% -define(ROC_CT_IR27_20140717_APPROVAL, [<<"20140717        ">>, <<"ClimaxTechnology">>, <<"IR_00.00.00.27TC">>]).
%% -define(ROC_CT_PSMP5_20150421_APPROVAL, [<<"20150421">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.02.02TC">>]).
%% -define(ROC_CT_PSMP5_16_20150119_APPROVAL2, [<<"20150119">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.00.16TC">>]).
%% -define(ROC_CT_PSMP5_16_20150119_APPROVAL, [<<"20140717        ">>, <<"ClimaxTechnology">>, <<"PSMP5_00.00.00.16TC">>]). %climax peru
%% -define(ROC_OS_A60TW_20140331CNLS_APPROVAL, [<<"20140331CNLS****">>, <<"Classic A60 TW">>, <<"OSRAM">>]).
%% -define(ROC_OS_FLEXRGBW_20140331CNWT_APPROVAL, [<<"20140331CNWT****">>, <<"Flex RGBW">>, <<"OSRAM">>]).
%% -define(ROC_DL_942_APPROVAL, [<<"DCS-942L">>]).
%% -define(ROC_DL_5221LB1_APPROVAL, [<<"DCS-5222LB1">>]).
%% -define(ROC_DL_942LB1_APPROVAL, [<<"DCS-942LB1">>]).
%% -define(ROC_VG_APPROVAL, [<<"Virtual Group Device">>]).
%% -define(ROC_KS_DEADBOLT5, [<<"Kwikset">>, <<"SMARTCODE_DEADBOLT_5">>]).
%% -define(ROC_NV_Z308E3ED, [<<"20131227">>, <<"Z308E3ED">>, <<"netvox">>]).
%% -define(ROC_WX_8810300L, [<<"20131212">>, <<"House Water Valve - MDL-8810300L">>, <<"WAXMAN">>]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%APPROVAL IDS  END (still take care ;))%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-define(PRODUCT_BRAND, "OZOM").
-define(S3KEY, <<"AKIAJHPZAOZ7YSYXIGBA">>). % gagent access
-define(S3SECRET, <<"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">>).
-define(SNAPSHOT_S3_BUCKET, <<"ozomsnapshot">>).

-ifdef(debug).
-define(RUN_LEVEL, debug).
-else.
-define(RUN_LEVEL, production).
-endif.

-include("rtrace.hrl").
-compile([]).
