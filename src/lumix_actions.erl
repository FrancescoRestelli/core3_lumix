%%%-------------------------------------------------------------------
%%% @author francesco
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%   inbound actions from app side
%%% @end
%%% Created : 31. Jän 2020 20:39
%%%-------------------------------------------------------------------
-module(lumix_actions).
-author("francesco").

-include_lib("common.hrl").
-include_lib("zigBeeDEF.hrl").

-export([
	sendActionCmd/5,
	sendGeneralCmd/5,getUrl/3]).


%% ------------------------------------Dev Worker API -------------------------------------------------------
sendActionCmd(NodeID, MAC, EP, #{<<"clusterId">> := ClusterID, <<"cmdId">> := CmdID, <<"value">> := Value} =
	Json, State) ->
	BClusterID = utils_data_format:hex_to_bin(ClusterID),
	BCMDID = utils_data_format:hex_to_bin(CmdID),
	SValues = case Value of
		_ when is_binary(Value) ->
			string:tokens(binary_to_list(Value), ",");
		_ when is_integer(Value) ->
			[integer_to_list(Value, 16)];
		_ when is_list(Value) ->
			string:tokens(Value, ",")
	end,
%%  Some data is not hex so it will crash, for this reason we catch it and
%%  forward the original data
	BValue = try
		lists:foldl(
			fun(Val, Acc) ->
				A = utils_data_format:hex_to_bin(list_to_binary(Val)),
				<<Acc/binary, A/binary>>
			end, <<>>, SValues)
	catch
		_:_ ->
			Value
	end,
	{NMAP, NS} = case clusterCmds(MAC, NodeID, EP, State, Json, BClusterID, BCMDID, BValue) of
		{<<RCMDID:1/binary, DATA/binary>>, NewState} ->
			{#{
				info => sendActionCmd,
				status => ok,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => utils_data_format:bin_to_hex(RCMDID),
				data => utils_data_format:bin_to_hex(DATA)
			}, NewState};
		{bstring, Answer, NewState} ->
			{#{
				info => sendActionCmd,
				status => ok,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID,
				data => Answer
			}, NewState};
		{error, Error, NewState} ->
			{#{
				info => sendActionCmd,
				status => error,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID,
				data => Error
			}, NewState};
		{Else, NewState} -> ?red("bad response ~p ", [Else]),
			{#{
				info => sendActionCmd,
				status => error,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID
			}, NewState}
	end,
	{reply, NMAP, NS};

sendActionCmd(NodeID, MAC, EP, #{<<"clusterId">> := ClusterID, <<"cmdId">> := CmdID} = Json, State) ->
	BClusterID = utils_data_format:hex_to_bin(ClusterID),
	BCMDID = utils_data_format:hex_to_bin(CmdID),
	{NMAP, NS} = case clusterCmds(MAC, BCMDID, EP, State, Json, BClusterID, BCMDID) of
		{<<RCMDID:1/binary, DATA/binary>>, NewState} ->
			{#{
				info => sendActionCmd,
				status => ok,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => utils_data_format:bin_to_hex(RCMDID),
				data => utils_data_format:bin_to_hex(DATA)
			}, NewState};
		{bstring, Answer, NewState} ->
			{#{
				info => sendActionCmd,
				status => ok,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID,
				data => Answer
			}, NewState};
		{error, Error, NewState} ->
			{#{
				info => sendActionCmd,
				status => error,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID,
				data => Error
			}, NewState};
		{Else, NewState} -> ?red("bad response ~p ", [Else]),
			{#{
				info => sendActionCmd,
				status => error,
				clusterId => ClusterID,
				sourceAction => Json,
				cmdId => CmdID
			}, NewState}
	end,
	{reply, NMAP, NS}.



