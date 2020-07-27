%%%-------------------------------------------------------------------
%%% @author francesco
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%   helper file for shared libs and test functions
%%% @end
%%% Created : 13. Dez 2019 15:18
%%%-------------------------------------------------------------------
-module(lumix_utils).
-author("francesco").
-include_lib("common.hrl").

-export([tempLoop/2]).

tempLoop(0, LastTemp) ->
	?red("done looping ~p", [LastTemp]);

tempLoop(LoopCount, LastTemp) when LastTemp =< 29 ->
	Temp = LastTemp + 1,
	?green("sending ~p", [LastTemp + 1]),
	lumix_multiplex:send_to_device(<<"5557/T">>, list_to_binary(integer_to_list(Temp))),
	tempLoop(LoopCount - 1, LastTemp + 1);

tempLoop(LoopCount, LastTemp) when LastTemp =:= 30 ->
	Temp = LastTemp-1,
	?green("LoopCount:~p sending ~p", [LoopCount, LastTemp - 1]),
	lumix_multiplex:send_to_device(<<"5557/T">>, list_to_binary(integer_to_list(Temp))),
	tempLoop(LoopCount - 1, LastTemp - 1).
