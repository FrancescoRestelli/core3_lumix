%%%-------------------------------------------------------------------
%%% @author francesco
%%% @copyright (C) 2019, ROC-Connect
%%% @doc
%%% @end
%%% Created : 30. gen 2018 14:13
%%%-------------------------------------------------------------------
-module(core3_lumix_sup).
-author("francesco").
-behavior(supervisor).

-include("rtrace.hrl").

-define(SERVER, ?MODULE).
%% API
-export([init/1, start_link/1, start_link/0, delete/1, restart/1, status/1, count/0, list/0, add/1]).

-on_load(loaded/0).
loaded() ->
	?cyan("~p LOADED", [?MODULE]).


start_link() ->
	start_link(#{}).
start_link(Args) ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, [Args]).


init(_) ->

	SupFlags = #{
		strategy => one_for_one,
		intensity => 100,
		period => 10
	},
	ChildSpecs = [

		#{
			id => lg_air_multiplex,
			modules => [lg_air_multiplex],
			restart => permanent,
			shutdown => 1000,
			start => {lg_air_multiplex, start_link, []},
			type => worker
		}

	],
	?cyan("<lg_air_multiplex/> <ySUPERVISOR init/> starting~n ~p", [ChildSpecs]),
	{ok, {SupFlags, ChildSpecs}}.

add(#{id := ChildID} = ChildSpec) ->
	?yellow("~p", [ChildSpec]),
	%todo renable this we should check if the modules needed are loaded...
%%	case code:is_loaded(utils:ensure_atom(ChildID)) of
%%		false -> error_module_not_found;
%%		_ ->
	?cyan("childspec ok:~p check if it exists", [ChildID]),
	case supervisor:get_childspec(?MODULE, ChildID) of
		not_found ->
			?green("adding new childspec:~p", [ChildSpec]),
			supervisor:start_child(?MODULE, ChildSpec);
		OldSpec ->
			?orange("removing old child_spec:~p and inserting new one ~p", [OldSpec, ChildSpec]),
			supervisor:terminate_child(?MODULE, ChildID),
			supervisor:delete_child(?MODULE, ChildID),
			supervisor:start_child(?MODULE, ChildSpec)
	end.

%%	end.

delete(ChildID) ->
	supervisor:terminate_child(?MODULE, ChildID),
	supervisor:delete_child(?MODULE, ChildID).

restart(ChildID) ->
	supervisor:terminate_child(?MODULE, ChildID),
	supervisor:restart_child(?MODULE, ChildID).

status(ChildID) ->
	supervisor:get_childspec(?MODULE, ChildID).

count() ->
	supervisor:count_children(?MODULE).

list() ->
	supervisor:which_children(?MODULE).
