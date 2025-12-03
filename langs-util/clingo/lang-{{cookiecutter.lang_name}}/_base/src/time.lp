% -*- mode:pasp; -*-
% Purpose:
%
%
% Outputs:

#external horizon.

% Create a sequence of instances from 0 to the externally set horizon.
start(0).
final(horizon).
instant(0..T) :- final(T).
% and breadcrumb them together
next(T, T+1)  :- instant(T).

_time.
