-define(MAC_SIZE, 50).
-define(DEFAULT_BUFSIZE, 61).
-record(pairState, {mac = [], lastNodeID = <<0,0>>, nodeID = <<>>, rnodeID = <<>>,
	pairstate , isAnnounced = false, epConfigured=0,epCount=0,
	zclSequence = 0, visibility=false, bufsize, isAlarm = false,
	maxOutBufSize=?DEFAULT_BUFSIZE,maxInBufSize = ?DEFAULT_BUFSIZE,
	curInBufSize = ?DEFAULT_BUFSIZE, curOutBufSize = ?DEFAULT_BUFSIZE,
	mfgCode,eps=[],epStates=[],pairQueue=[], epCaps = [],gwmac,msgQueue=[],
	parentName,parentMAC,parentNodeID= <<0,0>>  ,logicalType, rxOnWhenIdle = unkown,
	noReport=false,
	otaFile= <<>>,
	reTxCount=[],
	alarmTimer=none,
	rocid= <<"FFFF">>,
	callbackQueue=[],
	leftTimer=none,
	pairTimer=none}).

-record(epState, {inClusterList = [], outClusterList =[],appDeviceID , appDevVersion, appProfileID,ep }).

 %netvox contact max buf size....
-define(ZCL_FC,<<16#11>>).%01 +08 disable default response + cluster command
-define(ZCL_FC_RESPONSE, <<16#01>>).%01 +08 disable default response + cluster command
-define(ZCL_JFC, <<"11">>).%01 +08 disable default response + cluster command
-define(ZCL_JFC_RESPONSE, <<"01">>).%01 +08 disable default response + cluster command
-define(JSON_ClusterID_Power_Measurement, <<"0702">>).
-define(JSON_ClusterID_Power_Configuration, <<"0001">>).
-define(JSON_ClusterID_On_Off, <<"0006">>).
-define(JSON_ClusterID_Level_Control, <<"0008">>).
-define(JSON_ClusterID_Door_Lock, <<"0101">>).
-define(JSON_ClusterID_Temperature_Measurement, <<"0402">>).
-define(JSON_ClusterID_Luminance_Measurement, <<"0400">>).
-define(JSON_ClusterID_Relative_Humidity_Measurement, <<"0405">>).
-define(JSON_ClusterID_Lighting_Color_Control, <<"0300">>).
-define(JSON_ZDO_Profile, <<"0000">>).
-define(JSON_ClusterID_Time, <<"000a">>).
-define(JSON_ClusterID_Thermostat, <<"0201">>).

%------------------------------------------------------------------------------
% GenHeater
%
% Generic Heater support.

% APPID:
-define(ZIGBEE_APPID_GenHeater, <<16#FF21:16>>).

% ClusterID:
-define(ClusterID_GenHeater, <<16#FF21:16>>).

% "action": "sendGeneralCmd", "CMDID" attributes

% Information attributes:
-define(ClusterID_GenHeater_AttributeID_LocalTemperature,    <<16#0001:16>>). % val_uint environment temperature Celsius
-define(ClusterID_GenHeater_AttributeID_TimeRemaining,       <<16#0002:16>>). % val_uint remaining timer in minutes
-define(ClusterID_GenHeater_AttributeID_Energy,              <<16#0003:16>>). % val_uint energy consumed in Wh

% Settable attributes:
% NOTE: These also have matching sendActionCmd implementation since
% either this ZigBEE-alike attribute interface can be used, or the
% sendActionCmd explicit calls.
-define(ClusterID_GenHeater_AttributeID_Power,               <<16#0010:16>>). % val_uint on/off
-define(ClusterID_GenHeater_AttributeID_TemperatureSetPoint, <<16#0011:16>>). % val_uint desired temperature Celsius
-define(ClusterID_GenHeater_AttributeID_Heat,                <<16#0012:16>>). % val_uint low/high
-define(ClusterID_GenHeater_AttributeID_Timer,               <<16#0013:16>>). % val_uint hours
-define(ClusterID_GenHeater_AttributeID_Swing,               <<16#0014:16>>). % val_uint on/off
-define(ClusterID_GenHeater_AttributeID_Economy,             <<16#0015:16>>). % val_uint on/off
-define(ClusterID_GenHeater_AttributeID_Format,              <<16#0016:16>>). % val_uint Celsius/Fahrenheit

% Common on/off/toggle argument manifests:
-define(ClusterID_GenHeater_ARG_Off,    <<16#00:8>>).
-define(ClusterID_GenHeater_ARG_On,     <<16#01:8>>).
-define(ClusterID_GenHeater_ARG_Toggle, <<16#02:8>>).

% Manifests for heat level:
-define(ClusterID_GenHeater_ARG_Low,  <<16#00:8>>).
-define(ClusterID_GenHeater_ARG_High, <<16#01:8>>).

% Manifests for device temperature format (NOTE: gagent works with Celsius)
-define(ClusterID_GenHeater_ARG_Celsius,    <<16#00:8>>).
-define(ClusterID_GenHeater_ARG_Fahrenheit, <<16#01:8>>).

% Cluster Commands:
-define(ClusterID_GenHeater_CMD_GetStatus,      <<16#01:8>>). % no arg - just trigger status update
-define(ClusterID_GenHeater_CMD_SetPower,       <<16#10:8>>). % val_uint Off/On/Toggle
-define(ClusterID_GenHeater_CMD_SetTemperature, <<16#11:8>>). % val_uint Celsius temperature
-define(ClusterID_GenHeater_CMD_SetHeat,        <<16#12:8>>). % val_uint Low/High
-define(ClusterID_GenHeater_CMD_SetTimer,       <<16#13:8>>). % val_uint #-hours
-define(ClusterID_GenHeater_CMD_SetSwing,       <<16#14:8>>). % val_uint Off/On/Toggle
-define(ClusterID_GenHeater_CMD_SetEconomy,     <<16#15:8>>). % val_uint Off/On/Toggle
-define(ClusterID_GenHeater_CMD_SetFormat,      <<16#16:8>>). % val_uint Celsius/Fahrenheit

%------------------------------------------------------------------------------

-define(ZIGBEE_CONFIG_VER, 1).
-define(ZigBEE_INCluster_CONFIG,
	[%Attribute reporting configuration per clusterid
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Power_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{id => <<"0000">>,
						datatype => <<"25">>,
						min => <<"0001">>,
						max => <<"0258">>,
						change => <<"0000000003E8">>
					},
					#{
						id => <<"0400">>,
						datatype => <<"2A">>,
						min => <<"0001">>,
						max => <<"0258">>,
						change => <<"0003E8">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Power_Configuration},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0020">>,
						datatype => <<"20">>,
						min => <<"0001">>,
						max => <<"0708">>,
						change=> <<"02">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_On_Off},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>

				[
					#{
						id => <<"0000">>,
						datatype => <<"10">>,
						min => <<"0001">>,
						max => <<"0708">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Level_Control},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>

				[
					#{
						id => <<"0000">>,
						datatype => <<"20">>,
						min => <<"0001">>,
						max => <<"0258">>,
						change => <<"02">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Door_Lock},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0000">>,
						datatype => <<"30">>,
						min => <<"0001">>,
						max => <<"0708">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Temperature_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0000">>,
						datatype => <<"29">>,
						min => <<"0001">>,
						max => <<"0e10">>,
						change => <<"0064">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Luminance_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0000">>,
						datatype => <<"29">>,
						min => <<"0001">>,
						max => <<"0e10">>,
						change => <<"0064">>
					}
				]}
		},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Relative_Humidity_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0000">>,
						datatype => <<"21">>,
						min => <<"0001">>,
						max => <<"0e10">>,
						change => <<"03e8">>
					}
				]
			}
		},
		%ias attribute is not reportable (tested on netvox) so we fake the report json from the incomming IAS ZONE command.
		%{?ZigBEE_ClusterID_IAS_Zone, #{values => [#{
		%	id => <<"0002">>,
		%	datatype => <<"19">>,
		%	min => <<"0000">>,
		%	max => <<"ffff">>
		%}
		%]}},
		{#{action=>config_incluster, clusterid=>?JSON_ClusterID_Lighting_Color_Control},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					#{
						id => <<"0003">>,
						datatype => <<"21">>,
						min => <<"0001">>,
						max => <<"0258">>,
						change => <<"0001">>
					},
					#{
						id => <<"0004">>,
						datatype => <<"21">>,
						min => <<"0001">>,
						max => <<"0258">>,
						change => <<"0001">>
					}
				]
			}
		}
	]).
-define(ZigBEE_INCluster_Read_Attr,
	[
		{#{action=>read_incluster, clusterid=>?JSON_ZDO_Profile},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>,
					<<"0001">>,
					<<"0002">>,
					<<"0003">>,
					<<"0004">>,
					<<"0005">>,
					<<"0006">>,
					<<"0007">>


				]}
		},
		%{?ZigBEE_ClusterID_IAS_Zone,
		%	#{values => [
		%		#{id => <<"0002">>}
		%	]
		%	}}, %,?ZigBEE_IAS_AttrID_CIE_Address
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Power_Configuration},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>,
					<<"0001">>,
					<<"0020">>,
					<<"0035">>,
					<<"0004">>

				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Thermostat},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0021">>,
					<<"0022">>,
					<<"0023">>,
					<<"0024">>,
					<<"0100">>,
					<<"0101">>,
					<<"0102">>,
					<<"0111">>,
					<<"0112">>

				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Level_Control},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>,
					<<"0001">>,
					<<"0010">>,
					<<"0011">>

				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Door_Lock},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Relative_Humidity_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Luminance_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Temperature_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Time},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0000">>,
					<<"0001">>,
					<<"0002">>,
					<<"0003">>,
					<<"0004">>,
					<<"0005">>,
					<<"0006">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Power_Measurement},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0300">>, %unit of measurement
					<<"0301">>, %multiplier
					<<"0302">>, %divisor
					<<"0303">>,
					<<"0304">>,
					<<"0400">>,
					<<"0000">>
				]}
		},
		{#{action=>read_incluster, clusterid=>?JSON_ClusterID_Lighting_Color_Control},
			#{version=>?ZIGBEE_CONFIG_VER,
				data=>
				[
					<<"0003">>,
					<<"0004">>,
					<<"0010">>,
					<<"0011">>,
					<<"0012">>,
					<<"0015">>,
					<<"0016">>,
					<<"0019">>,
					<<"001A">>

				]}
		}
	]).

