%%%-------------------------------------------------------------------
%%% @author francesco
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%        this file handles mqtt dispatching
%%% @end
%%% Created : 13. Dez 2019 23:31
%%%-------------------------------------------------------------------
-module(lumix_multiplex).
-author("francesco").
-behaviour(gen_server).
-include_lib("common.hrl").
-include_lib("zigBeeDEF.hrl").
-define(AC_CLUSTERID, <<16#F204:16>>).

-export([
	init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3, start_link/1, start_link/0, handle_event/2, stop/0, send_to_device/2]).
%% API
-export([]).


send_to_device(DeviceId, Message) ->
	?cyan("~p ~p", [?MODULE, {push, DeviceId, Message}]),
	gen_server:call(?MODULE, {push, DeviceId, Message}).



start_link(Args) ->
	?cyan("<u~p/> sample starting... wait for db sync", [?MODULE]),

	gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).
start_link() ->
	?cyan("<u~p/> sample starting... wait for db sync", [?MODULE]),
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
init('__events') -> {ok, #{}};

%% Connect to broker when init
init(_Args) ->
	%db:create_table(#{name => tuya_local_keys, storage => disc_copies, type => set, indexes => []}),

	{ok, C} = emqtt:start_link([{host, "localhost"},
		{client_id, <<"simpleClient">>},
		%{msg_handler,fun(Msg)-> ?MODULE ! {mqttInbound,Msg} end},
		{owner, self()},
		{logger, info}]),
	{ok, _Props} = emqtt:connect(C),
	QoS = 1,
	%we subscribe here to any device on this topic
	{ok, _Props, _ReasonCodes} = emqtt:subscribe(C, {<<"ha/lumix/out/#">>, QoS}),
	?yellow("mqtt started~n~p",[C]),
	{ok, #{mqttc => C, seq => 1}}.

% event handling
handle_event(db_ready, State) ->
	?green("<u~p/> DB READY, loading...", [?MODULE]),
	timer:send_after(1000, self(), timeout),
	{ok, State, hibernate};


handle_event(_Event, State) ->
	?cyan("<u~p/>Catchall event ~p", [?MODULE, _Event]),
	{ok, State, hibernate}.

handle_call(stop, _From, State) ->
	{stop, normal, State, hibernate};

handle_call({push, DeviceID, Message}, _FROM, State = #{mqttc := C}) ->
	?cyan("T:~p M:~p", [<<"ha/lumix/in/", DeviceID/binary>>, Message]),
	{reply, emqtt:publish(C, <<"ha/lumix/in/", DeviceID/binary>>, Message, 1), State, hibernate};




handle_call(_Request, _From, State) ->
	{reply, {error, unknown_call}, State, hibernate}.

handle_cast(Msg, State) ->
	?magenta("UNKNOWN MSG ~p", [Msg]),
	{noreply, State, hibernate}.

%bitwise extraction example
%Plasma:1/binary-unit:1, Uk21:2/integer-unit:1, Uk3:2/binary, Uk31:5/integer-unit:1,Active:1/binary-unit:1,

handle_info({publish, #{topic := <<"ha/lumix/out/", DeviceId:12/binary, "/R", Version/binary>>,
	payload := <<Rest/binary>> = Payload}}, State) ->
	BMAC = utils_data_format:hex_to_bin(DeviceId),
	case db:value(devices, BMAC) of
		notfound -> ?yellow("device not found autocreate"),
			%ep 1 has the regular control clusters and the reference temperature
			devdb:addDeviceEP(BMAC, BMAC, <<1>>, ?ROC_PROFILEID, #{}, #{
				<<16#0000:16>> => #{<<16#0004:16>> => <<"ROC">>, <<16#0005:16>> => <<"LUMIX_MQTT">>, <<16#0006:16>> => Version},
				?ZigBEE_ClusterID_On_Off=>#{<<16#0000:16>>=>false}
			},
			#{
					?ROC_CLUSTER_ID_CAMERA_VIDEO => cluster_default(?ROC_CLUSTER_ID_CAMERA_VIDEO),
					?ROC_CLUSTER_ID_CAMERA_CONTROL => cluster_default(?ROC_CLUSTER_ID_CAMERA_CONTROL)

					%	?ZigBEE_ClusterID_Level_Control => #{<<16#0000:16>> => 0},
					%	?ZigBEE_ClusterID_On_Off => #{<<16#0000:16>> => true}
				},  lumix_actions),

			devWorker:spawn_worker(BMAC, BMAC),
			gagent:send_new_device_report(BMAC);
		C ->
			ok
%%			EP = 1,
%%			devReport:sendAttrReport(incapstate, <<BMAC/binary, EP, ?ZigBEE_ClusterID_On_Off:2/binary>>, [
%%				#{id => <<16#0000:16>>, val => val_bool, val_bool => true}]),
%%			devReport:sendAttrReport(incapstate, <<BMAC/binary, EP, ?ZigBEE_ClusterID_Level_Control:2/binary>>, [
%%				#{id => <<16#0000:16>>, val => val_int, val_int => 0}])
	end,
	{noreply, State};



handle_info({publish, #{topic := <<"ha/ac/5557/", Type/binary>>, payload := Payload}}, State) ->
	case Type of
		<<"R">> -> ?red("GOT OLD~s:~p", [Type, utils_data_format:bin_to_hex(Payload)]);
		_ -> ?red("GOT OLD ~s:~p", [Type, utils_data_format:bin_to_hex(Payload)])
	end,
	{noreply, State};

handle_info(Info, State) ->
	?red("GENERAL INFO ~p", [Info]),
	{noreply, State, hibernate}.

terminate(_Reason, _State) ->
	?yellow("IP gen_server terminating..."),
	ok.
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.
stop() ->
	gen_server:call(?MODULE, stop).


%
%%Utility default cluster generator

cluster_default(?ROC_CLUSTER_ID_CAMERA_VIDEO) ->
	#{
		<<16#0001:16>> => <<"SD">>,
		<<16#0002:16>> => false,
		<<16#0003:16>> => false,
		<<16#0004:16>> => true,
		<<16#0005:16>> => 50,
		<<16#0006:16>> => false,
		<<16#0008:16>> => false,
		<<16#000A:16>> => false,
		<<16#0010:16>> => 0
	};

cluster_default(?ROC_CLUSTER_ID_CAMERA_CONTROL) ->
	#{
		<<16#0000:16>> => 50,
		<<16#0001:16>> => 50,
		<<16#0002:16>> => 100,
		<<16#0003:16>> => 0,
		<<16#0004:16>> => 100,
		<<16#0005:16>> => 0,
		<<16#0006:16>> => 1,
		<<16#0007:16>> => true
	};
cluster_default(_) ->
	#{}.