sendGeneralCmd(NodeID, MAC, EP, #{<<"clusterId">> := ClusterID, <<"cmdId">> := <<"00">> = CMDID} = Json, State) ->
%%	BCMDID = utils_data_format:hex_to_bin(CMDID),
%%	BClusterID = utils_data_format:hex_to_bin(ClusterID),
%%	RValue = case Json of
%%		#{<<"values">> := Values} when is_list(Values) ->
%%			lists:foldl(fun(Elem, Acc) ->
%%				[utils_data_format:hex_to_bin(Elem) | Acc] end, [], Values);
%%		#{<<"values">> := Value} ->
%%			[utils_data_format:hex_to_bin(Value)];
%%		_ ->
%%			[]
%%	end,
%%	Caps = maps:get(<<"caps">>, Json, notfound),
%%	Endpoint = maps:get(<<"endpoint">>, Json, notfound),
%%	DeviceId = maps:get(<<"deviceId">>, Json, notfound),
%%
%%	NMap = #{
%%		caps => Caps,
%%		endpoint => Endpoint,
%%		deviceId => DeviceId,
%%		info => sendGeneralCmd,
%%		clusterId => ClusterID,
%%		cmdId => CMDID,
%%		sourceAction => Json,
%%		status => ok
%%	},
%%	AllMaps = lists:foldl(fun(CMD, Acc) ->
%%		NMAP = case generalReadCmds(MAC, NodeID, EP, BClusterID, BCMDID, CMD) of
%%			<<DATA/binary>> ->
%%				maps:put(utils_data_format:hex_to_bin(CMD), utils_data_format:hex_to_bin(DATA), #{});
%%			error ->
%%				?red("Bad Response"),
%%				#{
%%					status => error
%%				};
%%			Other ->
%%				maps:put(CMD, Other, #{})
%%		end,
%%		Result = case NMAP of
%%			Else1 when is_list(NMAP), is_map(Acc) -> Else1;
%%			_Else1 when is_list(NMAP), is_list(Acc) -> lists:merge(NMAP, Acc);
%%			_Else1 -> maps:merge(NMAP, Acc)
%%		end,
%%		?yellow("Result:~p", [Result]),
%%		Result
%%
%%	end, #{}, RValue),
%%	?yellow("ALLMAPS:~p", [AllMaps]),
%%	OutMap = maps:merge(#{data => AllMaps}, NMap),
	{ok, State};

sendGeneralCmd(NodeID, MAC, EP, #{<<"clusterId">> := ClusterID, <<"cmdId">> := <<"02">> = CMDID} = Json, State) ->
%%	BClusterID = utils_data_format:hex_to_bin(ClusterID),
%%	RValue = case Json of
%%		#{<<"values">> := Values} when is_list(Values) ->
%%			lists:foldl(
%%				fun
%%%%					Boolean
%%					(#{<<"id">> := AttID, <<"datatype">> := <<"10">> = DataType, <<"value">> := String}, Acc) ->
%%						[{utils_data_format:hex_to_bin(AttID), utils_data_format:hex_to_bin(DataType), String} | Acc];
%%%%          Integer
%%%%          json module should already take care of the conversion
%%					(#{<<"id">> := AttID, <<"datatype">> := <<"20">> = DataType, <<"value">> := Int}, Acc) ->
%%						[{utils_data_format:hex_to_bin(AttID), utils_data_format:hex_to_bin(DataType), Int} | Acc];
%%
%%%%					String
%%					(#{<<"id">> := AttID, <<"datatype">> := <<"41">> = DataType, <<"value">> := String}, Acc) ->
%%						[{utils_data_format:hex_to_bin(AttID), utils_data_format:hex_to_bin(DataType), binary_to_list(
%%							String)} | Acc];
%%%%					General value
%%					(#{<<"id">> := AttID, <<"datatype">> := Datatype, <<"value">> := Value}, Acc) ->
%%						[{utils_data_format:hex_to_bin(AttID), utils_data_format:hex_to_bin(
%%							Datatype), utils_data_format:hex_to_bin(Value)} | Acc];
%%
%%					(_, Acc) ->
%%						Acc
%%				end, [], Values);
%%		#{<<"values">> := Value} ->
%%			[utils_data_format:hex_to_bin(Value)];
%%		_ ->
%%			[]
%%	end,
%%	?yellow("RValue: <w~p/>", [RValue]),
%%	Caps = maps:get(<<"caps">>, Json, notfound),
%%	Endpoint = maps:get(<<"endpoint">>, Json, notfound),
%%	DeviceId = maps:get(<<"deviceId">>, Json, notfound),
%%
%%	NMap = #{
%%		caps => Caps,
%%		endpoint => Endpoint,
%%		deviceId => DeviceId,
%%		info => sendGeneralCmd,
%%		clusterId => ClusterID,
%%		cmdId => CMDID,
%%		sourceAction => Json,
%%		status => ok
%%	},
%%	AllMaps = lists:foldl(fun({AttID, DataType, Value}, Acc) ->
%%		NMAP = case generalWriteCmds(MAC, NodeID, EP, BClusterID, AttID, DataType, Value) of
%%			<<DATA/binary>> ->
%%				maps:put(utils_data_format:bin_to_hex(AttID), utils_data_format:bin_to_hex(DATA), #{});
%%			error ->
%%				?red("Bad Response"),
%%				#{
%%					status => error
%%				};
%%			Other ->
%%				maps:put(AttID, Other, #{})
%%		end,
%%		Result = case NMAP of
%%			Else1 when is_list(NMAP), is_map(Acc) -> Else1;
%%			_Else1 when is_list(NMAP), is_list(Acc) -> lists:merge(NMAP, Acc);
%%			_Else1 -> maps:merge(NMAP, Acc)
%%		end,
%%		?yellow("Result:~p", [Result]),de
%%		Result
%%
%%	end, #{}, RValue),
%%	?yellow("ALLMAPS:~p", [AllMaps]),
%%	OutMap = maps:merge(#{data => AllMaps}, NMap),
	{ok, State};

sendGeneralCmd(_, _MAC, _, #{<<"clusterId">> := ClusterID, <<"cmdId">> := CMDID} = Json, State) ->
	?red("Received unknown sendGeneralCMD ClusterID ~p CmdID ~p", [ClusterID, CMDID]),
	{reply, #{
		info => sendGeneralCmd,
		clusterId => ClusterID,
		cmdId => CMDID,
		sourceAction => Json,
		status => error
	}, State}.

%EP 1 override we enable the wifi apcli & wait for the cam
%curl -s "http://192.168.54.1:60606/A0C9A02BA64D/Server0/ddd"
%curl -s "http://192.168.54.1/cam.cgi?mode=accctrl&type=req_acc&value=4D454930-0100-1000-8000-A0C9A02BA64D&value2=OZOM"
%curl -s "http://192.168.54.1/cam.cgi?mode=getstate"
clusterCmds(MAC, NodeID, <<1>> = Ep, State, _Json, ?ZigBEE_ClusterID_On_Off, ?ZigBEE_ClusterID_On_Off_CMD_ON) ->
	SMAC = utils_data_format:bin_to_hex(MAC),
	SEP = utils_data_format:bin_to_hex(EP),
	?green("CluserCmd MAC: ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p", [SMAC, NodeID, EP, onoff, on]),
	TS = list_to_binary(integer_to_list(trunc(utils_time:timestamp(integer) / 1000000))),
	lumix_multiplex:send_to_device(<<SMAC/binary,"/",SEP/binary,"/P">>, <<"1">>),
	rtrace:on(system_cmd),
	utils_hw:system_cmd("apcli.sh LUMIX",60),
	rtrace:off(system_cmd),
	initCam(),	
	{<<0>>, State};


%apcli.sh LUMIX
clusterCmds(MAC, NodeID, EP, State, _Json, ?ZigBEE_ClusterID_On_Off, ?ZigBEE_ClusterID_On_Off_CMD_ON) ->
	SMAC = utils_data_format:bin_to_hex(MAC),
	SEP = utils_data_format:bin_to_hex(EP),
	?green("CluserCmd MAC: ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p", [SMAC, NodeID, EP, onoff, on]),
	TS = list_to_binary(integer_to_list(trunc(utils_time:timestamp(integer) / 1000000))),
	lumix_multiplex:send_to_device(<<SMAC/binary,"/",SEP/binary,"/P">>, <<"1">>),
	{<<0>>, State};

clusterCmds(MAC, NodeID, EP, State, _Json, ?ZigBEE_ClusterID_On_Off, ?ZigBEE_ClusterID_On_Off_CMD_OFF) ->
	SMAC= utils_data_format:bin_to_hex(MAC),
	SEP = utils_data_format:bin_to_hex(EP),
	?green("CluserCmd MAC: ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p", [SMAC, NodeID, EP, onoff, off]),
	lumix_multiplex:send_to_device(<<SMAC/binary,"/",SEP/binary,"/P">>, <<"0">>),
	{<<0>>, State};



clusterCmds(MAC, NodeID, EP, State, _Json, BClusterID, BCMDID) ->
	?red("CluserCmd MAC: ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p", [MAC, NodeID, EP, BClusterID, BCMDID]),
	{<<BCMDID/binary>>, State}.


clusterCmds(MAC, NodeID, EP, State, _Json, ?ZigBEE_ClusterID_Level_Control, CmdID, <<Level:1/binary, _/binary>>=Value) ->
	SMAC= utils_data_format:bin_to_hex(MAC),
	SEP = utils_data_format:bin_to_hex(EP),
	IntDimmLevel = binary:decode_unsigned(Level),
	?green("CluserCmd MAC: ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p Value:~p", [SMAC, NodeID, EP, CmdID, Value]),
	TS = list_to_binary(integer_to_list(trunc(utils_time:timestamp(integer) / 1000000))),
	lumix_multiplex:send_to_device(<<SMAC/binary,"/",SEP/binary, "/L">>, erlang:integer_to_binary(IntDimmLevel)),
	{<<0>>, State};

clusterCmds(MAC, NodeID, EP, State, _Json, BClusterID, BCMDID, BValue) ->
	?red("ClusterCmd MAC ~p NodeID: ~p EP: ~p ClusterID: ~p CmdID: ~p Value: ~p",
		[MAC, NodeID, EP, BClusterID, BCMDID, utils_data_format:bin_to_hex(BValue)]),
	{<<BCMDID/binary>>, State}.


getUrl(Furl, Timeout, Headers) ->
  ?blue("URL <c~p/>", [Furl]),
  case httpc:request(get, {utils_data_format:ensure_list(Furl), Headers},
    [{timeout, timer:seconds(Timeout)}], []) of

    {ok, {{_, 200, _}, _, Response}} ->
     #{status=>ok,data=>Response};
    Error ->
      ?red("get Error~n~p", [Error]),
      #{status=>error, data=>Error}
  end.


getCurlHeader()->
	[
		{"user-agent", "curl/7.38.0"},
		{"accept", "*/*"}
		
	].


initCam()->
	case waitStart(0) of
		ok->			
			Res=getUrl("http://192.168.54.1/cam.cgi?mode=accctrl&type=req_acc&value=4D454930-0100-1000-8000-A0C9A02BA64D&value2=OZOM",60,getCurlHeader()),
			?green("cam step2~n~p",[Res]),
			Res1=getUrl("http://192.168.54.1/cam.cgi?mode=getstate",60,getCurlHeader()),
			?green("cam step3~n~p",[Res1]);
		Err->?red("cam not ready abort............")	
	end.


	

waitStart(0)->
 	?red("camera did not wake up within timeframe.... todo"),
	 failed;

waitStart(Count)->
	case getUrl("http://192.168.54.1:60606/A0C9A02BA64D/Server0/ddd",60,getCurlHeader()) of
		#{status:=ok}=Res ->?green("cam step 1response 200 ok!~n~p",[Res]),ok;
		Error ->
		?red("cam step 1 failed to respond sleep 30s and retry ~n~p",[Error]),
			waitStart(Count-1)
	end.
