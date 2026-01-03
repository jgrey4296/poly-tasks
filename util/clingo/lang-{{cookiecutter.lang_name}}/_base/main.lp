% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

% -- settings
%% pasp-arg: --help=2
%% pasp-arg: --pre=aspif
%% pasp-arg: --text
%% pasp-arg: --output reify

%% for json output:
%% pasp-arg: --outf=2

% --output-debug=all

% pasp-arg: -W all
% pasp-arg: --keep-facts
% pasp-arg: --stats=1
% pasp-arg: -n 4
% pasp-arg: --time-limit=5
% pasp-arg: --verbose=2

% #show sum_next/1.
% #show sum_other/1.

#include "src/other.lp".


%-- data
2{val(a;b;c;d)}.

{next(X); other(X)} :- val(X).

sum_next(C) :- C = #count { X : next(X) }.
sum_other(C) :- C = #count { X : other(X) }.

%-- generate
:- val(b).
:- not val(a).
:- sum_next(X), sum_other(Y), X != Y.

%-- test
