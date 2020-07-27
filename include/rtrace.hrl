%%%-------------------------------------------------------------------
%%% @author ahmadster
%%% @doc
%%% Remote Tracing BitBuilder definition file.
%%% @end
%%%-------------------------------------------------------------------
% output colors
-ifdef('TEST').
-define(_red, "").
-define(_green, "").
-define(_blue, "").
-define(_yellow, "").
-define(_orange, "").
-define(_magenta, "").
-define(_cyan, "").
-define(_gray, "").
-define(_white, "").

-define(_bold, "").
-define(_dim, "").
-define(_underline, "").
-define(_blink, "").
-define(_inverted, "").
-define(_normal, "").

-define(_self_color, "").
-define(_module_color, "").
-define(_func_color, "").
-define(_arity_color, "").
-else.
-define(_normal, "\e[00m").
-define(_gray, "\e[01;90m").
-define(_red, "\e[01;31m").
-define(_green, "\e[01;32m").
-define(_yellow, "\e[01;33m").
-define(_blue, "\e[01;34m").
-define(_magenta, "\e[01;35m").
-define(_cyan, "\e[01;36m").
-define(_white, "\e[01;37m").

-define(_orange, "\e[38;5;208m").


-define(_bold, "\e[1m").
-define(_dim, "\e[2m").
-define(_underline, "\e[4m").
-define(_blink, "\e[5m").
-define(_inverted, "\e[7m").


-define(_self_color, ?_gray).
-define(_module_color, ?_gray).
-define(_func_color, ?_gray).
-define(_arity_color, ?_gray).

%%-define(_self_color, "\e[38;5;217m").
%%-define(_module_color, "\e[38;5;76m").
%%-define(_func_color, "\e[38;5;117m").
%%-define(_arity_color, "\e[38;5;86m").
-endif.

-define(FUNCTION(), element(2, element(2, process_info(self(), current_function)))).
-define(ARITY(), element(3, element(2, process_info(self(), current_function)))).
%
-define(rtrace(C__r, F__r, P__r), rtrace:out(
	?_dim ++
		?_self_color ++ "~p : " ++
		?_module_color ++ "~p : ~p : " ++
		?_func_color ++ "~p/" ++ ?_arity_color ++ "~p~n" ++
		?_normal ++ ?C__r ++ F__r ++ "~n" ++ ?_normal,
	lists:append([self(), ?MODULE, ?LINE, ?FUNCTION(), ?ARITY()], P__r), ?MODULE,self())
).

%% Passing the state is now allowed for the new framework
-define(rtrace(C__r, F__r, P__r,State), rtrace:out(
	?_dim ++
		?_self_color ++ "~p : " ++
		?_module_color ++ "~p : ~p : " ++
		?_func_color ++ "~p/" ++ ?_arity_color ++ "~p~n" ++
		?_normal ++ ?C__r ++ F__r ++ "~n" ++ ?_normal,
	lists:append([self(), ?MODULE, ?LINE, ?FUNCTION(), ?ARITY()], P__r), ?MODULE,self(),State)).
%% =============================================================


-define(colorize(T__r, N__r),
	re:replace(
		re:replace(
			re:replace(
				re:replace(
					re:replace(
						re:replace(
							re:replace(
								re:replace(
									re:replace(
										re:replace(
											re:replace(
												re:replace(
													re:replace(
														re:replace(
															re:replace(
																re:replace(T__r, "<n\s?", ?_normal,
																	[{return, list}, global]),
																"<w\s?", ?_white, [{return, list}, global]),
															"<i\s?", ?_inverted, [{return, list}, global]),
														"<a\s?", ?_gray, [{return, list}, global]),
													"<c\s?", ?_cyan, [{return, list}, global]),
												"<m\s?", ?_magenta, [{return, list}, global]),
											"<o\s?", ?_orange, [{return, list}, global]),
										"<y\s?", ?_yellow, [{return, list}, global]),
									"<b\s?", ?_blue, [{return, list}, global]),
								"<g\s?", ?_green, [{return, list}, global]),
							"<r\s?", ?_red, [{return, list}, global]),
						"<d\s?", ?_dim, [{return, list}, global]),
					"<l\s?", ?_blink, [{return, list}, global]),
				"<u\s?", ?_underline, [{return, list}, global]),
			"<e\s?", ?_bold, [{return, list}, global]),
		"\s?/>", ?_normal ++ N__r,
		[{return, list}, global])
).
%%% =============================================================


