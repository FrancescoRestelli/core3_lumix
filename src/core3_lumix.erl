%%%-------------------------------------------------------------------
%%% @author Alfredo
%%% @copyright (C) 2019, ROC-Connect
%%% @doc
%%%
%%% @end
%%% Created : 24. lug 2019 11:46
%%%-------------------------------------------------------------------
-module(core3_lumix).
-author("Alfredo").

-behaviour(application).

%% Application callbacks
-export([start/2,
  stop/1]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

start(_StartType, _StartArgs) ->
 core3_lg_air_sup:start_link().


stop(_State) ->
  ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================