-define(NETVOX_HEARTBEAT_INTERVAL, <<16#00000078:32>>). %send Ias hartbeat every 5 min
-define(ZigBEE_ZDO_Profile, <<16#0000:16>>).
-define(ZigBEE_HA_Profile, <<16#0104:16>>).
-define(ZigBEE_LL_Profile, <<16#0101:16>>).


-define(ZigBEE_ZDO_Network_16_bit_Address_Request, <<16#0000:16>>).
-define(ZigBEE_ZDO_Network_16_bit_Address_Response, <<16#8000:16>>).
-define(ZigBEE_ZDO_IEEE_64_bit_Address_Request, <<16#0001:16>>).
-define(ZigBEE_ZDO_IEEE_64_bit_Address_Response, <<16#8001:16>>).
-define(ZigBEE_ZDO_Power_Descriptor_Request, <<16#0003:16>>).
-define(ZigBEE_ZDO_Power_Descriptor_Response, <<16#8003:16>>).
-define(ZigBEE_ZDO_Node_Descriptor_Request, <<16#0002:16>>).
-define(ZigBEE_ZDO_Node_Descriptor_Response, <<16#8002:16>>).
-define(ZigBEE_ZDO_Simple_Descriptor_Request, <<16#0004:16>>).
-define(ZigBEE_ZDO_Simple_Descriptor_Response, <<16#8004:16>>).
-define(ZigBEE_ZDO_Active_Endpoints_Request, <<16#0005:16>>).
-define(ZigBEE_ZDO_Active_Endpoints_Response, <<16#8005:16>>).
-define(ZigBEE_ZDO_Match_Descriptor_Request, <<16#0006:16>>).
-define(ZigBEE_ZDO_Match_Descriptor_Response, <<16#8006:16>>).
-define(ZigBEE_ZDO_Complex_Descriptor_Request, <<16#0010:16>>).
-define(ZigBEE_ZDO_Complex_Descriptor_Response, <<16#8010:16>>).
-define(ZigBEE_ZDO_User_Descriptor_Request, <<16#0011:16>>).
-define(ZigBEE_ZDO_User_Descriptor_Response, <<16#8011:16>>).
-define(ZigBEE_ZDO_User_Descriptor_Set, <<16#0014:16>>).
-define(ZigBEE_ZDO_Management_Network_Discovery_Request, <<16#0030:16>>).
-define(ZigBEE_ZDO_Management_Network_Discovery_Response, <<16#8030:16>>).
-define(ZigBEE_ZDO_Management_LQI_Neighbor_Table_Request, <<16#0031:16>>).
-define(ZigBEE_ZDO_Management_LQI_Neighbor_Table_Response, <<16#8031:16>>).
-define(ZigBEE_ZDO_Management_Rtg_Routing_Table_Request, <<16#0032:16>>).
-define(ZigBEE_ZDO_Management_Rtg_Routing_Table_Response, <<16#8032:16>>).
-define(ZigBEE_ZDO_Management_Leave_Request, <<16#0034:16>>).
-define(ZigBEE_ZDO_Management_Leave_Response, <<16#8034:16>>).
-define(ZigBEE_ZDO_Management_Permit_Join_Request, <<16#0036:16>>).
-define(ZigBEE_ZDO_Management_Permit_Join_Response, <<16#8036:16>>).
-define(ZigBEE_ZDO_Management_Network_Update_Request, <<16#0038:16>>).
-define(ZigBEE_ZDO_Management_Network_Update_Notify, <<16#8038:16>>).
-define(ZigBEE_ZDO_Bind_Endpoint_Request, <<16#0021:16>>).
-define(ZigBEE_ZDO_Bind_Endpoint_Response, <<16#8021:16>>).
-define(ZigBEE_ZDO_Device_Announce, <<16#0013:16>>).

-define(ZigBEE_CMDID_Read_Attribute, <<16#00:8>>).
-define(ZigBEE_CMDID_Read_Attribute_Response, <<16#01:8>>).
-define(ZigBEE_CMDID_Write_Attribute, <<16#02:8>>).
-define(ZigBEE_CMDID_Write_Attribute_undivided, <<16#03:8>>).
-define(ZigBEE_CMDID_Write_Attribute_Response, <<16#04:8>>).
-define(ZigBEE_CMDID_Write_Attribute_No_Response, <<16#05:8>>).
-define(ZigBEE_CMDID_Configure_Reporting, <<16#06:8>>).
-define(ZigBEE_CMDID_Configure_Reporting_Response, <<16#07:8>>).
-define(ZigBEE_CMDID_Read_Reporting_Configuration, <<16#08:8>>).
-define(ZigBEE_CMDID_Read_Reporting_Configuration_Response, <<16#09:8>>).
-define(ZigBEE_CMDID_Report_Attribute, <<16#0A:8>>).
-define(ZigBEE_CMDID_Default_Response, <<16#0B:8>>).
-define(ZigBEE_CMDID_Discover_Attribute, <<16#0C:8>>).
-define(ZigBEE_CMDID_Discover_Attribute_Response, <<16#0D:8>>).


-define(ZigBEE_ClusterID_Basic, <<16#0000:16>>).
-define(ZigBEE_ClusterID_Power_Configuration, <<16#0001:16>>).
-define(ZigBEE_ClusterID_Device_Temperature_Configuration, <<16#0002:16>>).

-define(ZigBEE_ClusterID_Indentify, <<16#0003:16>>).
-define(ZigBEE_ClusterID_Indentify_CMD_BLINK, <<16#00:8>>).

-define(ZigBEE_ClusterID_Groups, <<16#0004:16>>).
-define(ZigBEE_ClusterID_Groups_CMDID_AddGroup, <<16#00:8>>).
-define(ZigBEE_ClusterID_Groups_CMDID_AddGroup_response, <<16#00:8>>).
-define(ZigBEE_ClusterID_Groups_CMDID_RemoveGroup, <<16#03:8>>).
-define(ZigBEE_ClusterID_Groups_CMDID_RemoveGroup_response, <<16#03:8>>).

-define(ZigBEE_ClusterID_Scenes, <<16#0005:16>>).

-define(ZigBEE_ClusterID_Scenes_CMDID_AddScene, <<16#00:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_AddScene_response, <<16#00:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_ViewScene, <<16#01:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_ViewScene_response, <<16#01:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RemoveScene, <<16#02:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RemoveScene_response, <<16#02:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RemoveAllScene, <<16#03:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RemoveAllScene_response, <<16#03:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_StoreScene, <<16#04:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_StoreScene_response, <<16#04:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RecallScene, <<16#05:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_RecallScene_response, <<16#05:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_GetSceneMember, <<16#06:8>>).
-define(ZigBEE_ClusterID_Scenes_CMDID_GetSceneMember_response, <<16#06:8>>).



-define(ZigBEE_ClusterID_CheckIn, <<16#0020:16>>).

-define(ZigBEE_ClusterID_On_Off, <<16#0006:16>>).
-define(ZigBEE_ClusterID_On_Off_CMD_ON, <<16#01:8>>).
-define(ZigBEE_ClusterID_On_Off_CMD_OFF, <<16#00:8>>).
-define(ZigBEE_ClusterID_On_Off_CMD_TOGGLE, <<16#02:8>>).

-define(ZigBEE_ClusterID_On_Off_Switch_Configuration, <<16#0007:16>>).

-define(ZigBEE_ClusterID_Level_Control, <<16#0008:16>>).
-define(ZigBEE_ClusterID_Level_Control_CMD_Move_to_Level_with_On_Off, <<16#04:8>>).

-define(ZigBEE_ClusterID_Alarms, <<16#0009:16>>).
-define(ZigBEE_ClusterID_Time, <<16#000A:16>>).
-define(ZigBEE_ClusterID_RSSI_Location, <<16#000B:16>>).
-define(ZigBEE_ClusterID_OTA, <<16#0019:16>>).
-define(ZigBEE_ClusterID_OTA_CMD_Notify, <<16#00:8>>).
-define(ZigBEE_ClusterID_OTA_CMD_Image_Req, <<16#01:8>>).
-define(ZigBEE_ClusterID_OTA_CMD_Image_Resp, <<16#02:8>>).

-define(ZigBEE_ClusterID_OTA_CMD_Image_BLOCK_Req, <<16#03:8>>).
-define(ZigBEE_ClusterID_OTA_CMD_Image_BLOCK_Resp, <<16#05:8>>).

-define(ZigBEE_ClusterID_OTA_CMD_Update_End_Req, <<16#06:8>>).
-define(ZigBEE_ClusterID_OTA_CMD_Update_End_Resp, <<16#07:8>>).


-define(ZigBEE_ClusterID_Closures_Shade_Configuration, <<16#0100:16>>).

-define(ZigBEE_ClusterID_Door_Lock, <<16#0101:16>>).
-define(ZigBEE_ClusterID_Door_Lock_CMD_Lock, <<16#00:8>>).
-define(ZigBEE_ClusterID_Door_Lock_CMD_Lock_Response, <<16#00:8>>).
-define(ZigBEE_ClusterID_Door_Lock_CMD_Unlock, <<16#01:8>>).
-define(ZigBEE_ClusterID_Door_Lock_CMD_Unlock_Response, <<16#01:8>>).
-define(ZigBEE_ClusterID_Door_Lock_CMD_SET_PIN, <<16#05:8>>).
-define(ZigBEE_ClusterID_Door_Lock_Operation_Event_Notification, <<16#20:8>>).


-define(ZigBEE_ClusterID_Door_Lock_EventCode_UnknownOrMfgSpecific, <<16#00:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_Lock, <<16#01:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_Unlock, <<16#02:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_LockFailureInvalidPINorID, <<16#03:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_LockFailureInvalidSchedule, <<16#04:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_UnlockFailureInvalidPINorID, <<16#05:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_UnlockFailureInvalidSchedule, <<16#06:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_OneTouchLock, <<16#07:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_KeyLock, <<16#08:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_KeyUnlock, <<16#09:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_AutoLock, <<16#0a:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_ScheduleLock, <<16#0b:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_ScheduleUnlock, <<16#0c:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_Manual_Lock, <<16#0d:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_Manual_Unlock, <<16#0e:8>>).
-define(ZigBEE_ClusterID_Door_Lock_EventCode_NonAccessUserOperationalEvent, <<16#0f:8>>).




-define(ZigBEE_ClusterID_Pump_Configuration_and_Control, <<16#0200:16>>).
-define(ZigBEE_ClusterID_Thermostat, <<16#0201:16>>).

% ZCL 1.2 6.3.2.2.1 Thermostat Information Attribute Set
-define(ZigBEE_ClusterID_Thermostat_AttributeID_LocalTemperature, <<16#0000:16>>). % mandatory
-define(ZigBEE_ClusterID_Thermostat_AttributeID_OutdoorTemperature, <<16#0001:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_Occupancy, <<16#0002:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_AbsMinHeatSetpointLimit, <<16#0003:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_AbsMaxHeatSetpointLimit, <<16#0004:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_AbsMinCoolSetpointLimit, <<16#0005:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_AbsMaxCoolSetpointLimit, <<16#0006:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_PICoolingDemand, <<16#0007:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_PIHeatingDemand, <<16#0008:16>>).

% ZCL 1.2 6.4.2.2.2 Thermostat Settings Attribute Set
-define(ZigBEE_ClusterID_Thermostat_AttributeID_LocalTemperatureCalibration, <<16#0010:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_OccupiedCoolingSetpoint, <<16#0011:16>>). % mandatory
-define(ZigBEE_ClusterID_Thermostat_AttributeID_OccupiedHeatingSetpoint, <<16#0012:16>>). % mandatory
-define(ZigBEE_ClusterID_Thermostat_AttributeID_UnoccupiedCoolingSetpoint, <<16#0013:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_UnoccupiedHeatingSetpoint, <<16#0014:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_MinHeatSetpointLimit, <<16#0015:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_MaxHeatSetpointLimit, <<16#0016:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_MinCoolSetpointLimit, <<16#0017:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_MaxCoolSetpointLimit, <<16#0018:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_MinSetpointDeadBand, <<16#0019:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_RemoteSensing, <<16#001A:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_ControlSequenceOfOperation, <<16#001B:16>>). % mandatory
-define(ZigBEE_ClusterID_Thermostat_AttributeID_SystemMode, <<16#001C:16>>). % mandatory
-define(ZigBEE_ClusterID_Thermostat_AttributeID_AlarmMask, <<16#001D:16>>).

% ZCL 1.2 6.3.2.3 Commands Received
-define(ZigBEE_ClusterID_Thermostat_CMD_SetpointChange, <<16#00:08>>).

% manufacturer specific CMDs and AttributeIDs not documented in ZCL 1.2 section 6.3 "Thermostat Cluster"
-define(ZigBEE_ClusterID_Thermostat_CMD_SetWeekSchedule, <<16#01:08>>).
-define(ZigBEE_ClusterID_Thermostat_CMD_GetWeekSchedule, <<16#02:08>>).
-define(ZigBEE_ClusterID_Thermostat_CMD_ClearWeekSchedule, <<16#03:08>>).

-define(ZigBEE_ClusterID_Thermostat_AttributeID_Budget, <<16#0101:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_SetHold, <<16#0023:16>>).
-define(ZigBEE_ClusterID_Thermostat_AttributeID_SetHoldpointDuration, <<16#0024:16>>).

-define(ZigBEE_ClusterID_Fan_Control, <<16#0202:16>>).
-define(ZigBEE_ClusterID_Dehumidification_Control, <<16#0203:16>>).
-define(ZigBEE_ClusterID_Thermostat_User_Interface_Configuration, <<16#0204:16>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control, <<16#0300:16>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control_CMD_MOVE2COLOR, <<16#07:8>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control_CMD_MOVE2Saturation, <<16#03:8>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control_CMD_MOVE2HUE_Saturation, <<16#06:8>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control_CMD_MOVE2HUE, <<16#00:8>>).
-define(ZigBEE_ClusterID_Lighting_Color_Control_Tune_White, <<16#0A:8>>).
-define(ZigBEE_ClusterID_Ballast_Configuration, <<16#0301:16>>).
-define(ZigBEE_ClusterID_Luminance_Measurement, <<16#0400:16>>).
-define(ZigBEE_ClusterID_Luminance_Level_Sensing, <<16#0401:16>>).
-define(ZigBEE_ClusterID_Temperature_Measurement, <<16#0402:16>>).
-define(ZigBEE_ClusterID_Pressure_Measurement, <<16#0403:16>>).
-define(ZigBEE_ClusterID_Flow_Measurement, <<16#0404:16>>).
-define(ZigBEE_ClusterID_Relative_Humidity_Measurement, <<16#0405:16>>).
-define(ZigBEE_ClusterID_CENTRALITE_Relative_Humidity_Measurement, <<16#FC45:16>>).
-define(ZigBEE_ClusterID_Occupancy_sensing, <<16#0406:16>>).
-define(ZigBEE_ClusterID_IAS_Zone, <<16#0500:16>>).
-define(ZigBEE_ClusterID_IAS_ACE, <<16#0501:16>>).
-define(ZigBEE_ClusterID_IAS_Zone_ENROLL_REQUEST,<<16#01>>).
-define(ZigBEE_ClusterID_IAS_Zone_CHANGE_NOTIFICATION, <<16#00>>).


-define(ZigBEE_ClusterID_IAS_WD, <<16#0502:16>>).
-define(ZigBEE_ClusterID_IAS_WD_CMD_Start_warning, <<16#00:8>>).
-define(ZigBEE_ClusterID_IAS_WD_CMD_Squawk, <<16#01:8>>).

-define(ZigBEE_ClusterID_IAS_WD_CMD_BURGLAR, <<16#11ffff:24>>).
-define(ZigBEE_ClusterID_IAS_WD_CMD_FIRE, <<16#12ffff:24>>).
-define(ZigBEE_ClusterID_IAS_WD_CMD_EMERGENCY, <<16#13ffff:24>>).
-define(ZigBEE_ClusterID_IAS_WD_CMD_STOP_WARNING, <<16#000000:24>>).


-define(ZigBEE_ClusterID_Power_Measurement, <<16#0702:16>>).
-define(ZigBEE_ClusterID_Centralite_Power_Measurement, <<16#0B04:16>>).
-define(ZigBEE_DataType_No_Data_0, <<16#00:8>>).

-define(ZigBEE_DataType_8_bit_Data_1, <<16#08:8>>).
-define(ZigBEE_DataType_16_bit_Data_2, <<16#09:8>>).
-define(ZigBEE_DataType_24_bit_Data_3, <<16#0A:8>>).
-define(ZigBEE_DataType_32_bit_Data_4, <<16#0B:8>>).
-define(ZigBEE_DataType_40_bit_Data_5, <<16#0c:8>>).
-define(ZigBEE_DataType_48_bit_Data_6, <<16#0d:8>>).
-define(ZigBEE_DataType_56_bit_Data_7, <<16#0e:8>>).
-define(ZigBEE_DataType_64_bit_Data_8, <<16#0f:8>>).

-define(ZigBEE_DataType_Boolean_1, <<16#10:8>>).

-define(ZigBEE_DataType_8_bit_bitmap_1, <<16#18:8>>).
-define(ZigBEE_DataType_16_bit_bitmap_2, <<16#19:8>>).
-define(ZigBEE_DataType_24_bit_bitmap_3, <<16#1A:8>>).
-define(ZigBEE_DataType_32_bit_bitmap_4, <<16#1B:8>>).
-define(ZigBEE_DataType_40_bit_bitmap_5, <<16#1c:8>>).
-define(ZigBEE_DataType_48_bit_bitmap_6, <<16#1d:8>>).
-define(ZigBEE_DataType_56_bit_bitmap_7, <<16#1e:8>>).
-define(ZigBEE_DataType_64_bit_bitmap_8, <<16#1f:8>>).

-define(ZigBEE_DataType_Unsigned_8_bit_integer_1, <<16#20:8>>).
-define(ZigBEE_DataType_Unsigned_16_bit_integer_2, <<16#21:8>>).
-define(ZigBEE_DataType_Unsigned_24_bit_integer_3, <<16#22:8>>).
-define(ZigBEE_DataType_Unsigned_32_bit_integer_4, <<16#23:8>>).
-define(ZigBEE_DataType_Unsigned_40_bit_integer_5, <<16#24:8>>).
-define(ZigBEE_DataType_Unsigned_48_bit_integer_6, <<16#25:8>>).
-define(ZigBEE_DataType_Unsigned_56_bit_integer_7, <<16#26:8>>).
-define(ZigBEE_DataType_Unsigned_64_bit_integer_8, <<16#27:8>>).



-define(ZigBEE_DataType_Signed_8_bit_integer_1, <<16#28:8>>).
-define(ZigBEE_DataType_Signed_16_bit_integer_2, <<16#29:8>>).
-define(ZigBEE_DataType_Signed_24_bit_integer_3, <<16#2A:8>>).
-define(ZigBEE_DataType_Signed_32_bit_integer_4, <<16#2B:8>>).
-define(ZigBEE_DataType_Signed_40_bit_integer_5, <<16#2c:8>>).
-define(ZigBEE_DataType_Signed_48_bit_integer_6, <<16#2d:8>>).
-define(ZigBEE_DataType_Signed_56_bit_integer_7, <<16#2e:8>>).
-define(ZigBEE_DataType_Signed_64_bit_integer_8, <<16#2f:8>>).

-define(ZigBEE_DataType_8_bit_enumeration_1, <<16#30:8>>).
-define(ZigBEE_DataType_16_bit_enumeration_2, <<16#31:8>>).

-define(ZigBEE_DataType_Semi_precision_2, <<16#38:8>>).
-define(ZigBEE_DataType_Single_precision_4, <<16#39:8>>).
-define(ZigBEE_DataType_Double_precision_8, <<16#3A:8>>).

-define(ZigBEE_DataType_Octet_String, <<16#41:8>>).
-define(ZigBEE_DataType_Character_String, <<16#42:8>>).
-define(ZigBEE_DataType_LongOctet_String, <<16#43:8>>).
-define(ZigBEE_DataType_LongChar_String, <<16#44:8>>).

-define(ZigBEE_DataType_Time_of_day_4, <<16#E0:8>>).
-define(ZigBEE_DataType_Date_4, <<16#E1:8>>).
-define(ZigBEE_DataType_UTC_TIME, <<16#E2:8>>).
-define(ZigBEE_DataType_Cluster_ID_2, <<16#E8:8>>).
-define(ZigBEE_DataType_Attribute_ID_2, <<16#E9:8>>).
-define(ZigBEE_DataType_BACnet_OID_4, <<16#EA:8>>).
-define(ZigBEE_DataType_IEEE_Address_8, <<16#F0:8>>).
-define(ZigBEE_DataType_128_Security_16, <<16#F1:8>>).
%special roc datatype for json
-define(ZigBEE_DataType_JSON, <<16#F2:8>>).
-define(ZigBEE_DataType_Unknown_0, <<16#FF:8>>).

-define(ZigBEE_Success, <<16#00:8>>).
-define(ZigBEE_Failure, <<16#01:8>>).


-define(ZigBEE_BasicAttr_ZCLVersion, <<16#0000:16>>).
-define(ZigBEE_BasicAttr_ApplicationVersion, <<16#0001:16>>).
-define(ZigBEE_BasicAttr_StackVersion, <<16#0002:16>>).
-define(ZigBEE_BasicAttr_HWVersion, <<16#0003:16>>).
-define(ZigBEE_BasicAttr_ManufacturerName, <<16#0004:16>>).
-define(ZigBEE_BasicAttr_ModelIdentifier, <<16#0005:16>>).
-define(ZigBEE_BasicAttr_DateCode, <<16#0006:16>>).
-define(ZigBEE_BasicAttr_PowerSource, <<16#0007:16>>).


-define(ZigBEE_IAS_ZoneType_Contact_Switch, <<16#0015:16>>).
-define(ZigBEE_IAS_ZoneType_Key_FOB, <<16#0115:16>>).
-define(ZigBEE_IAS_ZoneType_Motion_Sensor, <<16#000D:16>>).
-define(ZigBEE_IAS_ZoneType_Fire_Sensor, <<16#0028:16>>).
-define(ZigBEE_IAS_ZoneType_Gas_Sensor, <<16#002B:16>>).
-define(ZigBEE_IAS_ZoneType_PENDANT_Sensor, <<16#002C:16>>).
-define(ZigBEE_IAS_ZoneType_Vibration_Sensor, <<16#002D:16>>).
-define(ZigBEE_IAS_ZoneType_Water_Sensor, <<16#002A:16>>).
-define(ZigBEE_IAS_ZoneType_Standard_Warning_Device, <<16#0225:16>>).
-define(ZigBEE_IAS_AttrID_ZoneType, <<16#0001:16>>).
-define(ZigBEE_IAS_AttrID_CIE_Address, <<16#0010:16>>).
-define(ZigBEE_IAS_AttrID_VibrationSens, <<16#1000:16>>).

-define(ZigBEE_ZDO_ENDPOINT, <<16#00:8>>).

-define(ZIGBEE_APPID_OnOff_Switch, <<16#0000:16>>).
-define(ZIGBEE_APPID_Level_Control_Switch, <<16#0001:16>>).
-define(ZIGBEE_APPID_OnOff_Output, <<16#0002:16>>).
-define(ZIGBEE_APPID_Level_Controllable_Output, <<16#0003:16>>).
-define(ZIGBEE_APPID_Scene_Selector, <<16#0004:16>>).
-define(ZIGBEE_APPID_Configuration_Tool, <<16#0005:16>>).
-define(ZIGBEE_APPID_Remote_Control, <<16#0006:16>>).
-define(ZIGBEE_APPID_Combined_Interface, <<16#0007:16>>).
-define(ZIGBEE_APPID_Range_Extender, <<16#0008:16>>).
-define(ZIGBEE_APPID_Mains_Power_Outlet, <<16#0009:16>>).
-define(ZIGBEE_APPID_Door_Lock, <<16#000A:16>>).
-define(ZIGBEE_APPID_Door_Lock_Controller, <<16#000B:16>>).
-define(ZIGBEE_APPID_Simple_Sensor, <<16#000C:16>>).
-define(ZIGBEE_APPID_Consumption_Awareness_Device, <<16#000D:16>>).
-define(ZIGBEE_APPID_Home_Gateway, <<16#0050:16>>).
-define(ZIGBEE_APPID_Smart_plug, <<16#0051:16>>).
-define(ZIGBEE_APPID_White_Goods, <<16#0052:16>>).
-define(ZIGBEE_APPID_Meter_Interface, <<16#0053:16>>).
-define(ZIGBEE_APPID_OnOff_Light, <<16#0100:16>>).
-define(ZIGBEE_APPID_Dimmable_Light, <<16#0101:16>>).
-define(ZIGBEE_APPID_Color_Dimmable_Light, <<16#0102:16>>).
-define(ZIGBEE_APPID_OnOff_Light_Switch, <<16#0103:16>>).
-define(ZIGBEE_APPID_Color_Tunable_Light, <<16#F102:16>>).
-define(ZIGBEE_APPID_Color_White_Tunable_Light, <<16#F103:16>>).
-define(ZIGBEE_APPID_Dimmer_Switch, <<16#0104:16>>).
-define(ZIGBEE_APPID_Color_Dimmer_Switch, <<16#0105:16>>).
-define(ZIGBEE_APPID_Light_Sensor, <<16#0106:16>>).
-define(ZIGBEE_APPID_Occupancy_Sensor, <<16#0107:16>>).
-define(ZIGBEE_APPID_Shade, <<16#0200:16>>).
-define(ZIGBEE_APPID_Shade_Controller, <<16#0201:16>>).
-define(ZIGBEE_APPID_Window_Covering_Device, <<16#0202:16>>).
-define(ZIGBEE_APPID_Window_Covering_Controller, <<16#0203:16>>).
-define(ZIGBEE_APPID_HeatingCooling_Unit, <<16#0300:16>>).
-define(ZIGBEE_APPID_Thermostat, <<16#0301:16>>).
-define(ZIGBEE_APPID_Temperature_Sensor, <<16#0302:16>>).
-define(ZIGBEE_APPID_Pump, <<16#0303:16>>).
-define(ZIGBEE_APPID_Pump_Controller, <<16#0304:16>>).
-define(ZIGBEE_APPID_Pressure_Sensor, <<16#0305:16>>).
-define(ZIGBEE_APPID_Flow_Sensor, <<16#0306:16>>).
-define(ZIGBEE_APPID_Mini_Split_AC, <<16#0307:16>>).
-define(ZIGBEE_APPID_IAS_Control_and_Indicating_Equipment, <<16#0400:16>>).
-define(ZIGBEE_APPID_IAS_Ancillary_Control_Equipment, <<16#0401:16>>).
-define(ZIGBEE_APPID_IAS_Zone, <<16#0402:16>>).
-define(ZIGBEE_APPID_IAS_Warning_Device, <<16#0403:16>>).
-define(ZIGBEE_APPID_Tunable_LEDs,<<16#F102:16>>).
-define(ZIGBEE_APPID_Tunable_LEDs_2, <<16#0220:16>>).

-define(ZIGBEE_APPID_Color_Dimmable_Light_2, <<16#010C:16>>).
-define(ZIGBEE_APPID_Color_Dimmable_Light_3, <<16#010D:16>>).
-define(ZIGBEE_APPID_Color_Dimmable_Light_4, <<16#0210:16>>).

