#!/usr/bin/env -S swipl -t halt
%% -t halt : stops entering the repl
%% from https://stackoverflow.com/questions/25467090

%% Setup:
%% :- set_prolog_flag(verbose, silent).
%% Load other files:
:- use_module(src/rules).
:- [data/basic].
%% Set the program entry point:
:- initialization(main).

main :-
    current_prolog_flag(argv, [Argv|_]),
    place(Argv),
    getPairedPerson(X, Argv),
    likes(X, Y),
    format("Got: ~q~n", Argv),
    format("Result: ~q likes ~q in ~q~n", [X, Y, Argv]),
    halt(0).

main :-
    format("Call with a location: london/cairo/ny.~n"),
    halt(1).