-define(red(P__r), ?rtrace(_red, ?colorize(P__r, ?_red), [])).
-define(red(F__r, P__r), ?rtrace(_red, ?colorize(F__r, ?_red), P__r)).

-define(green(P__r), ?rtrace(_green, ?colorize(P__r, ?_green), [])).
-define(green(F__r, P__r), ?rtrace(_green, ?colorize(F__r, ?_green), P__r)).

-define(blue(P__r), ?rtrace(_blue, ?colorize(P__r, ?_blue), [])).
-define(blue(F__r, P__r), ?rtrace(_blue, ?colorize(F__r, ?_blue), P__r)).

-define(yellow(P__r), ?rtrace(_yellow, ?colorize(P__r, ?_yellow), [])).
-define(yellow(F__r, P__r), ?rtrace(_yellow, ?colorize(F__r, ?_yellow), P__r)).

-define(orange(P__r), ?rtrace(_orange, ?colorize(P__r, ?_orange), [])).
-define(orange(F__r, P__r), ?rtrace(_orange, ?colorize(F__r, ?_orange), P__r)).

-define(magenta(P__r), ?rtrace(_magenta, ?colorize(P__r, ?_magenta), [])).
-define(magenta(F__r, P__r), ?rtrace(_magenta, ?colorize(F__r, ?_magenta), P__r)).

-define(cyan(P__r), ?rtrace(_cyan, ?colorize(P__r, ?_cyan), [])).
-define(cyan(F__r, P__r), ?rtrace(_cyan, ?colorize(F__r, ?_cyan), P__r)).

-define(gray(P__r), ?rtrace(_gray, ?colorize(P__r, ?_gray), [])).
-define(gray(F__r, P__r), ?rtrace(_gray, ?colorize(F__r, ?_gray), P__r)).

-define(white(P__r), ?rtrace(_white, ?colorize(P__r, ?_white), [])).
-define(white(F__r, P__r), ?rtrace(_white, ?colorize(F__r, ?_white), P__r)).

-define(bold(P__r), ?rtrace(_bold, ?colorize(P__r, ?_bold), [])).
-define(bold(F__r, P__r), ?rtrace(_bold, ?colorize(F__r, ?_bold), P__r)).

-define(dim(P__r), ?rtrace(_dim, ?colorize(P__r, ?_dim), [])).
-define(dim(F__r, P__r), ?rtrace(_dim, ?colorize(F__r, ?_dim), P__r)).

-define(underline(P__r), ?rtrace(_underline, ?colorize(P__r, ?_underline), [])).
-define(underline(F__r, P__r), ?rtrace(_underline, ?colorize(F__r, ?_underline), P__r)).

-define(blink(P__r), ?rtrace(_blink, ?colorize(P__r, ?_blink), [])).
-define(blink(F__r, P__r), ?rtrace(_blink, ?colorize(F__r, ?_blink), P__r)).

-define(inverted(P__r), ?rtrace(_inverted, ?colorize(P__r, ?_inverted), [])).
-define(inverted(F__r, P__r), ?rtrace(_inverted, ?colorize(F__r, ?_inverted), P__r)).

-define(normal(P__r), ?rtrace(_normal, ?colorize(P__r, ?_normal), [])).
-define(normal(F__r, P__r), ?rtrace(_normal, ?colorize(F__r, ?_normal), P__r)).

-define(out(P__r), ?rtrace(_normal, ?colorize(P__r, ?_normal), [])).
-define(out(F__r, P__r), ?rtrace(_normal, ?colorize(F__r, ?_normal), P__r)).
%% =============================================================


%% Passing the state to be compliant to the new logging framework
-define(red(F__r, P__r, State), ?rtrace(_red, ?colorize(F__r, ?_red), P__r, State)).

-define(green(F__r, P__r, State), ?rtrace(_green, ?colorize(F__r, ?_green), P__r, State)).

-define(blue(F__r, P__r, State), ?rtrace(_blue, ?colorize(F__r, ?_blue), P__r, State)).

-define(yellow(F__r, P__r, State), ?rtrace(_yellow, ?colorize(F__r, ?_yellow), P__r, State)).

-define(orange(F__r, P__r, State), ?rtrace(_orange, ?colorize(F__r, ?_orange), P__r, State)).

-define(magenta(F__r, P__r, State), ?rtrace(_magenta, ?colorize(F__r, ?_magenta), P__r, State)).

-define(cyan(F__r, P__r, State), ?rtrace(_cyan, ?colorize(F__r, ?_cyan), P__r, State)).

-define(gray(F__r, P__r, State), ?rtrace(_gray, ?colorize(F__r, ?_gray), P__r, State)).

-define(white(F__r, P__r, State), ?rtrace(_white, ?colorize(F__r, ?_white), P__r, State)).

-define(bold(F__r, P__r, State), ?rtrace(_bold, ?colorize(F__r, ?_bold), P__r, State)).

-define(dim(F__r, P__r, State), ?rtrace(_dim, ?colorize(F__r, ?_dim), P__r, State)).

-define(underline(F__r, P__r, State), ?rtrace(_underline, ?colorize(F__r, ?_underline), P__r, State)).

-define(blink(F__r, P__r, State), ?rtrace(_blink, ?colorize(F__r, ?_blink), P__r, State)).

-define(inverted(F__r, P__r, State), ?rtrace(_inverted, ?colorize(F__r, ?_inverted), P__r, State)).

-define(normal(F__r, P__r, State), ?rtrace(_normal, ?colorize(F__r, ?_normal), P__r, State)).

-define(out(F__r, P__r, State), ?rtrace(_normal, ?colorize(F__r, ?_normal), P__r, State)).
%% =============================================================




-define(rtrace_test(), ?gray(
	"Hello. This rtrace!~nIt is a multi-color tracing macro set that support html-style output. For example, this line has <r red />, <g green />, <b blue />, <y yellow />, <o orange />, <m magenta />, <c cyan />, <white>white</white>, and <a gray /> colored text.~nSome text can also be <e>bold</e> <u underline /> <d dim /> <l blink /> <i>inverted</i> or <n>normal</n>. You can't, however, <r you can <l embed /> colors />... yet.")).

%%============ LAGER MACROS ============================================================================================
%%-ifdef(mnesia).
%%-define(LAGER(LEVEL, MSG, PARAMS),
%%	rtrace:syslog(LEVEL, self(), ?MODULE, ?FUNCTION_NAME, ?LINE, ?FUNCTION_ARITY, os:getenv("NODE_IP"), MSG, PARAMS),
%%	lager:log(LEVEL,[{pid, self()}, {module, ?MODULE}, {function, ?FUNCTION_NAME}, {line, ?LINE}, {arity, ?FUNCTION_ARITY}, {ip, os:getenv("NODE_IP")}], MSG, PARAMS)).
%%-else.
-define(LAGER(LEVEL, MSG, PARAMS), rtrace:syslog(LEVEL, self(), ?MODULE, ?FUNCTION_NAME, ?LINE, ?FUNCTION_ARITY, MSG++"~n", PARAMS)).
%-endif.

%% Two params
-define(NONE(MSG, PARAMS), ?LAGER(none, MSG, PARAMS)).
-define(DEBUG(MSG, PARAMS), ?LAGER(debug, MSG, PARAMS)).
-define(INFO(MSG, PARAMS), ?LAGER(info, MSG, PARAMS)).
-define(NOTICE(MSG, PARAMS), ?LAGER(notice, MSG, PARAMS)).
-define(WARNING(MSG, PARAMS), ?LAGER(warning, MSG, PARAMS)).
-define(ERROR(MSG, PARAMS), ?LAGER(error, MSG, PARAMS)).
-define(CRITICAL(MSG, PARAMS), ?LAGER(critical, MSG, PARAMS)).
-define(ALERT(MSG, PARAMS), ?LAGER(alert, MSG, PARAMS)).
-define(EMERGENCY(MSG, PARAMS), ?LAGER(emergency, MSG, PARAMS)).

%%One params
-define(NONE(MSG), ?LAGER(none, MSG, [])).
-define(DEBUG(MSG), ?LAGER(debug, MSG, [])).
-define(INFO(MSG), ?LAGER(info, MSG, [])).
-define(NOTICE(MSG), ?LAGER(notice, MSG, [])).
-define(WARNING(MSG), ?LAGER(warning, MSG, [])).
-define(ERROR(MSG), ?LAGER(error, MSG, [])).
-define(CRITICAL(MSG), ?LAGER(critical, MSG, [])).
-define(ALERT(MSG), ?LAGER(alert, MSG, [])).
-define(EMERGENCY(MSG), ?LAGER(emergency, MSG, [])).

%%======================================================================================================================
